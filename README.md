  # Home Automation App

A Flutter-based home automation app that allows users to control IoT devices through Firebase Realtime Database.

## Features

- User Authentication (Email/Password)
- Real-time device control (Light, Fan, TV, AC)
- Beautiful animations and transitions
- ESP32 integration for hardware control
- Cross-platform support (Android and Web)

## Setup Instructions

1. **Firebase Configuration**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Email/Password Authentication
   - Create a Realtime Database with the following structure:
     ```json
     {
       "ac": 0,
       "fan": 0,
       "light": 0,
       "tv": 0,
       "esp32_status": "offline"
     }
     ```
   - Update the security rules:
     ```json
     {
       "rules": {
         ".read": "auth != null",
         ".write": "auth != null"
       }
     }
     ```
   - Update `lib/firebase_options.dart` with your Firebase configuration

2. **Flutter Setup**
   ```bash
   # Install dependencies
   flutter pub get

   # Run the app
   flutter run
   ```

## Project Structure

- `lib/screens/`
  - `auth/` - Login and registration screens
  - `home/` - Main device control screen
- `lib/services/`
  - `auth_service.dart` - Firebase authentication service
  - `database_service.dart` - Firebase Realtime Database service
- `lib/firebase_options.dart` - Firebase configuration

## Dependencies

- firebase_core: ^2.25.4
- firebase_auth: ^4.17.4
- firebase_database: ^10.4.5
- google_fonts: ^6.1.0
- provider: ^6.1.1
- flutter_animate: ^4.5.0

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.
