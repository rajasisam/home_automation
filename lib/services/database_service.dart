import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Get ESP32 status stream
  Stream<DatabaseEvent> getESP32StatusStream() {
    return _database.child('Esp32/Status').onValue;
  }

  // Get device state stream
  Stream<bool> getDeviceStateStream(String deviceKey) {
    return _database
        .child('Devices/${deviceKey.toUpperCase()}')
        .onValue
        .map((event) => (event.snapshot.value as int? ?? 0) == 1);
  }

  // Toggle device state
  Future<void> toggleDevice(String deviceKey, bool newState) async {
    try {
      await _database.child('Devices/${deviceKey.toUpperCase()}').set(newState ? 1 : 0);
    } catch (e) {
      debugPrint('Error toggling device $deviceKey: $e');
      rethrow;
    }
  }

  // ESP32 status stream
  Stream<bool> get esp32StatusStream {
    return _database
        .child('Esp32/Status')
        .onValue
        .map((event) => (event.snapshot.value as String? ?? "offline").toLowerCase() == "online");
  }
}
