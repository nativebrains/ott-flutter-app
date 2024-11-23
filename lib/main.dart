import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamforever/constants/app_colors.dart';
import 'package:islamforever/constants/routes_names.dart';
import 'package:islamforever/core/error_widget/error_widget.dart';
import 'package:islamforever/features/common/providers/CommonProvider.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:islamforever/firebase_options.dart';
import 'package:islamforever/routes/routes.dart';
import 'package:provider/provider.dart';

import 'core/services/shared_preference.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ErrorWidget.builder = (FlutterErrorDetails details) => CustomError(
        errorDetails: details,
      );
  await SharedPrefs.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
  FlutterNativeSplash.remove();
}

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommonProvider>(
          create: (ctx) => CommonProvider(),
        ),
        ChangeNotifierProvider<DashboardProvider>(
          create: (ctx) => DashboardProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: ColorCode.scaffoldBackgroundColor,
              primaryColor: ColorCode.mainColor,
              canvasColor: ColorCode.scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(
                color: ColorCode.mainColor,
              ),
              secondaryHeaderColor: ColorCode.mainColor,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            onGenerateRoute: RouterGenerator.generateRoute,
            initialRoute: RouteConstantName.splashScreen,
          );
        },
      ),
    );
  }
}
