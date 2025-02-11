import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campus_thrift_application/auth/signup.dart';
import 'package:campus_thrift_application/home/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  // Define theme colors
  final Color bumblebeeYellow = const Color(0xFFFFC107);
  final Color cream = const Color(0xFFFFF8E1);
  final Color darkGrey = const Color(0xFF424242);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _signup(context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Background decoration
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: bumblebeeYellow.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    // Marketplace Logo
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: bumblebeeYellow,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: bumblebeeYellow.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome back',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: darkGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: darkGrey.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _emailField(),
                    const SizedBox(height: 20),
                    _passwordField(),
                    const SizedBox(height: 40),
                    _signInButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter your email',
            hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: darkGrey.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon:
                Icon(Icons.person_outline, color: darkGrey.withOpacity(0.5)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email address';
            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter your password',
            hintStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: darkGrey.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon:
                Icon(Icons.lock_outline, color: darkGrey.withOpacity(0.5)),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: darkGrey.withOpacity(0.5),
              ),
              onPressed: () =>
                  setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: darkGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _signInButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bumblebeeYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 56),
        elevation: 0,
      ),
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          await AuthService().signin(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          );
        }
      },
      child: Text(
        "Sign In",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: darkGrey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      color: cream,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: darkGrey.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
            ),
            TextSpan(
              text: "Sign Up",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: darkGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
