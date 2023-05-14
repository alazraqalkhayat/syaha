import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/fetures/users/presentation/pages/signupPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/util/common.dart';
import 'fetures/users/data/models/userModel.dart';
import 'fetures/users/presentation/pages/editProfilePage.dart';
import 'fetures/users/presentation/pages/loginPage.dart';
import 'injection_container.dart' as dl;
import 'core/app_theme.dart';
import 'dataProviders/local_data_provider.dart';
import 'injection_container.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	// Workmanager().initialize(callbackDispatcher,isInDebugMode: true);

	// await Firebase.initializeApp(
	// 	options: DefaultFirebaseOptions.currentPlatform,
	// );
	SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
		statusBarColor: AppTheme.primaryColor,
		statusBarIconBrightness: Brightness.dark,
	));
	SystemChrome.setPreferredOrientations(
			[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
	await dl.init();
	HttpOverrides.global = MyHttpOverrides();

	runApp(MyApp());
}

class MyApp extends StatefulWidget {

	@override
	State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
	String? _identifier, _onboardingShowen;
	UserModel ?user;

	@override
	void initState() {
		checkUserLoggedIn().fold((l) {
			user = l;
		}, (r) {
			user = null;
		});

		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return GetMaterialApp(
				title: 'سياحة اليمن',
				debugShowCheckedModeBanner: false,
				locale: Locale('ar', 'AE'),
				fallbackLocale: Locale('ar', 'AE'),
				// home:
				theme: ThemeData().copyWith(
					colorScheme: ThemeData().colorScheme.copyWith(
						primary: AppTheme.primaryColor
					),
				),
				home: SignupPage()
		);
	}

}


class MyHttpOverrides extends HttpOverrides {
	@override
	HttpClient createHttpClient(SecurityContext? context) {
		return super.createHttpClient(context)
			..badCertificateCallback =
					(X509Certificate cert, String host, int port) => true;
	}
}