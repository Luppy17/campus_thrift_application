import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_thrift_application/theme/colors.dart';
import 'package:campus_thrift_application/Auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String userEmail = "Loading...";
  String profileImage = "";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? "No email found";
      });

      // Fetch user data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection("users").doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          profileImage =
              userDoc["profileImage"] ?? ""; // Profile Image (Optional)
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary, // Cream background
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Bumblebee Yellow
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profile Avatar (Fetch from Firestore if available)
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage:
                  profileImage.isNotEmpty ? NetworkImage(profileImage) : null,
              child: profileImage.isEmpty
                  ? Icon(Icons.person, size: 50, color: AppColors.primary)
                  : null,
            ),
            const SizedBox(height: 12),
            // User Email
            Text(
              userEmail,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            // Profile Options
            _profileOption(Icons.person, 'Edit Profile', () {}),
            _profileOption(Icons.shopping_bag, 'My Orders', () {}),
            _profileOption(Icons.settings, 'Settings', () {}),
            _profileOption(Icons.help_outline, 'Help & Support', () {}),
            _profileOption(Icons.logout, 'Logout', _logoutUser, isLogout: true),
          ],
        ),
      ),
    );
  }

  Widget _profileOption(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: isLogout ? Colors.red : AppColors.primary),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isLogout ? Colors.red : Colors.black87,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }

  // Logout Function
  void _logoutUser() async {
    await _auth.signOut();
    // Redirect to login screen after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}
