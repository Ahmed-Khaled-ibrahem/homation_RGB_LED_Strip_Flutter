import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class newlock extends StatefulWidget {
  const newlock({Key? key}) : super(key: key);

  @override
  _newlockState createState() => _newlockState();
}

class _newlockState extends State<newlock> with SingleTickerProviderStateMixin{
   late AnimationController animationController;
   Widget front = Container(color: Colors.red,);
   Widget back = Container(color: Colors.blue,);

  @override
  void initState(){
    super.initState();
    animationController = AnimationController(
        vsync: this,
    duration: const Duration(milliseconds: 400));
    //Togle();
    //animationController.addListener(() {setState(() {

//    });
//})
  //animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Stack(
        children: [
          const minedrower(),
          AnimatedBuilder(
            animation: animationController,
            builder: (context ,_){
              return GestureDetector(
                onTap: Togle,
                child: Container(
                  child: Center(
                      child: Transform.translate(
                        offset: Offset(animationController.value*150,animationController.value*50),
                        child: Transform.scale(
                            scale: (1-animationController.value)+0.5,
                            child: const mainpage(),),
                      ))

                ),
              );
            },
          ),

        ] ,
      ),

    );
  }

  void Togle(){
    //animationController.isDismissed?animationController.forward():animationController.reverse();
    animationController.forward();
    if(animationController.isCompleted){
      animationController.reverse();
    }


  }
}




class minedrower extends StatefulWidget {
  const minedrower({Key? key}) : super(key: key);

  @override
  _minedrowerState createState() => _minedrowerState();
}



class _minedrowerState extends State<minedrower> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

