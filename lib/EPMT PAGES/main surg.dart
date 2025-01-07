

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Admin panel/ADMIN PAGE.dart';
import 'bottom navigation page.dart';






Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAxL79MXqENIko6AuEAsgj4VRgb66KF3Lg",
          appId: "1:609502979593:android:c1243c6a8503f3fd10fad8",
          messagingSenderId: "",
          projectId: "medical-equipment-app-be87f",
          storageBucket: "medical-equipment-app-be87f.firebasestorage.app"
      )
  );
  runApp(MySug());
}
class MySug extends StatelessWidget {
  const MySug({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddProductPage()
    );
  }
}




