// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';
//
// import 'EPMT PAGES/bottom navigation page.dart';
// import 'EPMT PAGES/sing in page.dart';
// import 'EPMT PAGES/sing up.dart';
// import 'PAYMENT CODE WITH COD.dart';
// import 'Profile screens/profile page.dart';
// import 'EPMT PAGES/splash screen.dart';
// import 'EPMT PAGES/whishlist page.dart';
// import 'Order/order ui.dart';
//
// import 'Profile screens/select language page.dart';
// import 'cart/cart provider.dart';
//
// import 'cart/cart ui.dart';
// // Add your language selection page import here
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//       apiKey: "AIzaSyAxL79MXqENIko6AuEAsgj4VRgb66KF3Lg",
//       appId: "1:609502979593:android:c1243c6a8503f3fd10fad8",
//       messagingSenderId: "",
//       projectId: "medical-equipment-app-be87f",
//       storageBucket: "medical-equipment-app-be87f.firebasestorage.app",
//     ),
//   );
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => CartProvider()),
//         // ChangeNotifierProvider(create: (_) => OrderProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Locale _locale = Locale('en'); // Default locale is English
//
//   // Method to change locale dynamically
//   void _setLocale(String languageCode) {
//     setState(() {
//       _locale = Locale(languageCode);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       locale: _locale,
//       supportedLocales: const [
//         Locale('en', ''), // English
//         Locale('ml', ''), // Malayalam
//         // Add more supported locales here
//       ],
//       localizationsDelegates: [
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         // Add custom delegate if you are using your own translations
//       ],
//       initialRoute: '/splash',
//       routes: {
//         '/splash': (context) => const SurgSplash(),
//         '/sign_up': (context) => const SignUp(),
//         '/sign_in': (context) =>  SignIn(),
//         '/bottom_navigation': (context) => const BottomNav(),
//         '/payment': (context) => PaymentPage(cartItems: {}, totalPrice: 0, address: '',),
//         '/profile': (context) => const ProfilePage(),
//         '/wish_list': (context) => WishlistPage(),
//         '/order_details': (context) => OrdersPage(),
//         '/cart': (context) => CartScreen(),
//         '/language_selection': (context) => LanguageSelectionPage(
//           onLanguageChanged: _setLocale, // Pass the language change callback
//         ),
//       },
//     );
//   }
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Admin panel/ADMIN PAGE.dart';

// Example: A simple provider class to manage some state
class ProductProvider extends ChangeNotifier {
  List<String> _products = [];

  List<String> get products => _products;

  void addProduct(String product) {
    _products.add(product);
    notifyListeners();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAxL79MXqENIko6AuEAsgj4VRgb66KF3Lg",
      appId: "1:609502979593:android:c1243c6a8503f3fd10fad8",
      messagingSenderId: "",
      projectId: "medical-equipment-app-be87f",
      storageBucket: "medical-equipment-app-be87f.firebasestorage.app",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddProductPage(),
      ),
    );
  }
}
