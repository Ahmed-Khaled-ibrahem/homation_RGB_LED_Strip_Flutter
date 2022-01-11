import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:homation_led_strip/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homation_led_strip/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return cubit.on? SingleChildScrollView(
            child: Container(
              width: EdgeInsetsGeometry.infinity.vertical,
              //color: cubit.darkMode? cubit.blackColor : Colors.white,
              child: Center(
                  child: Column(
                    children: [
                      ColorPicker(
                        colorCodePrefixStyle: TextStyle(color: Colors.white),
                        elevation: 10,
                        colorCodeTextStyle: TextStyle(color: Colors.white),
                        pickerTypeTextStyle: TextStyle(color: cubit.darkMode? Colors.white:cubit.blackColor ),
                        width: 40,
                        height: 40,
                        wheelWidth: 10,
                        wheelDiameter: 200,
                        spacing: 10,
                        runSpacing: 10,
                        borderRadius: 50,
                        selectedColorIcon: Icons.local_fire_department_sharp,
                        showColorName: cubit.language=="en",
                        heading:  Text("Color Palette",style: TextStyle(color: cubit.darkMode? Colors.white:cubit.blackColor ),),
                        selectedPickerTypeColor: cubit.mainColor,
                        onColorChangeEnd: (Color c) async {
                          cubit.selectedMode = 0;
                          //txt280 = cubit.english ? 'Select Mode' : 'اختر وضع الاضاءه';
                          cubit.rgb = c;
                          cubit.changeColor();
                        },
                        color: cubit.rgb,
                        pickersEnabled: const < ColorPickerType, bool> {
                          ColorPickerType.wheel :true,
                          ColorPickerType.both : true,
                          ColorPickerType.accent :false,
                          ColorPickerType.primary :false
                        },

                        pickerTypeLabels: const {
                          ColorPickerType.wheel : 'Wheel',
                          ColorPickerType.both : 'Primary & Accent',
                        }, onColorChanged: (Color value) {  },
                      ),
                      Center(
                          child: DropdownButton<String>(
                              icon: Icon( Icons.lightbulb,color: cubit.selectedMode == 0 ? Colors.blueGrey:Colors.yellow,),
                              hint: Text("Select Mode",style: TextStyle(color: cubit.mainColor,fontSize: 20),),
                              onTap: (){},
                              items: <String>["Calm", "Dance", "Fading |", "Fading ||" ,"Random |","Random ||"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    color: cubit.mainColor,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.local_fire_department_sharp,color: Colors.orange,),
                                        SizedBox(width: 5,),
                                        Text(value,style: TextStyle(color: cubit.darkMode? Colors.white:Colors.black),),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (str) {
                                cubit.changeDance(str!);
                              },
                            dropdownColor: cubit.darkMode?  cubit.blackColor: cubit.backColor,

                          ),
                      ),
                    ],
                  )),
            )) :
        Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Icon(Icons.nightlight_round,color: cubit.darkMode? Colors.white:Colors.black,),
                  const SizedBox(width: 5,),
                  const Text("Light is Turned OFF")]
            ));
      },
    );
  }
}
