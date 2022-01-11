import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homation_led_strip/cubit/cubit.dart';
import 'package:homation_led_strip/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';


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
                        Text("Language",style: TextStyle(fontWeight: FontWeight.bold ,color: cubit.darkMode? Colors.white:cubit.blackColor),),
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
                                          ? cubit.mainColor
                                          : cubit.darkMode? cubit.blackColor : cubit.backColor,
                                      child:  Center(child: Text("Arabic"
                                        ,style: TextStyle(
                                            color: cubit.darkMode?  cubit.backColor : cubit.blackColor),))),
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
                                          ? cubit.mainColor
                                          : cubit.darkMode?  cubit.blackColor:cubit.backColor,
                                      child:  Center(child: Text("English",style: TextStyle(
                                          color: cubit.darkMode?  cubit.backColor : cubit.blackColor),))),
                                ),
                              ),
                              onTap:  (){cubit.changelang(context,true);},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                         Text("Connection",style: TextStyle(fontWeight: FontWeight.bold,color: cubit.darkMode? Colors.white:cubit.blackColor),),
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
                                          ? cubit.mainColor
                                          : cubit.darkMode? cubit.blackColor : cubit.backColor,
                                      child: Center(child: Text("Local",style: TextStyle(
                                          color: cubit.darkMode?  cubit.backColor : cubit.blackColor),))),
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
                                          ? cubit.mainColor
                                          : cubit.darkMode? cubit.blackColor : cubit.backColor,
                                      child: Center(child: Text("Internet",style: TextStyle(
                                          color: cubit.darkMode?  cubit.backColor : cubit.blackColor),))),
                                ),
                              ),
                              onTap:  (){cubit.changeSwitch(true);},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                         Text("Theme",style: TextStyle(fontWeight: FontWeight.bold,color: cubit.darkMode? Colors.white:cubit.blackColor),),
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
                                          ? cubit.mainColor
                                          : cubit.darkMode? cubit.blackColor : cubit.backColor,
                                      child: Center(child: Text("Light",style: TextStyle(
                                          color: cubit.darkMode?  cubit.backColor : cubit.blackColor),))),
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
                                          ? cubit.mainColor
                                          : cubit.backColor,
                                      child:  Center(child: Text("Dark",style: TextStyle(
                                          color: cubit.darkMode?  cubit.backColor : cubit.blackColor),))),
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
                          child: const Text('Change Access Point Settings',),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(cubit.mainColor)),),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [ Text('Go to Homation Site',
                              style: TextStyle(color: cubit.mainColor,),),
                               const SizedBox(width: 10,),
                               const Icon(Icons.web_rounded,color: Colors.green,)]),
                          onTap:(){launch("https://homationsite.blogspot.com");} ,),
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
                                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(cubit.mainColor)),
                                ),
                                const Text("Wifi Configurations"),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: cubit.mainColor,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(

                                children: const  [
                                   Text('NOTE'),
                                   Text( 'Please connect to access point',style: TextStyle(fontSize: 14 ,)),
                                   Text('that has name Homation Wifi',style: TextStyle(fontSize: 14 ,)),
                                   Text('with password home2023',style: TextStyle(fontSize: 14 ,)),

                                ],
                              ),
                            ),

                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: cubit.darkMode? cubit.backColor:cubit.blackColor,
                                ),
                                controller: cubit.wifiName,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'WiFi Name cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  fillColor: Colors.black12,
                                    filled: true,

                                    label: Text("WIFI Name",style: TextStyle(color:  cubit.darkMode? cubit.backColor:cubit.blackColor,),),
                                    prefixIcon: Icon(Icons.wifi,
                                      color: cubit.darkMode? cubit.backColor:cubit.blackColor,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: cubit.mainColor, width: 2.0),
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
                                  color: cubit.darkMode? cubit.backColor:cubit.blackColor,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'WiFi Password cannot be empty';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: cubit.showPassword,
                                decoration: InputDecoration(
                                    fillColor: Colors.black12,
                                    filled: true,
                                    label: Text("WiFi Password",style: TextStyle(color:  cubit.darkMode? cubit.backColor:cubit.blackColor,),),
                                    prefixIcon:  Icon(Icons.lock,
                                        color: cubit.darkMode? cubit.backColor:cubit.blackColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                          color: cubit.mainColor, width: 2.0),
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
                                          color: cubit.darkMode? cubit.backColor:cubit.blackColor),
                                    )),
                              ),
                            ),

                            const SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(onPressed: (){
                                cubit.tryconnect();
                              },
                                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(cubit.mainColor)),
                                  child:
                                 Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                   Text('Send'),
                                   SizedBox(width: 10,),
                                   Icon(Icons.send)
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


