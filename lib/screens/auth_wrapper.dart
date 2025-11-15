import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _timedOut = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer so if the auth stream doesn't resolve quickly,
    // we fall back to the login screen to avoid a permanent splash.
    _timer = Timer(const Duration(seconds: 7), () {
      setState(() {
        _timedOut = true;
      });
      debugPrint('AuthWrapper: auth stream timed out after 7s, falling back to LoginScreen.');
    });
    debugPrint('AuthWrapper: initialized with 7s fallback timer.');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Diagnostic logging for auth stream
        debugPrint('AuthWrapper snapshot: connection=${snapshot.connectionState} hasData=${snapshot.hasData} error=${snapshot.error}');

        if (snapshot.connectionState == ConnectionState.waiting && !_timedOut) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If auth has data, cancel the fallback timer and go to Home
        if (snapshot.hasData) {
          _timer?.cancel();
          debugPrint('AuthWrapper: user is signed in.');
          return const HomeScreen();
        }

        // If we timed out waiting for the auth stream, show LoginScreen
        if (_timedOut) {
          debugPrint('AuthWrapper: timed out waiting; showing LoginScreen.');
          return const LoginScreen();
        }

        // Default: no user -> Login
        debugPrint('AuthWrapper: no user, showing LoginScreen.');
        return const LoginScreen();
      },
    );
  }
}