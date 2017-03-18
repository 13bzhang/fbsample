#' Create a Facebook ad for a strata
#' @param fbacc \code{FB_Ad_account} object that identifies your Facebook Ad account. Note this is not your Ad account number.
#' @param strata_id character. Strata ID.
#' @param adset_name character. Name of the Ad Set.
#' @param optimization_goal character. Optimization goal.
#' @param billing_event character. The billing event.
#' @param bid_amount integer. The amount you set for bid and budget are at ad account currencies minimum denomination level. For example cents for US dollars.
#' @param promoted_object list. See at \url{https://developers.facebook.com/docs/marketing-api/reference/ad-campaign/promoted-object}.
#' @param campaign_id character. Parent Ad Campaign ID.
#' @param is_autobid logical. If \code{TRUE}, bidding amount is automated and you do not need to include a \code{bid_amount}.
#' @param daily_budget integer. The amount you set for bid and budget are at ad account currencies minimum denomination level. For example cents for US dollars.
#' @param end_time UTC UNIX timestamp.
#' @param start_time UTC UNIX timestamp.
#' @param targeting list. Describes the demographics of your strata.
#' @param creative_id character. Creative ID that identifies the ad creative object you plan to display as your ad. See \url{https://developers.facebook.com/docs/marketing-api/reference/ad-creative}.
#' @param adset_status character. Ad Set status.
#' @param ad_status character. Ad status.
#' @param ... further arguments passed to the API endpoint
#' @return A data.frame with Strata ID, Ad Set ID, Ad ID
#' @import fbRads
#' @export
#' @references \url{https://developers.facebook.com/docs/marketing-api/reference/ad-campaign#Creating}

strata_ad <- function(fbacc,
                      strata_id,
                      adset_name,
                      ad_name,
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
                      bid_amount,
                      promoted_object,
                      campaign_id,
                      is_autobid = FALSE,
                      status = c('ACTIVE', 'PAUSED', 'ARCHIVED', 'DELETED'),
                      daily_budget,
                      end_time = NULL,
                      start_time = NULL,
                      creative_id,
                      targeting,
                      adset_status = c("ACTIVE", "PAUSED"),
                      ad_status = c("ACTIVE", "PAUSED"),
                      ...) {

  ## create the ad set
  adset <-
    fbRads::fbad_create_adset(fbacc = fbacc,
      name = adset_name,
      optimization_goal = optimization_goal,
      billing_event = billing_event,
      bid_amount = bid_amount,
      is_autobid = is_autobid,
      campaign_id = campaign_id,
      status = adset_status,
      daily_budget = daily_budget,
      start_time = start_time,
      end_time = end_time,
      promoted_object = promoted_object,
      targeting = targeting
    )
  ## create the ad
  ad <-
    fbRads::fbad_create_ad(
      fbacc = fbacc,
      name = ad_name,
      campaign_id = campaign_id,
      creative_id = creative_id,
      adset_id = adset,
      status = ad_status
    )
  # return strata ID, ad set ID, and ad ID
  return(c(
      strata_id = as.character(strata_id),
      adset_id = as.character(adset),
      ad_id = as.character(ad)
    ))
}

