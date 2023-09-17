import 'package:crescoo_seller/screens/NavigationBar/billing.dart';
import 'package:crescoo_seller/screens/NavigationBar/inventory.dart';
import 'package:crescoo_seller/screens/NavigationBar/pitch.dart';
import 'package:crescoo_seller/screens/NavigationBar/profile.dart';
import 'package:flutter/material.dart';


class NavBar extends StatefulWidget {
  final int index;
  const NavBar({Key? key,required this.index});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    Inventory(),
    Billing(),
    Pitch(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index; // Initialize _currentIndex with the provided index
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(189, 189, 199, 1),
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: Material(
          //elevation: 100.0,// Add elevation to make it pop out
          child: Container(
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: Color(0xFF1A3251),// Change the color here
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Color(0xFF1A3251),
                  unselectedItemColor: Colors.black,
                  onTap: ((value) {
                    setState(() => _currentIndex = value);
                  }),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.note_alt_outlined,
                      ),
                      label: 'Inventory',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.edit_note,
                      ),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.lightbulb_outline_rounded,
                      ),
                      label: 'Pitch',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                      ),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
