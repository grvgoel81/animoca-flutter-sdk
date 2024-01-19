import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'web3auth_mpc_flutter_sdk_method_channel.dart';

abstract class Web3authMpcFlutterSdkPlatform extends PlatformInterface {
  /// Constructs a Web3authMpcFlutterSdkPlatform.
  Web3authMpcFlutterSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static Web3authMpcFlutterSdkPlatform _instance =
      MethodChannelWeb3authMpcFlutterSdk();

  /// The default instance of [Web3authMpcFlutterSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelWeb3authMpcFlutterSdk].
  static Web3authMpcFlutterSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Web3authMpcFlutterSdkPlatform] when
  /// they register themselves.
  static set instance(Web3authMpcFlutterSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
