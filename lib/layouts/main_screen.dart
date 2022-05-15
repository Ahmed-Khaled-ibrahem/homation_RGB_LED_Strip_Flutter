import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:homation_led_strip/cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:homation_led_strip/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../classes/const.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);

        return cubit.on? SingleChildScrollView(
            child: Center(
                child: Column(
                  children: [
                    ColorPicker(
                      colorCodePrefixStyle: const TextStyle(color: Colors.white),
                      elevation: 10,
                      colorCodeTextStyle: const TextStyle(color: Colors.white),
                      pickerTypeTextStyle: TextStyle(color: cubit.darkMode? Colors.white:blackColor ),
                      width: 40,
                      height: 40,
                      wheelWidth: 10,
                      wheelDiameter: 200,
                      spacing: 10,
                      runSpacing: 10,
                      borderRadius: 50,
                      selectedColorIcon: Icons.local_fire_department_sharp,
                      showColorName: cubit.language=="en",
                      heading:  Text(AppLocalizations.of(context)!.colorPalette,style: TextStyle(color: cubit.darkMode? Colors.white: blackColor ),),
                      selectedPickerTypeColor: mainColor,
                      onColorChangeEnd: (Color c) async {
                        cubit.selectedMode = 0;
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

                      pickerTypeLabels:  {
                        ColorPickerType.wheel : AppLocalizations.of(context)!.wheel,
                        ColorPickerType.both : AppLocalizations.of(context)!.primaryAccent,
                      }, onColorChanged: (Color value) {  },
                    ),
                    Center(
                        child: DropdownButton<String>(
                          value: [null ,"Calm", "Dance", "Fading |", "Fading ||" ,"Random |","Random ||"][cubit.selectedMode],
                            icon: Icon( Icons.lightbulb,color: cubit.selectedMode == 0 ? Colors.blueGrey:Colors.yellow,),
                            hint: Text(AppLocalizations.of(context)!.selectMode,style: TextStyle(color: mainColor,fontSize: 20),),
                            onTap: (){},
                            items: <String>["Calm", "Dance", "Fading |", "Fading ||" ,"Random |","Random ||"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.local_fire_department_sharp,color: Colors.orange,),
                                    const SizedBox(width: 5,),
                                    Text(value,style: TextStyle(color: cubit.darkMode? Colors.white:Colors.black),),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (str) {
                              cubit.changeDance(str!);
                            },
                          dropdownColor: cubit.darkMode?  blackColor: backColor,

                        ),
                    ),
                  ],
                ))) :
        Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ Icon(Icons.nightlight_round,color: cubit.darkMode? Colors.white:Colors.black,),
                  const SizedBox(width: 5,),
                  Text(AppLocalizations.of(context)!.lightIsTurnedOFF)]
            ));
      },
    );
  }
}
