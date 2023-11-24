// ignore_for_file: unused_import

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:talklytic/API/Api_helper.dart';
import 'package:talklytic/Bloc/Trending_gif/trending_gif_bloc.dart';

import 'package:talklytic/Screen/Auth/Screens/Responsive/desktop_view.dart';
import 'package:talklytic/Screen/Auth/Screens/login_page.dart';
import 'package:talklytic/splashScreen.dart';
import 'package:talklytic/Screen/desktop_scaffold.dart';
import 'package:talklytic/Screen/mobile_scaffold.dart';
import 'package:talklytic/Screen/tablet_scaffold.dart';
 
import 'Responsive/homepage.dart';
import 'Screen/Auth/Screens/Responsive/mobile_view.dart';
import 'Screen/Auth/Screens/WelcomeScreen.dart';
import 'Screen/Personal/profile.dart';
import 'Screen/Personal/settings.dart';
import 'Screen/chat_screen.dart';
import 'Screen/widgets/mapWidget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
  } else {
    // MobileAds.instance.initialize();
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => TrendingGifBloc(apiHelper: ApiHelper()),
    child: const MyApp(),
  ));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(
        mobileScaffold: SplashScreenPage(),
        tabletScaffold: TabletScaffold(),
        desktopScaffld: DesktopAuthScreen(),
      ),
      // home:const MapPage(),
    );
  }

  void initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
