import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/const.dart';
import 'states.dart';
import 'package:http/http.dart'as http ;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  bool darkMode = true;
  bool on = true;
  bool english = true;
  bool connectionSwitch = true;
  TextEditingController wifiName = TextEditingController();
  TextEditingController wifiPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  bool  showPassword = true;
  String ip = '192.168.1.40';
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

  late AnimationController animationController ;

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
      http.read(url).onError((error, stackTrace) => '').catchError((err) {
        print(err);
        loading = false;
        EasyLoading.dismiss();
        // on error
      }).then((value) {
        //setState(() {
        loading =false;
        EasyLoading.dismiss();

        print("***********" + value);
        if(value == 'ok'){
          save();
          //setState(() {
          loading = false;
          EasyLoading.dismiss();
          wificontainer = true;
          emit(Counterplus());
        }
        // try{
        //   var m = value.split('\n');
        //   if(m[0]=="ok"){
        //     ip = m[1];
        //     save();
        //     //setState(() {
        //     loading = false;
        //     EasyLoading.dismiss();
        //     wificontainer = true;
        //
        //   }
        //   else{print('no ip');}
        // }
        // catch(e){
        //   print('error');
        // }

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
   // ["Calm", "Dance", "Fading |", "Fading ||" ,"Random |","Random ||"]
    if(str=="Calm"){
      changeMode(1);
    }
    else if(str=="Dance"){
      changeMode(2);
    }
    else if(str=="Fading |"){
      changeMode(3);
    }
    else if(str=="Fading ||"){
      changeMode(4);
    }
    else if(str=="Random |"){
      changeMode(5);
    }
    else if(str=="Random ||"){
      changeMode(6);
    }
    else{
      changeMode(0);
    }
    //print(connectionSwitch);
    if(!connectionSwitch) {
      print('sending mode');
      var url = Uri.parse(
          "http://"+ip+"/data?red="+rgb.red.toString()+"&green="+rgb.green.toString()+"&blue="+rgb.blue.toString()+"&mode="+selectedMode.toString()+"&state=1");
      http.read(url).timeout(Duration(seconds: 4)).onError((error, stackTrace) => '').catchError((err) {
        var url2 = Uri.parse(
            "http://"+"192.168.1.40"+"/data?red="+rgb.red.toString()+"&green="+rgb.green.toString()+"&blue="+rgb.blue.toString()+"&mode="+selectedMode.toString()+"&state=1");
        http.read(url2).timeout(Duration(seconds: 4)).onError((error, stackTrace) => '').catchError((err) {});

        // on error
      }).then((value) {
        print(value);
      });
    }
    else{
      String sendrgb = "R="+rgb.red.toString()+",G="+rgb.green.toString()+",B="+rgb.blue.toString()+",M="+selectedMode.toString()+",S=1,E_M=3";
      dataBase.child('RGB').set(sendrgb);
    }

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
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('Language', language);
    prefs.setBool('english', english);
    prefs.setBool('Theme', darkMode);
    prefs.setBool('Connection', connectionSwitch);

  }


  void sendColor(int red,int green, int blue, int mode, int state) async{
print('send color');

    if(!connectionSwitch){
      print('send http');

      var url = Uri.parse(
          "http://"+ip+"/data?red="+ red.toString()+
              "&green="+green.toString()
              +"&blue="+blue.toString()+
              "&mode="+mode.toString()+
              "&state="+state.toString());

      http.read(url).timeout(const Duration(seconds: 2)).onError((error, stackTrace) => '').catchError((err) {
        var url2 = Uri.parse(
            "http://"+ip+"/data?red="+ red.toString()+
                "&green="+green.toString()
                +"&blue="+blue.toString()+
                "&mode="+mode.toString()+
                "&state="+state.toString());
        http.read(url2).timeout(const Duration(seconds: 2)).catchError((err) {});
        // on error
      }).onError((error, stackTrace) => 'null').then((value) {
        print(value);
      }).onError((error, stackTrace) => null);
    }
    else{
      print('firebase send');
      String sendrgb = "R="+red.toString()+
          ",G="+green.toString()+
          ",B="+blue.toString()+
          ",M="+mode.toString()+
          ",S="+state.toString()+",E_M=3";
      dataBase.child('RGB').set(sendrgb);
    }
  }


  void sendESPMode() async{

print('inside esp mode');
    if(!connectionSwitch){

      String sendrgb = "R="+rgb.red.toString()+",G="+rgb.green.toString()+",B="+rgb.blue.toString()+",M=0,S=1,E_M=2";
      dataBase.child('RGB').set(sendrgb);
    }
    else{
      print('modesend');
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



