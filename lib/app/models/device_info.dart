import 'package:repolicy/app/enum/device_state.dart';

class DeviceInfo {
  final String serial;
  final DeviceState state;

  DeviceInfo({required this.serial, required this.state});

  static DeviceState parseState(String state) {
    return DeviceState.values.firstWhere(
      (e) => e.name == state.trim(),
      orElse: () => throw ArgumentError('Unknown state: $state'),
    );
  }

  @override
  String toString() {
    return 'DeviceInfo(serial: $serial, state: ${state.name})';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceInfo &&
          runtimeType == other.runtimeType &&
          serial == other.serial;

  @override
  int get hashCode => serial.hashCode;
}
