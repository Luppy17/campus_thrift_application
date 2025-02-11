import 'package:flutter/material.dart';
import 'package:campus_thrift_application/pages/home_content.dart';
import 'package:campus_thrift_application/pages/preloved.dart';
import 'package:campus_thrift_application/pages/profile.dart';
import 'package:campus_thrift_application/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;

  final List<Widget> _screens = [
    const HomeContent(),
    const Preloved(),
    const Profile(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedIndex == 0 ? AppColors.primary : Colors.white,
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _animationController.forward(from: 0);
            });
          },
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(0, Icons.storefront, 'Home'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(1, Icons.favorite, 'Preloved'),
              label: 'Preloved',
            ),
            BottomNavigationBarItem(
              icon: _buildAnimatedIcon(2, Icons.person, 'Profile'),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon(int index, IconData icon, String label) {
    double scale = _selectedIndex == index ? 1.3 : 1.0;
    Color iconColor = _selectedIndex == index ? AppColors.primary : Colors.grey;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: scale,
          child: Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
        );
      },
    );
  }
}
