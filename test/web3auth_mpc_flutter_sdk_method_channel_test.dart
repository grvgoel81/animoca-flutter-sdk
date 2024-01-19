import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web3auth_mpc_flutter_sdk/web3auth_mpc_flutter_sdk_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWeb3authMpcFlutterSdk platform =
      MethodChannelWeb3authMpcFlutterSdk();
  const MethodChannel channel = MethodChannel('web3auth_mpc_flutter_sdk');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
