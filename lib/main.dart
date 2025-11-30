// ignore_for_file: use_build_context_synchronously

import 'package:biometrics_demo/private_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BiometricPage(),
    );
  }
}

class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Authentication')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            biometricAuthentication(context);
          },
          child: const Text(
            'Go to Private page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void goToPrivatePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrivatePage()),
    );
  }

  Future<void> biometricAuthentication(BuildContext context) async {
    final LocalAuthentication auth = LocalAuthentication();
    // Check if the device can use biometric authentication
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (!canAuthenticate) {
      showToast('Biometric authentication is not available on this device');
      return;
    }

    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      showToast('No biometrics are enrolled on this device');
      return;
    }

    // Proceed with biometric authentication
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to access the private page',
      );
      if (didAuthenticate) {
        goToPrivatePage(context);
      }
    } catch (e) {
      showToast('Authentication error: $e');
    }
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
