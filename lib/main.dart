import 'package:ecommerce_app/providers/cart_provider.dart'; // 1. Need this
import 'package:ecommerce_app/screens/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart'; // 2. Need this
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart'; // 1. ADD THIS IMPORT


const Color kHeritageNavy = Color(0xFF1C2B3C,);
const Color kSkyblue = Color(0xFF87CEEB); 
const Color kArchivalCream = Color(0xFFF8F4EF,);
const Color kCharcoalGray = Color(0xFFA09F9F);
const Color kBurgundy = Color(0xFF0000FF);

void main() async {
  // 1. Preserve splash screen (Unchanged)
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 2. Initialize Firebase (Unchanged)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3. Set web persistence (Unchanged)
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  // 4. --- DEFER CART PROVIDER INITIALIZATION ---
  // We manually create the CartProvider instance *before* runApp
  final cartProvider = CartProvider();

  // 5. Remove splash screen (Unchanged)
  FlutterNativeSplash.remove();

  // 6. This is the NEW code for runApp
  runApp(
    // 7. We use ChangeNotifierProvider.value
    ChangeNotifierProvider.value(
      value: cartProvider, // 8. We provide the instance we already created
      child: const MyApp(),
    ),
  );

  // 9. Defer auth listener initialization after runApp to avoid blocking UI thread
  WidgetsBinding.instance.addPostFrameCallback((_) {
    cartProvider.initializeAuthListener();
  });

  // 10. This is the old, buggy code we are replacing:
  /*
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(), // <-- This was the problem
      child: const MyApp(),
    ),
  );
  */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Root of the app
    return MaterialApp(


      debugShowCheckedModeBanner: false,
      title: 'Comick E-Commerce',
      // 1. --- THIS IS THE NEW, COMPLETE THEME ---
      theme: ThemeData(
        // 2. Set the main color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: kHeritageNavy, // Our new primary color
          brightness: Brightness.light,
          primary: kHeritageNavy,
          onPrimary: Colors.white,
          secondary: kSkyblue,
          background: kArchivalCream, // Our new app background
        ),
        useMaterial3: true,

        // 3. Set the background color for all screens
        scaffoldBackgroundColor: kArchivalCream,

        // 4. --- (FIX) APPLY THE GOOGLE FONT ---
        // This applies "Lato" to all text in the app
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),

        // 5. --- (FIX) GLOBAL BUTTON STYLE ---
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kBurgundy, // Use our new cream color
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
          ),
        ),

        // 6. --- (FIX) GLOBAL TEXT FIELD STYLE ---
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: TextStyle(color: kCharcoalGray.withOpacity(0.8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kHeritageNavy, width: 2.0),
          ),
        ),

        // 7. --- (FIX) GLOBAL CARD STYLE ---
        cardTheme: CardThemeData(
          elevation: 1, // A softer shadow
          color: Colors.white, // Pure white cards on the off-white bg
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          // 8. This ensures the images inside the card are rounded
          clipBehavior: Clip.antiAlias,
        ),

        // 9. --- (NEW) GLOBAL APPBAR STYLE ---
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Clean white AppBar
          foregroundColor: kHeritageNavy, // Black text
          elevation: 0, // No shadow, modern look
          centerTitle: true,
        ),
      ),

      // --- END OF NEW THEME ---
      home: const AuthWrapper(),
    );
  }
}
