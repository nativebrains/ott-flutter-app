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
import 'package:islamforever/features/account/providers/AccountProvider.dart';
import 'package:islamforever/features/authentication/providers/AuthenticationProvider.dart';
import 'package:islamforever/features/common/providers/CommonProvider.dart';
import 'package:islamforever/features/dashboard/providers/DashboardProvider.dart';
import 'package:islamforever/features/details/providers/DetailsProvider.dart';
import 'package:islamforever/features/purchase/providers/PurchaseProvider.dart';
import 'package:islamforever/features/settings/providers/NotificationPermissionHandler.dart';
import 'package:islamforever/features/settings/providers/SettingsProvider.dart';
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
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (ctx) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider<DetailsProvider>(
          create: (ctx) => DetailsProvider(),
        ),
        ChangeNotifierProvider<NotificationPermissionHandler>(
          create: (ctx) => NotificationPermissionHandler(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (ctx) => SettingsProvider(),
        ),
        ChangeNotifierProvider<AccountProvider>(
          create: (ctx) => AccountProvider(),
        ),
        ChangeNotifierProvider<PurchaseProvider>(
          create: (ctx) => PurchaseProvider(),
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
              primaryColor: ColorCode.greenStartColor,
              canvasColor: ColorCode.scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(
                color: ColorCode.greenStartColor,
              ),
              secondaryHeaderColor: ColorCode.greenStartColor,
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
