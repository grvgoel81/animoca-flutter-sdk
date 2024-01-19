import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web3auth_mpc_flutter_sdk/enums.dart';
import 'package:web3auth_mpc_flutter_sdk/input.dart';
import 'package:web3auth_mpc_flutter_sdk/web3auth_mpc_flutter_sdk.dart';
import 'package:web3auth_mpc_flutter_sdk/webview_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String _result = '';
  bool logoutVisible = false;
  String url = "";
  final _web3authMpcFlutterSdkPlugin = Web3authMpcFlutterSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    HashMap themeMap = HashMap<String, String>();
    themeMap['primary'] = "#229954";

    Uri redirectUrl;
    if (Platform.isAndroid) {
      redirectUrl = Uri.parse(
          'torusapp://org.torusresearch.flutter.web3authexample/auth');
    } else if (Platform.isIOS) {
      redirectUrl =
          Uri.parse('com.web3auth.flutter.web3authflutterexample://auth');
    } else {
      throw UnKnownException('Unknown platform');
    }

    final loginConfig = HashMap<String, LoginConfigItem>();
    loginConfig['jwt'] = LoginConfigItem(
        verifier: "w3a-auth0-demo", // get it from web3auth dashboard
        typeOfLogin: TypeOfLogin.jwt,
        clientId: "hUVVf4SEsZT7syOiL0gLU9hFEtm2gQ6O" // auth0 client id
        );

    await _web3authMpcFlutterSdkPlugin.init(Web3AuthOptions(
        clientId:
            'BHgArYmWwSeq21czpcarYh0EVq2WWOzflX-NTK-tY1-1pauPzHKRRLgpABkmYiIV_og9jAvoIxQ8L3Smrwe04Lw',
        network: Network.sapphire_devnet,
        buildEnv: BuildEnv.testing,
        redirectUrl: redirectUrl,
        whiteLabel: WhiteLabelData(
            mode: ThemeModes.dark,
            defaultLanguage: Language.en,
            appName: "Web3Auth Flutter App",
            theme: themeMap),
        loginConfig: loginConfig));
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Web3Auth MPC Flutter SDK Example'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !logoutVisible,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Icon(
                      Icons.flutter_dash,
                      size: 80,
                      color: Color(0xFF1389fd),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Web3Auth',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Color(0xFF0364ff)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Welcome to Web3Auth MPC Flutter Demo',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Login with',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: _loginWithGoogle(),
                        child: const Text('Google')),
                    ElevatedButton(
                        onPressed: _loginWithFacebook(),
                        child: const Text('Facebook')),
                    ElevatedButton(
                        onPressed: _loginWithEmailPasswprdless(),
                        child: const Text('Email Passwordless')),
                    ElevatedButton(
                        onPressed: _loginWithDiscord(),
                        child: const Text('Discord')),
                  ],
                ),
              ),
              Visibility(
                // ignore: sort_child_properties_last
                child: Column(
                  children: [
                    Container(
                      height: deviceHeight, // Set the desired height
                      color: Colors.blue,
                      child: WebViewPlugin(url: url),
                    ),
                  ],
                ),
                visible: logoutVisible,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_result),
              )
            ],
          )),
        ),
      ),
    );
  }

  VoidCallback _loginWithGoogle() {
    return () async {
      try {
        url = await _web3authMpcFlutterSdkPlugin
            .launchWalletServices(LoginParams(loginProvider: Provider.google));
        setState(() {
          logoutVisible = true;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

  VoidCallback _loginWithFacebook() {
    return () async {
      try {
        await _web3authMpcFlutterSdkPlugin.launchWalletServices(
            LoginParams(loginProvider: Provider.facebook));
        setState(() {
          logoutVisible = true;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

  VoidCallback _loginWithEmailPasswprdless() {
    return () async {
      try {
        await _web3authMpcFlutterSdkPlugin.launchWalletServices(
            LoginParams(loginProvider: Provider.email_passwordless));
        setState(() {
          logoutVisible = true;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

  VoidCallback _loginWithDiscord() {
    return () async {
      try {
        await _web3authMpcFlutterSdkPlugin
            .launchWalletServices(LoginParams(loginProvider: Provider.discord));
        setState(() {
          logoutVisible = true;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }
}
