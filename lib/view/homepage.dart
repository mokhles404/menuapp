import 'package:flutter/material.dart';
import 'package:iheb/constant.dart';
import 'package:lottie/lottie.dart';



class  HomePage extends StatelessWidget {
  const  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: lightBlackColor,

      child: Column(
        children: [

          Lottie.asset('assets/relaxcoffe.json'),
           SizedBox(height: size.height*.1,),
           ElevatedButton(
             style:ButtonStyle(
               padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12,horizontal: 12)),
               backgroundColor: MaterialStateProperty.all<Color>(lightYellow),

             ) ,
              onPressed: () {

              },
          child:  Text("Scannez QrCode\npour afficher le menu",style: TextStyle(color: blackColor,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,))


        ],
      ),


    );
  }
}
