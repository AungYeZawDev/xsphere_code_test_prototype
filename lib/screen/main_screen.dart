import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/drawer/drawer_controller.dart';
import 'package:xsphere_code_test_prototype/drawer/drawer_model.dart';
import 'package:xsphere_code_test_prototype/screen/home_screen.dart';
import 'package:xsphere_code_test_prototype/screen/note_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  AnimationController? sliderAnimationController;
  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.home) {
        setState(() {
          screenView = const HomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.profile) {
        setState(() {
          screenView = const HomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.note) {
        setState(() {
          screenView = const NoteScreen();
        });
      } else if (drawerIndex == DrawerIndex.announchment) {
        setState(() {
          screenView = const HomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.setting) {
        setState(() {
          screenView = const HomeScreen();
        });
      } else if (drawerIndex == DrawerIndex.about) {
        setState(() {
          screenView = const HomeScreen();
        });
      } else {
        Navigator.of(context).pop();
      }
    }
  }
  @override
  void initState() {
    drawerIndex = DrawerIndex.home;

    /// first  Item in drawer
    screenView = const HomeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DrawerMenuController(
      animatedIconData: AnimatedIcons.arrow_menu,
      screenIndex: drawerIndex!,
      drawerWidth: MediaQuery.of(context).size.width * 0.75,
      animationController: (AnimationController animationController) {
        sliderAnimationController = animationController;
      },
      onDrawerCall: (DrawerIndex drawerIndexdata) {
        changeIndex(drawerIndexdata);
      },
      screenView: screenView,
    );
  }
}