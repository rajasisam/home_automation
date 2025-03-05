import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String _emailKey = 'saved_email';
  static const String _passwordKey = 'saved_password';
  static const String _rememberMeKey = 'remember_me';

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Save credentials
  Future<void> saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_rememberMeKey, true);
  }

  // Clear saved credentials
  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
    await prefs.setBool(_rememberMeKey, false);
  }

  // Get saved credentials
  Future<Map<String, String>> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    if (!rememberMe) return {};
    
    return {
      'email': prefs.getString(_emailKey) ?? '',
      'password': prefs.getString(_passwordKey) ?? '',
    };
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password, {bool rememberMe = false}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (rememberMe) {
        await saveCredentials(email, password);
      } else {
        await clearCredentials();
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw 'An error occurred. Please check your internet connection';
      } else {
        throw 'Invalid email or password';
      }
    } catch (e) {
      throw 'An error occurred. Please check your internet connection';
    }
  }

  // Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw 'An error occurred. Please check your internet connection';
      } else if (e.code == 'email-already-in-use') {
        throw 'Email is already registered';
      } else {
        throw 'Invalid email or password';
      }
    } catch (e) {
      throw 'An error occurred. Please check your internet connection';
    }
  }

  // Sign out
  Future<void> signOut() async {
    await clearCredentials();
    await _auth.signOut();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;
}
