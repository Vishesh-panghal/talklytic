// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AppSettingPage extends StatefulWidget {
//   const AppSettingPage({super.key});

//   @override
//   State<AppSettingPage> createState() => _AppSettingPageState();
// }

// class _AppSettingPageState extends State<AppSettingPage> {
//   InterstitialAd? _interstitialAd;
//   @override
//   void initState() {
//     loadAd();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Setting')),
//       body: Column(
//         children: [
//           Expanded(child: Center(child:Text('Setting'))),
//           Container(
//             alignment: Alignment.bottomCenter,
//             height: 80,
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: AdWidget(
//                 ad: BannerAd(
//                   size: AdSize.banner,
//                   adUnitId: 'ca-app-pub-3940256099942544/2934735716',
//                   listener: BannerAdListener(),
//                   request: const AdRequest(),
//                 )..load(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void showInterstitialAd() {
//     if (_interstitialAd != null) {
//       _interstitialAd?.show();
//     } else {
//       debugPrint('Interstitial Ad is not loaded yet.');
//     }
//   }

//   void loadAd() {
//     InterstitialAd.load(
//         adUnitId: 'ca-app-pub-3940256099942544/4411468910',
//         request: AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (ad) {
//             ad.fullScreenContentCallback = FullScreenContentCallback(
//               onAdShowedFullScreenContent: (ad) {},
//               onAdImpression: (ad) {},
//               onAdFailedToShowFullScreenContent: (ad, error) {
//                 ad.dispose();
//               },
//               onAdDismissedFullScreenContent: (ad) {
//                 ad.dispose();
//               },
//               onAdClicked: (ad) {},
//             );
//             debugPrint('$ad loaded');
//             _interstitialAd = ad;
//           },
//           onAdFailedToLoad: (error) {
//             debugPrint('Interstitial Ad failded to load: $error');
//           },
//         ));
//   }
// }
