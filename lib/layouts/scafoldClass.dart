import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/animation.dart';
import 'package:homation_led_strip/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homation_led_strip/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homation_led_strip/layouts/main_screen.dart';

import 'drawerPage.dart';




class MyScafold extends StatefulWidget {
  const MyScafold({Key? key}) : super(key: key);

  @override
  _MyScafoldState createState() => _MyScafoldState();
}

class _MyScafoldState extends State<MyScafold> with SingleTickerProviderStateMixin{

  late AnimationController animationController ;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,
    animationBehavior: AnimationBehavior.preserve,
    duration: const Duration(milliseconds: 400));
    animationController.addListener(() {print(animationController.value);});
    //animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Stack(
          children: [
            myDrawer(),
            AnimatedBuilder(
              animation: animationController,
              builder: (context,_){
                return Transform.translate(
                  offset: Offset(animationController.value*200,animationController.value*50),
                  child: Transform.scale(
                    scale: (animationController.value*-0.3) + 1,
                    child: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        toolbarHeight: 120,
                        shape: const RoundedRectangleBorder(
                          borderRadius:  BorderRadius.vertical(bottom: Radius.circular(80),),),
                        backgroundColor: cubit.mainColor,
                        elevation: 0,
                        flexibleSpace: GestureDetector(
                          onTap: (){
                            if(!animationController.isCompleted){
                              animationController.forward();
                            }
                            else{
                              animationController.reverse();
                            }

                            },
                        ),
                        title: SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              SizedBox(
                                height: 30,
                                child: Image.asset('assets/images/hometion_ICON.png',
                                 // color: cubit.darkMode? Colors.white: Colors.black,
                                 //color: cubit.darkMode? Colors.white: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              const Text("RGB LED Strip",style: TextStyle(fontSize: 25),),
                            ],
                          ),
                        ),


                        //title: Text("appTitle",style: TextStyle(color: cubit.darkMode? Colors.black:Colors.white),),
                      ),
                      body: MainScreen(),
                      floatingActionButton: FloatingActionButton(
                        child: Text(cubit.on ? "on" : "off",
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        backgroundColor: cubit.mainColor,
                        onPressed: () {
                          //cubit.on_off_button();
                          cubit.on_off_button(context);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}




