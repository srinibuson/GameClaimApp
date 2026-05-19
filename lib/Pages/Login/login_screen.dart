// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.white);
//   }
// }

// ============================================================
// STEP 1: Add these to pubspec.yaml dependencies:
// ============================================================
//
// dependencies:
//   flutter:
//     sdk: flutter
//   firebase_core: ^2.24.2
//   firebase_auth: ^4.15.3
//   google_sign_in: ^6.2.1
//
// ============================================================
// STEP 2: Setup Firebase
// ============================================================
// 1. Go to console.firebase.google.com
// 2. Create new project
// 3. Add Android/iOS app
// 4. Download google-services.json → put in android/app/
// 5. Run: flutter pub add firebase_core firebase_auth google_sign_in
// 6. Run: dart pub global activate flutterfire_cli
// 7. Run: flutterfire configure
//
// ============================================================
// STEP 3: Update main.dart
// ============================================================
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// ============================================================

import 'package:Claimit_app/Constant/constantroute.dart';
import 'package:Claimit_app/Constant/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscurePassword = true;

  // ── Email / Password Login ──────────────────────────────
  Future<void> _loginWithEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to home screen after login
      if (mounted) {
        // Navigator.pushReplacementNamed(context, '/home');
        Get.offAllNamed(ConstantRoute.dashboard);
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Try again later';
      }

      _showSnackbar(message, isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ── Google Sign In ──────────────────────────────────────
  // Future<void> _loginWithGoogle() async {
  //   setState(() => _isLoading = true);

  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       setState(() => _isLoading = false);
  //       return; // User cancelled
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await FirebaseAuth.instance.signInWithCredential(credential);

  //     if (mounted) {
  //       Navigator.pushReplacementNamed(context, '/home');
  //     }
  //   } catch (e) {
  //     _showSnackbar('Google sign-in failed. Try again.', isError: true);
  //   } finally {
  //     if (mounted) setState(() => _isLoading = false);
  //   }
  // }

  // ── Forgot Password ─────────────────────────────────────
  Future<void> _forgotPassword() async {
    if (_emailController.text.trim().isEmpty) {
      _showSnackbar('Enter your email first');
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      _showSnackbar('Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      _showSnackbar(e.message ?? 'Error sending reset email', isError: true);
    }
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ── UI ──────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.05,
                vertical: Screens.padingHeight(context) * 0.02,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // ── Logo ──
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: Screens.width(context) * 0.17,
                              height: Screens.padingHeight(context) * 0.085,
                              decoration: BoxDecoration(
                                // color: const Color(0xFF1A73E8),
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Image.asset('Assets/launcher_icon.png'),
                              // child: const Icon(
                              //   Icons.bolt,
                              //   color: Colors.white,
                              //   size: 32,
                              // ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.02,
                            ),
                            const Text(
                              'Welcome back',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),
                            Text(
                              'Log in to Continue',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: Screens.padingHeight(context) * 0.05),

                      // ── Email Field ──
                      _buildLabel('Email'),
                      SizedBox(height: Screens.padingHeight(context) * 0.02),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        decoration: _inputDecoration(
                          hint: 'you@gmail.com',
                          prefixIcon: Icons.mail_outline,
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return 'Enter your email';
                          if (!val.contains('@')) return 'Enter a valid email';
                          return null;
                        },
                      ),

                      SizedBox(height: Screens.padingHeight(context) * 0.035),

                      // ── Password Field ──
                      _buildLabel('Password'),
                      SizedBox(height: Screens.padingHeight(context) * 0.02),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        decoration: _inputDecoration(
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: GestureDetector(
                            onTap:
                                () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                          ),
                        ),
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return 'Enter your password';
                          if (val.length < 6) return 'Minimum 6 characters';
                          return null;
                        },
                      ),

                      SizedBox(height: Screens.padingHeight(context) * 0.02),

                      // ── Login Button ──
                      SizedBox(
                        width: Screens.width(context),
                        height: Screens.padingHeight(context) * 0.065,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _loginWithEmail,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A73E8),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child:
                              _isLoading
                                  ? SizedBox(
                                    width: Screens.width(context) * 0.06,
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  )
                                  : const Text(
                                    'Log In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[500],
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.8,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: Colors.grey[600], size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[800]!, width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[800]!, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1A73E8), width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 0.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
