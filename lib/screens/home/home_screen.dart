import 'package:flutter/material.dart';
import 'package:home_sync/services/auth_service.dart';
import 'package:home_sync/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = AuthService();
  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade600, Colors.purple.shade600],
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<bool>(
            stream: _databaseService.esp32StatusStream,
            builder: (context, snapshot) {
              final isEsp32Online = snapshot.data ?? false;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(26),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withAlpha(51),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color:
                                    isEsp32Online ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isEsp32Online
                                    ? 'ESP32 Online'
                                    : 'ESP32 Offline',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: _authService.signOut,
                          icon: const Icon(Icons.logout, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(16),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        _buildDeviceCard(
                          'Light',
                          Icons.lightbulb_outline,
                          Colors.amber,
                          'light',
                          isEsp32Online,
                        ),
                        _buildDeviceCard(
                          'Fan',
                          Icons.wind_power,
                          const Color.fromARGB(255, 153, 228, 66),
                          'fan',
                          isEsp32Online,
                        ),
                        _buildDeviceCard(
                          'TV',
                          Icons.tv,
                          const Color.fromARGB(255, 222, 42, 111),
                          'tv',
                          isEsp32Online,
                        ),
                        _buildDeviceCard(
                          'AC',
                          Icons.ac_unit,
                          const Color.fromARGB(255, 77, 123, 223),
                          'ac',
                          isEsp32Online,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(
    String name,
    IconData icon,
    Color color,
    String deviceKey,
    bool isEsp32Online,
  ) {
    return StreamBuilder<bool>(
      stream: _databaseService.getDeviceStateStream(deviceKey),
      builder: (context, snapshot) {
        final isOn = snapshot.data ?? false;
        final isEnabled = isEsp32Online;

        return GestureDetector(
          onTap: isEnabled
              ? () => _databaseService.toggleDevice(deviceKey, !isOn)
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isOn ? color.withAlpha(51) : Colors.white.withAlpha(26),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isOn ? color.withAlpha(102) : Colors.white.withAlpha(51),
                width: 2,
              ),
              boxShadow: isOn
                  ? [
                      BoxShadow(
                        color: color.withAlpha(77),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: isEnabled
                      ? (isOn ? color : Colors.white.withAlpha(179))
                      : Colors.white.withAlpha(77),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: TextStyle(
                    color: isEnabled
                        ? (isOn ? color : Colors.white)
                        : Colors.white.withAlpha(128),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isEnabled ? (isOn ? 'ON' : 'OFF') : 'OFFLINE',
                  style: TextStyle(
                    color: isEnabled
                        ? (isOn ? color : Colors.white.withAlpha(179))
                        : Colors.white.withAlpha(128),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
