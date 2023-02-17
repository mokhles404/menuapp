import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iheb/constant.dart';
import 'package:lottie/lottie.dart';

import 'Productpage.dart';



class  HomePage extends StatelessWidget {
  const  HomePage({Key? key}) : super(key: key);


  Future<String> getLinkFromQrCode() async {
    String? lien;

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('link')
          .doc("qrcode")
          .get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        lien = data['lien'];

      }
    } catch (e) {
      print('Error getting data from Firestore: $e');
    }

    return lien ?? 'No Link found'; // return an empty string if lien is null
  }

  Future<String> scanQR() async {
    String? barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return barcodeScanRes;

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: lightBlackColor,

        child: Column(
          children: [

            Lottie.asset('assets/relaxcoffe.json'),
             SizedBox(height: size.height*.05,),
             Text("TikTok Caffe",style: GoogleFonts.cairo(fontSize: 36,fontWeight: FontWeight.bold),),
             SizedBox(height: size.height*.05,),
             ElevatedButton(
               style:ButtonStyle(
                 padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12,horizontal: 12)),
                 backgroundColor: MaterialStateProperty.all<Color>(lightYellow),

               ) ,
                onPressed: () async {
                  String res = await scanQR();
                  print(res);
                  String link = await getLinkFromQrCode();
                  print(link);
                  if(res.trim().toLowerCase()==link.trim().toLowerCase()){
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Loading')));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  ProductsByCategoryScreen()),
                    );
                  }
                  else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Qr Code Incorrect')));

                    }



                },
            child:  Text("Scannez QrCode\npour afficher le menu",style: TextStyle(color: blackColor,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,)),
            Spacer(),
            Text("RQ:   SVP activer le WFFI pour afficher le menu"),
            SizedBox(height: 25,)


          ],
        ),


      ),
    );
  }
}
