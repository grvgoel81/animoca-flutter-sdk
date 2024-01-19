import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:web3auth_mpc_flutter_sdk/input.dart';
import 'package:web3auth_mpc_flutter_sdk/webview_plugin.dart';

class Web3authMpcFlutterSdk {
  late Web3AuthOptions web3authOptions;

  Future<void> init(Web3AuthOptions web3authOptions) async {
    Map<String, dynamic> initParamsJson = web3authOptions.toJson();
    initParamsJson.removeWhere((key, value) => value == null);
    this.web3authOptions = web3authOptions;
    return;
  }

  Future<String> launchWalletServices(LoginParams loginParams) async {
    try {
      Map<String, dynamic> loginParamsJson = loginParams.toJson();
      loginParamsJson.removeWhere((key, value) => value == null);
      Uri sdkUrl = Uri.parse(web3authOptions.walletSdkUrl!);
      Map<String, dynamic> initOptions = {
        "clientId": web3authOptions.clientId,
        "network": web3authOptions.network.name.toLowerCase(),
        if (web3authOptions.redirectUrl != null)
          "redirectUrl": web3authOptions.redirectUrl.toString(),
        if (web3authOptions.whiteLabel != null)
          "whiteLabel": jsonEncode(web3authOptions.whiteLabel),
        if (web3authOptions.loginConfig != null)
          "loginConfig": jsonEncode(web3authOptions.loginConfig),
        if (web3authOptions.buildEnv != null)
          "buildEnv": web3authOptions.buildEnv?.name.toLowerCase(),
        if (web3authOptions.mfaSettings != null)
          "mfaSettings": jsonEncode(web3authOptions.mfaSettings),
        if (web3authOptions.sessionTime != null)
          "sessionTime": web3authOptions.sessionTime,
      };

      Map<String, dynamic> initParams = {
        "loginProvider": loginParams.loginProvider.name.toLowerCase(),
        if (loginParams.extraLoginOptions != null)
          "extraLoginOptions": jsonEncode(loginParams.extraLoginOptions),
        "redirectUrl": loginParams.redirectUrl != null
            ? loginParams.redirectUrl.toString()
            : initOptions["redirectUrl"].toString(),
        if (loginParams.mfaLevel != null)
          "mfaLevel": loginParams.mfaLevel.toString().toLowerCase(),
        if (loginParams.curve != null)
          "curve": loginParams.curve.toString().toLowerCase(),
        if (loginParams.dappShare != null) "dappShare": loginParams.dappShare,
      };

      Map<String, dynamic> paramMap = {
        "options": initOptions,
        "params": initParams,
        "actionType": "login",
      };

      String hash =
          "b64Params=${base64UrlEncode(utf8.encode(jsonEncode(paramMap)))}";
      Uri url = Uri(
        scheme: sdkUrl.scheme,
        host: sdkUrl.host,
        path: '${sdkUrl.path}/request',
        fragment: hash,
      );
      print(url.toString());
      return url.toString();
    } on PlatformException catch (e) {
      switch (e.code) {
        case "UserCancelledException":
          throw UserCancelledException();
        case "NoAllowedBrowserFoundException":
          throw UnKnownException(e.message);
        default:
          rethrow;
      }
    }
  }

  Future<void> request(String method, Map<String, dynamic> params) async {
    try {
      Map<String, dynamic> loginParamsJson = params;
      loginParamsJson.removeWhere((key, value) => value == null);

      const WebViewPlugin(url: "https://flutter.dev");
      return;
    } on PlatformException catch (e) {
      switch (e.code) {
        case "UserCancelledException":
          throw UserCancelledException();
        case "NoAllowedBrowserFoundException":
          throw UnKnownException(e.message);
        default:
          rethrow;
      }
    }
  }
}
