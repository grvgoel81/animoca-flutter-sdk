import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'web3auth_mpc_flutter_sdk_platform_interface.dart';

/// An implementation of [Web3authMpcFlutterSdkPlatform] that uses method channels.
class MethodChannelWeb3authMpcFlutterSdk extends Web3authMpcFlutterSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('web3auth_mpc_flutter_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
