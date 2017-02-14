# fbsample

R Package for Quota Sampling on Facebook

This R package makes it easier for one to conduct quota sampling via Facebook advertisements. `fbsample` serves two main functions. First, it allows one to specify which demographic groups to target. Second, it uses R wrapper functions in [fbRads](https://github.com/cardcorp/fbRads) to create ads in batches and upload them via the [Facebook Marketplace API](https://developers.facebook.com/docs/marketing-apis).

-----------------------------

## How to quota sample using Facebook ads

1. Set up a [Facebook Page](https://www.facebook.com/business/learn/set-up-facebook-page) so you can create and manage ads.

2. Create a Facebook App and authorize it to manage the ads of your Facebook Page. Follow the directions outlined in [fbRads](https://github.com/cardcorp/fbRads/blob/master/README.md) to crate your Facebook App and connect with the OAuth token. 

3. Draft [a post](https://www.facebook.com/business/learn/facebook-page-create-posts) for your Facebook Page that you will use as your ad. The post should contain a catchy image, a short description of your survey, and a link to your survey. Do not publish the post but instead save it as a draft. You will use this post as an Ad Creative. 

4. Use `fb_campaign` in `fbRads` to create a [Campaign](https://developers.facebook.com/docs/marketing-api/reference/ad-campaign-group) for your quota sample. All ads will be a part of this campaign. 

5. Use `create_target` in `fbsample` to create [demographic targets](https://www.facebook.com/business/a/online-sales/ad-targeting-details) for each strata in your quota sample. In addition to each strata's demographics information, you should also provide information about how much you plan to spend on each strata.

6. Use `batch_strata_ads` in `fbsample` to create ads for each strata in your quota sample. For each strata, the function creates an Ad Set and an Ad. 

