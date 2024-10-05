import 'package:flutter/material.dart';
import 'package:ssc/presentation/customer/history/history_page.dart';
import 'package:ssc/presentation/customer/home/customer_home_page.dart';
import 'package:ssc/presentation/customer/payment/payment_page.dart';
import 'package:ssc/presentation/customer/profile/profile_page.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({
    super.key,
  });

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    CustomerHomePage(),
    HistoryPage(),
    PaymentPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Payment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.white60,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
