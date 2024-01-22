import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  static RewardedAd? rewardedAd;
  int rewardedAttempts = 0;

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: dotenv.env['ADS_ID']??"default",
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
          rewardedAttempts = 0;
        },
        onAdFailedToLoad: (error) {
          rewardedAttempts++;
          rewardedAd = null;
          if (kDebugMode) {
            print('failed to load${error.message}');
          }

          if (rewardedAttempts <= 5) {
            createRewardedAd();
          }
        },
      ),
    );
  }

  showInterstitialAd() {
    if (rewardedAd == null) {
      if (kDebugMode) {
        print('trying to show before loading');
      }
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => print('ad showed $ad'),
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        if (kDebugMode) {
          print('failed to show the ad $ad');
        }
        createRewardedAd();
      },
    );
    rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        print("reward");
      },
    );
    rewardedAd = null;
  }
}
