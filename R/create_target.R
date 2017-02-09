#' Create targeting attributes for a strata
#' @param strata_id character. Strata ID.
#' @param geo_locations list. A list specifying geographic location of the strata. See \url{https://developers.facebook.com/docs/marketing-api/buying-api/targeting#location}.
#' @param age_min integer. 	Minimum age. If used, must be 13 or higher. Default to 18.
#' @param age_max integer. Maximum age. If used, must be 65 or lower.
#' @param genders integer. 1=male, 2=female.
#' @param education_statuses integer. Vector of Facebook IDs to target based on education level. See \url{https://developers.facebook.com/docs/marketing-api/targeting-specs/v2.8}.
#' @param ethnic_affinity integer. Vector of Facebook IDs for each ethnic group.
#' @param interests list. A list of Facebook IDs for interests.
#' @param behaviors list. A list of Facebook IDs for behaviors.
#' @param exclusions list. A list of Facebook IDs for excluding certain demographics.
#' @param other_demographics list. A list of Facebook IDs for other demographic targeting parameters.
#' @param bid_amount integer. The amount you set for bid and budget are at ad account currencies minimum denomination level. For example cents for US dollars.
#' @param is_autobid logical. If \code{TRUE}, bidding amount is automated and you do not need to include a \code{bid_amount}.
#' @param daily_budget integer. The amount you set for bid and budget are at ad account currencies minimum denomination level. For example cents for US dollars.
#' @param creative_id character. Creative ID that identifies the ad creative object you plan to display as your ad. See \url{https://developers.facebook.com/docs/marketing-api/reference/ad-creative}.
#' @param adset_status character. Ad Set status.
#' @param ad_status character. Ad status.
#' @param start_time (optinal) UTC UNIX timestamp.
#' @param end_time (optional) UTC UNIX timestamp.
#' @return A list with targeting attributes for a strata that can be used to create ads.
#' @export
#' @references \url{https://developers.facebook.com/docs/marketing-api/buying-api/targeting}

create_target <-
  function(strata_id,
           geo_locations,
           age_min = NULL,
           age_max = NULL,
           genders = NULL,
           education_statuses = NULL,
           ethnic_affinity = NULL,
           interests = NULL,
           behaviors = NULL,
           exclusions = NULL,
           other_demographics = NULL,
           is_autobid = FALSE,
           bid_amount = NULL,
           daily_budget,
           adset_status = c("ACTIVE", "PAUSED"),
           ad_status = c("ACTIVE", "PAUSED"),
           start_time = NULL,
           end_time = NULL,
           creative_id) {
    if (is.null(geo_locations)) {
      stop("You must provide at least one geographic location.")
    } else {
      targets <-
        list(geo_locations = geo_locations)
      if (!is.null(age_min)) {
        targets$age_min = unbox(age_min)
      }
      if (!is.null(age_max)) {
        targets$age_max = unbox(age_max)
      }
      if (!is.null(genders)) {
        targets$genders = list(genders)
      }
      if (!is.null(education_statuses)) {
        targets$education_statuses = list(education_statuses)
      }
      if (!is.null(ethnic_affinity)) {
        targets$ethnic_affinity = data.frame(id = ethnic_affinity)
      }
      if (!is.null(interests)) {
        targets$interests = interests
      }
      if (!is.null(behaviors)) {
        targets$behaviors = behaviors
      }
      if (!is.null(exclusions)) {
        targets$exclusions = exclusions
      }
      if (!is.null(other_demographics)) {
        targets <- c(targets, other_demographics)
      }
    }

    return(list(strata_id = strata_id,
                targets = targets,
                is_autobid = is_autobid,
                bid_amount = bid_amount,
                daily_budget = daily_budget,
                adset_status = adset_status,
                ad_status = ad_status,
                creative_id = creative_id,
                start_time = start_time,
                end_time = end_time
                ))
  }
