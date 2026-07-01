import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DefaultBottomNavigationBar extends StatelessWidget {
  DefaultBottomNavigationBar({super.key, required this.handleNavigation});
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  final Function(int) handleNavigation;
  void navigateTo(int index) {
    currentIndex.value = index;
    handleNavigation(index);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, -2), // changes position of shadow
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex.value,
            onTap: (index) {
              currentIndex.value = index;
              handleNavigation(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: value == 0 ? 30 : 20),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.stethoscope, size: value == 1 ? 30 : 20),
                label: 'Locum Jobs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: value == 2 ? 30 : 20),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
