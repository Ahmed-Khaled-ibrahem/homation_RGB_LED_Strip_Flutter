import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'classes/pref_helper.dart';
import 'classes/restart.dart';
import 'cubit/cubit.dart';
import 'layouts/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homation_led_strip/layouts/drawerPage.dart';
import 'package:homation_led_strip/cubit/states.dart';
import 'layouts/scafoldClass.dart';
import 'package:homation_led_strip/layouts/test.dart';

Future<void> main() async {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(0, 0, 0, 0),
    statusBarIconBrightness: Brightness.light,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
  initloading();
  //runApp(const newlock());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..read(),
      child:Material(),
    );
  }
}


class Material extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return  MaterialApp(
          builder: EasyLoading.init(),
          //locale:Locale(cubit.language),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('ar', ''),],
          debugShowCheckedModeBanner: false,
          title: "RGB",
          theme: ThemeData(
            scaffoldBackgroundColor: cubit.darkMode? cubit.blackColor: Colors.white,
                textTheme: TextTheme(
                  bodyText2: TextStyle(
                      color: cubit.darkMode?  Colors.white:cubit.blackColor),),),// AppLocalizations.of(context)!.appTitle,
          //theme: cubit.darkMode ? cubit.darkModeTheme : cubit.lightModeTheme,
          home:  const MyScafold(),
        );
      },
    );
  }
}

void initloading(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}