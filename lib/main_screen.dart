import 'package:flutter/material.dart';
import 'package:gastro_lens/views/report_screen.dart';
import 'package:provider/provider.dart';
import 'components/app_bar.dart';
import 'components/drawer.dart';
import 'models/providers.dart';
import 'views/menu_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const MenuScreen(),
    const ReportScreen(),
    // const ResultScreen(null),
  ];

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    const BottomNavigationBarItem(
      label: 'Report',
      icon: Icon(Icons.list_alt_rounded),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavProvider>(
        builder: (context, navProvider, child) {
          return Scaffold(
            appBar: const BuildAppBar(),
            drawer: const BuildDrawer(),
            body: SafeArea(child: _screens[navProvider.selectedIndex]),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navProvider.selectedIndex,
              onTap: (index) {
                navProvider.selectedIndex = index;
              },
              items: _navItems,
              type: BottomNavigationBarType.fixed,
            ),
          );
        }
    );
  }
}
