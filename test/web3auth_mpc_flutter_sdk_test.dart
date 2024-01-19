import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:web3auth_mpc_flutter_sdk/web3auth_mpc_flutter_sdk_method_channel.dart';
import 'package:web3auth_mpc_flutter_sdk/web3auth_mpc_flutter_sdk_platform_interface.dart';

class MockWeb3authMpcFlutterSdkPlatform
    with MockPlatformInterfaceMixin
    implements Web3authMpcFlutterSdkPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Web3authMpcFlutterSdkPlatform initialPlatform =
      Web3authMpcFlutterSdkPlatform.instance;

  test('$MethodChannelWeb3authMpcFlutterSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWeb3authMpcFlutterSdk>());
  });

  /*test('getPlatformVersion', () async {
    Web3authMpcFlutterSdk web3authMpcFlutterSdkPlugin = Web3authMpcFlutterSdk();
    MockWeb3authMpcFlutterSdkPlatform fakePlatform = MockWeb3authMpcFlutterSdkPlatform();
    Web3authMpcFlutterSdkPlatform.instance = fakePlatform;
  });*/
}
