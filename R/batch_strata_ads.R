#' Create Facebook ads for a batch of strata
#' @param fbacc \code{FB_Ad_account} object that identifies your Facebook Ad account. Note this is not your Ad account number.
#' @param strata_targeting list. Information about each strata that you plan to target.
#' @param optimization_goal character. Optimization goal.
#' @param billing_event character. The billing event.
#' @param promoted_object list. See at \url{https://developers.facebook.com/docs/marketing-api/reference/ad-campaign/promoted-object}.
#' @param campaign_id character. Parent Ad Campaign ID.
#' @param wait_interval integer. Number of seconds to wait between creation of each ad to avoid exceeding the API rate limit.
#' @param show_wait logical. If \code{TRUE}, the console will display a wait time progress bar.
#' @param ... further arguments passed to the API endpoint
#' @return A data.frame with Strata IDs, Ad Set IDs, Ad IDs for ads that have been successfully created.
#' @import fbRads
#' @export
#' @references \url{https://developers.facebook.com/docs/marketing-api/reference/ad-campaign#Creating}

batch_strata_ads <- function(fbacc,
                             strata_targeting,
                             optimization_goal = c(
                               'NONE',
                               'APP_INSTALLS',
                               'CLICKS',
                               'ENGAGED_USERS',
                               'EXTERNAL',
                               'EVENT_RESPONSES',
                               'IMPRESSIONS',
                               'LINK_CLICKS',
                               'OFFER_CLAIMS',
                               'OFFSITE_CONVERSIONS',
                               'PAGE_ENGAGEMENT',
                               'PAGE_LIKES',
                               'POST_ENGAGEMENT',
                               'REACH',
                               'SOCIAL_IMPRESSIONS',
                               'VIDEO_VIEWS'
                             ),
                             billing_event = c(
                               'APP_INSTALLS',
                               'CLICKS',
                               'IMPRESSIONS',
                               'LINK_CLICKS',
                               'OFFER_CLAIMS',
                               'PAGE_LIKES',
                               'POST_ENGAGEMENT',
                               'VIDEO_VIEWS'
                             ),
                             promoted_object,
                             campaign_id,
                             wait_interval = 100,
                             show_wait,
                             ...) {
  ## progress bar
  total <- 20
  pb <- txtProgressBar(
    min = 0,
    max = 10,
    style = 3,
    title = "Waiting for next ad upload."
  )
  ## check the number of strata
  num_strata <- sum(names(unlist(strata_targeting)) == "strata_id")
  ## upload ads
  if (num_strata > 1) {
    ## upload ads one by one, with wait time between each upload to avoid
    ## exceeding API limit rate
    strata_output <- data.frame(strata_id = rep(NA, length(strata_targeting)),
                                adset_id = rep(NA, length(strata_targeting)),
                                ad_id = rep(NA, length(strata_targeting)))
    for (i in 1:length(strata_targeting)) {
      tryCatch (
        strata_output[i,] <- strata_ad(
          fbacc = fbacc,
          adset_name = paste0("Ad set: ", strata_targeting[[i]]$strata_id),
          optimization_goal = optimization_goal,
          billing_event = billing_event,
          campaign_id = campaign_id,
          bid_amount = strata_targeting[[i]]$bid_amount,
          adset_status = strata_targeting[[i]]$adset_status,
          daily_budget = strata_targeting[[i]]$daily_budget,
          ad_status = strata_targeting[[i]]$ad_status,
          targeting = strata_targeting[[i]]$targets,
          creative_id = strata_targeting[[i]]$creative_id,
          start_time = strata_targeting[[i]]$start_time,
          end_time = strata_targeting[[i]]$end_time,
          ad_name = paste0("Ad: ", strata_targeting[[i]]$strata_id),
          strata_id = strata_targeting[[i]]$strata_id
        ),
        error = function(e) {
          message(e)
          message(paste0(strata_targeting[[i]]$strata_id, ": ad could not be created."))
        },
        finally = {
          if (i != length(strata_targeting)) {
            message(
              paste0(
                "Wait ",
                wait_interval ,
                " seconds for next ad to be created. ",
                i,
                " out of ",
                length(strata_targeting),
                " ads created."
              )
            )
          } else {
            message(paste0("\n", i, " out of ", length(strata_targeting), " ads created."))
          }
        }
      )

      ## wait time progress bar
      if (i != length(strata_targeting) & show_wait) {
        for (i in 1:total) {
          Sys.sleep(wait_interval / total)
          setTxtProgressBar(pb, i)
        }
        close(pb)
      }
    }
  } else if (num_strata == 1) {
    strata_output <- data.frame(strata_id = NA,
                                adset_id = NA,
                                ad_id = NA)
      tryCatch (
        strata_output[1,] <- strata_ad(
          fbacc = fbacc,
          adset_name = paste0("Ad set: ", strata_targeting$strata_id),
          optimization_goal = optimization_goal,
          billing_event = billing_event,
          campaign_id = campaign_id,
          bid_amount = strata_targeting$bid_amount,
          adset_status = strata_targeting$adset_status,
          daily_budget = strata_targeting$daily_budget,
          ad_status = strata_targeting$ad_status,
          targeting = strata_targeting$targets,
          creative_id = strata_targeting$creative_id,
          start_time = strata_targeting$start_time,
          end_time = strata_targeting$end_time,
          ad_name = paste0("Ad: ", strata_targeting$strata_id),
          strata_id = strata_targeting$strata_id
        ),
        error = function(e) {
          message(e)
          message(paste0(strata_targeting$strata_id, ": ad could not be created."))
        },
        finally = {
            message(paste0("\n", 1, " out of ", 1, " ads created."))
          }
      )
  } else {
    message("Error: the number of strata is undefined.")
  }

  ## return data.frame with Ad Set IDs and Ad IDs of successful ad creations
  return(strata_output)
}
