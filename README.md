# fbsample

R Package for Quota Sampling on Facebook

This R package makes it easier for one to conduct quota sampling via Facebook advertisements. `fbsample` serves two main functions. First, it allows one to specify which demographic groups to target. Second, it uses R wrapper functions in [fbRads](https://github.com/cardcorp/fbRads) to create ads in batches and upload them via the [Facebook Marketplace API](https://developers.facebook.com/docs/marketing-apis).

-----------------------------

## Updates

3/18/2017: I added four helpful datasets in the `data` folder that include the ids and keys for ad targets. Now you can easily look up targets for level of education, ethnicity (US), politics (US), and US states/regions.

3/19/2017: Facebook as removed `ethnic_affinity` as an ad target category after receiving negative press. But you can still recruit people by ethnic affinity using the `behavior` category. I removed `ethnic_affinity` as a parameter from the function `create_target` to reflect this change. To sample white respondents, you would need to exclude all the minority ethnic affinity groups. I am providing this information for social scientific purposes only. Don't use the functionality for racist purposes! 

-----------------------------

## In a nutshell

Facebook allows advertisers to target audiences by demographic groups. Using the [Facebook Marketing API](https://developers.facebook.com/docs/marketing-apis), researchers can create ads that target a large number of strata for quota sampling. Researchers recruit respondents by advertising their online survey using Facebook ads. 

## Understanding the structure of Facebook ad campaigns

Facebook ad campaigns have a three-level structure. For the purposes of quota sampling, each sampling project is a **Campaign**. The Campaign objective determines how you pay to recruit respondents. For instance, you can pay for per completed survey using the [conversion objective](https://www.facebook.com/business/learn/facebook-create-ad-website-conversions) or you can pay for clicks to your survey link. 

Targeting of individual strata occurs at the **Ad set** level. For each Ad set, you input the demographics of the strata and how much you are willing to spend to advertise to that strata. Finally, for each **Ad set**, you create an **Ad** that uses an **Ad Creative** (ad text, image, and survey link) to recruit respondents. 

![](https://static1.squarespace.com/static/56c4d0b94d088e1c92d242af/t/5723e35e746fb941a5c16fdb/1461969760920/?format=750w)

## How to quota sample using Facebook ads

1. Set up a [Facebook Page](https://www.facebook.com/business/learn/set-up-facebook-page) so you can create and manage ads.

2. Create a Facebook App and authorize it to manage the ads of your Facebook Page. Follow the directions outlined in [fbRads](https://github.com/cardcorp/fbRads/blob/master/README.md) to crate your Facebook App and connect with the OAuth token. 

3. Draft [a post](https://www.facebook.com/business/learn/facebook-page-create-posts) for your Facebook Page that you will use as your [Ad Creative](https://developers.facebook.com/docs/marketing-api/reference/ad-creative). The post should contain a catchy image, a short description of your survey, and a link to your survey. Do not publish the post but instead save it as a draft to be published later as part of your ad. 

4. Use `fb_campaign` in `fbRads` to create a [Campaign](https://developers.facebook.com/docs/marketing-api/reference/ad-campaign-group) for your quota sample. All ads will be a part of this campaign. 

5. Use `create_target` in `fbsample` to create [demographic targets](https://www.facebook.com/business/a/online-sales/ad-targeting-details) for each strata in your quota sample. In addition to each strata's demographics information, you should also provide information about how much you plan to spend on each strata.

6. Use `batch_strata_ads` in `fbsample` to create ads for each strata in your quota sample. For each strata, the function creates an Ad set and an Ad. 

