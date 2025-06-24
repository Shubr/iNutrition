import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inutrition/dashboard/dashboard.dart';
import 'package:inutrition/dashboard/widgets/meal_entry_selector.dart';
import 'package:inutrition/execStudentPage/scanner.dart';
import 'package:inutrition/settings_page.dart';
import 'package:inutrition/summary_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    const MealEntrySelector(),
    const BarcodeScannerPage(),
    const SummaryPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Special case for the scanner button
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
          );
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: SvgPicture.asset(
          'assets/icons/crossHair.svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          height: 30,
          width: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.black,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _onItemTapped(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/homeicon.svg',
                          colorFilter: ColorFilter.mode(_selectedIndex == 0 ? Colors.white : Colors.grey, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _onItemTapped(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/donuticon.svg',
                           colorFilter: ColorFilter.mode(_selectedIndex == 1 ? Colors.white : Colors.grey, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Right Tab bar icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _onItemTapped(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/statsicon.svg',
                           colorFilter: ColorFilter.mode(_selectedIndex == 3 ? Colors.white : Colors.grey, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      _onItemTapped(4);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/settingicon.svg',
                           colorFilter: ColorFilter.mode(_selectedIndex == 4 ? Colors.white : Colors.grey, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
} 