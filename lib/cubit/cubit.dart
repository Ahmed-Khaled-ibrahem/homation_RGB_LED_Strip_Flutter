import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'states.dart';
import 'package:http/http.dart'as http ;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  bool darkMode = true;
  bool on = true;
  bool english = true;////
  bool connectionSwitch = true;
  TextEditingController wifiName = TextEditingController();
  TextEditingController wifiPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Color mainColor = Colors.green;
  Color mainColor = const Color(0xff13965D);
  Color backColor = Colors.white;
  Color blackColor = const Color(0xFF2A2A2A);


  bool  showPassword = true;
  String ip = '192.168.1.50';
  String gateway = '192.168.1.1';
  String subnet = '255.255.255.0';
  bool loading = false;
  int selectedMode = 0;
  Color rgb = Color.fromRGBO(100, 64, 64,0);
  bool wificontainer = true;

  Color buttonSelected = Colors.lightBlueAccent;
  Color buttonNormal = Colors.grey;

  Color selectedProp = Colors.green;
  late Color unSelectedProp = darkMode? blackColor : backColor;

  Color lightColor = Colors.yellow;
  final dataBase = FirebaseDatabase.instance.ref();
  String language = "en";

  void appStart(){
   // read();
  }

  void generalfunc() {
    emit(general());
  }
  void passwordSecuredChanged() {
    showPassword = !showPassword;

    emit(general());
  }

  void send_pass_page_button() {
    wificontainer = false;
    emit(general());
  }

  void exit_pass_page_button() {
    wificontainer = true;
    emit(general());
  }

  void tryconnect() {

    if(formKey.currentState?.validate()??true){
      EasyLoading.show(status: 'Connecting...');
      loading = true;

      String passafter = wifiPass.value.text.toString();
      passafter = passafter.replaceAll('#','%23');
      passafter = passafter.replaceAll('&','%26');
      passafter = passafter.replaceAll('@','%40');
      passafter = passafter.replaceAll('!','%21');

      var url = Uri.parse(
          "http://192.168.1.40/conf?ssid="+wifiName.value.text.toString()+"&pass="+passafter);
      http.read(url).catchError((err) {
        print(err);
        loading = false;
        EasyLoading.dismiss();
        // on error
      }).then((value) {
        //setState(() {
        loading =false;
        EasyLoading.dismiss();

        print(value);
        try{
          var m = value.split('\n');
          if(m[0]=="ok"){
            ip = m[1];
            save();
            //setState(() {
            loading =false;
            EasyLoading.dismiss();
            wificontainer = true;

          }
          else{print('no ip');}
        }
        catch(e){
          print('error');
        }

      });

    }
    emit(Counterplus());
  }

  void changeSwitch(bool i) {

    connectionSwitch = i;
    sendESPMode();
    save();
    emit(general());
  }

  void changeTheme(bool i) {
  darkMode = i;
    emit(general());
  save();
  }

  void changelang(context,eng) {

      english = eng;
      language = language =="en"? "ar": "en";
      emit(Changelang());
      save();
    //Phoenix.rebirth(context);
    //RestartWidget.restartApp(context);
    //print(language);

  }

  void changeColor() {

    sendColor(rgb.red, rgb.green, rgb.blue, 0, 1);
    // important
    //  "http://"+"192.168.1.40"+"/data?red="+rgb.red
    emit(ChangeColor());
  }

  void changeMode(int i) {
    selectedMode = i;
  }

  void changeDance(String str) {

    if(str==""){
      changeMode(1);
    }
    else if(str=="modes here"){
      changeMode(2);
    }
    else if(str==""){
      changeMode(3);
    }
    else if(str==""){
      changeMode(4);
    }
    else if(str==""){
      changeMode(5);
    }
    else if(str==""){
      changeMode(6);
    }
    else{
      changeMode(0);
    }
    if(!connectionSwitch) {
      var url = Uri.parse(
          "http://"+ip+"/data?red="+rgb.red.toString()+"&green="+rgb.green.toString()+"&blue="+rgb.blue.toString()+"&mode="+selectedMode.toString()+"&state=1");
      http.read(url).timeout(Duration(seconds: 4)).catchError((err) {
        var url2 = Uri.parse(
            "http://"+"192.168.1.40"+"/data?red="+rgb.red.toString()+"&green="+rgb.green.toString()+"&blue="+rgb.blue.toString()+"&mode="+selectedMode.toString()+"&state=1");
        http.read(url2).timeout(Duration(seconds: 4)).catchError((err) {});

        // on error
      }).then((value) {
        print(value);
      });
    }
    else{
      String sendrgb = "R="+rgb.red.toString()+",G="+rgb.green.toString()+",B="+rgb.blue.toString()+",M="+selectedMode.toString()+",S=1,E_M=3";
      dataBase.child('RGB').set(sendrgb);
    }

    //txt280 = str!;

    emit(ChangeColor());
  }

  void on_off_button(context) {

    on = !on;

    if(on){
      sendColor(rgb.red, rgb.green, rgb.blue, selectedMode, 1);
    }
    else{
      sendColor(0, 0, 0, 0, 0);
    }

    emit(HttpRequest());
  }

  Future read() async {

    final prefs = await SharedPreferences.getInstance();

    language = prefs.getString('Language')??"en";
    darkMode = prefs.getBool('Theme')!;
    english = prefs.getBool('english')!;
    connectionSwitch = prefs.getBool('Connection')!;
    //ip = prefs.getString('ip')!;
    //gateway = prefs.getString('gateway')!;
    //subnet = prefs.getString('subnet')!;
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('Language', language);
    prefs.setBool('english', english);
    prefs.setBool('Theme', darkMode);
    prefs.setBool('Connection', connectionSwitch);

    //prefs.setString('ip',ip);
    //prefs.setString('gateway',gateway);
    //prefs.setString('subnet',subnet);
  }


  void sendColor(int red,int green, int blue, int mode, int state) async{

    if(connectionSwitch){

      var url = Uri.parse(
          "http://"+ip+"/data?red="+ red.toString()+
              "&green="+green.toString()
              +"&blue="+blue.toString()+
              "&mode="+mode.toString()+
              "&state="+state.toString());
      http.read(url).timeout(const Duration(seconds: 4)).catchError((err) {
        var url2 = Uri.parse(
            "http://"+ip+"/data?red="+ red.toString()+
                "&green="+green.toString()
                +"&blue="+blue.toString()+
                "&mode="+mode.toString()+
                "&state="+state.toString());
        http.read(url2).timeout(const Duration(seconds: 4)).catchError((err) {});
        // on error
      }).then((value) {
        //print(value);
      });
    }
    else{
      String sendrgb = "R="+red.toString()+
          ",G="+green.toString()+
          ",B="+blue.toString()+
          ",M="+mode.toString()+
          ",S="+state.toString()+",E_M=3";
      dataBase.child('RGB').set(sendrgb);
    }
  }


  void sendESPMode() async{

    if(!connectionSwitch){
      String sendrgb = "R="+rgb.red.toString()+",G="+rgb.green.toString()+",B="+rgb.blue.toString()+",M=0,S=1,E_M=2";
      dataBase.child('RGB').set(sendrgb);
    }
    else{

      String sendrgb = "R="+rgb.red.toString()+",G="+rgb.green.toString()+",B="+rgb.blue.toString()+",M=0,S=1,E_M=3";
      dataBase.child('RGB').set(sendrgb);

      var url = Uri.parse(
          "http://"+ip+"/mode?mode=3");
      http.read(url).catchError((err) {
        // on error
      }).then((value) {
        print(value);
      });

    }

  }


}



