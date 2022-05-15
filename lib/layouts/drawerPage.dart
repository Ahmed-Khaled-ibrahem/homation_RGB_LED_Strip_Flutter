import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homation_led_strip/cubit/cubit.dart';
import 'package:homation_led_strip/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../classes/const.dart';

class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          body: Container(
            child: cubit.wificontainer? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container( height: 30, color: const Color.fromRGBO(22, 57, 85, 1),),
                  Image.asset('assets/images/hometion.jpg'),
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const SizedBox(height: 40,),
                        Text(AppLocalizations.of(context)!.language,style: TextStyle(fontWeight: FontWeight.bold ,color: cubit.darkMode? Colors.white:blackColor),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: SizedBox(
                                width: 80,
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Container(
                                      color:
                                      !cubit.english
                                          ? secondColor
                                          : cubit.darkMode? blackColor : backColor,
                                      child:  Center(child: Text(AppLocalizations.of(context)!.arabic
                                        ,style: TextStyle(
                                            color: cubit.darkMode? backColor : blackColor),))),
                                ),
                              ),
                              onTap: (){cubit.changelang(context,false);},
                            ),
                            InkWell(
                              child: SizedBox(
                                width: 80,
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Container(
                                      color: cubit.english
                                          ? secondColor
                                          : cubit.darkMode?  blackColor:backColor,
                                      child:  Center(child: Text(AppLocalizations.of(context)!.english,style: TextStyle(
                                          color: cubit.darkMode?  backColor : blackColor),))),
                                ),
                              ),
                              onTap:  (){cubit.changelang(context,true);},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                         Text(AppLocalizations.of(context)!.connection,style: TextStyle(fontWeight: FontWeight.bold,color: cubit.darkMode? Colors.white:blackColor),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: SizedBox(
                                width: 80,
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Container(
                                      color: !cubit.connectionSwitch
                                          ? secondColor
                                          : cubit.darkMode? blackColor : backColor,
                                      child: Center(child: Text(AppLocalizations.of(context)!.local,style: TextStyle(
                                          color: cubit.darkMode?  backColor : blackColor),))),
                                ),
                              ),
                              onTap:  (){cubit.changeSwitch(false);},
                            ),
                            InkWell(
                              child: SizedBox(
                                width: 80,
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Container(
                                      color: cubit.connectionSwitch
                                          ? secondColor
                                          : cubit.darkMode? blackColor : backColor,
                                      child: Center(child: Text(AppLocalizations.of(context)!.internet,style: TextStyle(
                                          color: cubit.darkMode?  backColor : blackColor),))),
                                ),
                              ),
                              onTap:  (){cubit.changeSwitch(true);},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                         Text(AppLocalizations.of(context)!.theme,style: TextStyle(fontWeight: FontWeight.bold,color: cubit.darkMode? Colors.white:blackColor),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: SizedBox(
                                //margin: EdgeInsets.all(30),
                                width: 80,
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Container(
                                      color:
                                      !cubit.darkMode
                                          ? secondColor
                                          : cubit.darkMode? blackColor : backColor,
                                      child: Center(child: Text(AppLocalizations.of(context)!.light,style: TextStyle(
                                          color: cubit.darkMode?  backColor : blackColor),))),
                                ),
                              ),
                              onTap:  (){cubit.changeTheme(false);},
                            ),
                            InkWell(
                              child: SizedBox(
                                width: 80,
                                height: 30,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Container(
                                      color:
                                      cubit.darkMode
                                          ? secondColor
                                          : backColor,
                                      child:  Center(child: Text(AppLocalizations.of(context)!.dark,style: TextStyle(
                                          color: cubit.darkMode? backColor : blackColor),))),
                                ),
                              ),
                              onTap:  (){cubit.changeTheme(true);},
                            ),
                          ],
                        ),
                        const SizedBox(height: 100,),
                        ElevatedButton(onPressed: (){
                            cubit.send_pass_page_button();

                        },
                          child:  Text(AppLocalizations.of(context)!.changeAccessPointSettings,),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(secondColor)),),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [ Text(AppLocalizations.of(context)!.gotoHOMATIONSite,
                              style: TextStyle(color: secondColor,),),
                               const SizedBox(width: 10,),
                               const Icon(Icons.web_rounded,color: Colors.green,)]),
                          onTap:(){ launch("https://homationsite.blogspot.com") ; } ,),
                      ],
                    ),
                  ),
                ],
              ),
            ) : 
            GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Container( height: 30, color: const Color.fromRGBO(22, 57, 85, 1),),
                    Image.asset('assets/images/hometion.jpg'),
                    Form(
                      key: cubit.formKey,
                      child: SizedBox(
                        width: 250,
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: (){cubit.exit_pass_page_button();},
                                  child: const Icon(Icons.close),
                                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(mainColor)),
                                ),
                                 Text(AppLocalizations.of(context)!.wifiConfigurations),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: mainColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children:[
                                   Text(AppLocalizations.of(context)!.nOTE),
                                   Text( AppLocalizations.of(context)!.please,style: TextStyle(fontSize: 14 ,)),
                                   Text(AppLocalizations.of(context)!.that,style: TextStyle(fontSize: 14 ,)),
                                   Text(AppLocalizations.of(context)!.withPassword,style: TextStyle(fontSize: 14 ,)),

                                ],
                              ),
                            ),

                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: cubit.darkMode? backColor:blackColor,
                                ),
                                controller: cubit.wifiName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.wifi_name_error;
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.black12,
                                    filled: true,

                                    label: Text(AppLocalizations.of(context)!.wIFINameLbl,style: TextStyle(color:  cubit.darkMode? backColor:blackColor,),),
                                    prefixIcon: Icon(Icons.wifi,
                                      color: cubit.darkMode? backColor:blackColor,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mainColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: cubit.wifiPass,
                                style: TextStyle(
                                  color: cubit.darkMode? backColor:blackColor,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.wifi_pass_error;
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: cubit.showPassword,
                                decoration: InputDecoration(
                                    fillColor: Colors.black12,
                                    filled: true,
                                    label: Text(AppLocalizations.of(context)!.wIFIPasswordLbl,style: TextStyle(color:  cubit.darkMode? backColor:blackColor,),),
                                    prefixIcon:  Icon(Icons.lock,
                                        color: cubit.darkMode? backColor:blackColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                          color: mainColor, width: 2.0),
                                      borderRadius:
                                      BorderRadius.circular(15),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        cubit.passwordSecuredChanged();
                                      },
                                      icon: Icon(!cubit.showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                          color: cubit.darkMode?backColor:blackColor),
                                    )),
                              ),
                            ),

                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(onPressed: (){
                                cubit.tryconnect();
                              },
                                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(mainColor)),
                                  child:
                                 Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                   Text(AppLocalizations.of(context)!.send),
                                   const SizedBox(width: 10,),
                                   const Icon(Icons.send)
                                ],
                              )
                              ),
                            ),
                            /*
                            cubit.loading?  CircularProgressIndicator(
                              backgroundColor: cubit.mainColor,
                              strokeWidth: 10,
                            ):const SizedBox(width: 20,)
                            */
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),
        );
      },
    );
  }
}


