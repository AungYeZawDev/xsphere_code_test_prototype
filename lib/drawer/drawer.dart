import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/constants/custom_constants.dart';
import 'package:xsphere_code_test_prototype/custom_paint/rps_custom_painter.dart';
import 'package:xsphere_code_test_prototype/drawer/drawer_model.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu(
      {Key? key,
      required this.screenIndex,
      required this.iconAnimationController,
      required this.callBackIndex})
      : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  State<DrawerMenu> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<DrawerMenu> {
  CustomConstants custom = CustomConstants();
  List<DrawerList> drawerList = [];

  @override
  void initState() {
    setdDrawerListArray();
    super.initState();
  }

  /// Inilize Items list in drawer

  void setdDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.home,
        labelName: 'Home',
        icon: const Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.note,
        labelName: 'Note',
        icon: const Icon(Icons.edit_note_outlined),
      ),
      DrawerList(
        index: DrawerIndex.announchment,
        labelName: 'Announchment',
        icon: const Icon(Icons.notifications_none),
      ),
      DrawerList(
        index: DrawerIndex.setting,
        labelName: 'Setting',
        icon: const Icon(Icons.settings_suggest),
      ),
      DrawerList(
        index: DrawerIndex.about,
        labelName: 'About',
        icon: const Icon(Icons.info_outline),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.5),
        body: CustomPaint(
          size: Size(
              MediaQuery.of(context).size.width,
              (MediaQuery.of(context).size.width * 0.625)
                  .toDouble()),
          painter: RPSCustomPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: widget.iconAnimationController,
                        builder: (BuildContext context, Widget? child) {
                          return ScaleTransition(
                            scale: AlwaysStoppedAnimation<double>(1.0 -
                                (widget.iconAnimationController.value) * 0.2),
                            child: RotationTransition(
                              turns: AlwaysStoppedAnimation<double>(
                                  Tween<double>(begin: 0.0, end: 24.0)
                                          .animate(CurvedAnimation(
                                              parent: widget
                                                  .iconAnimationController,
                                              curve: Curves.fastOutSlowIn))
                                          .value /
                                      360),
                              child: Container(
                                height: 90,
                                width: 90,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(2.0, 4.0),
                                        blurRadius: 8),
                                  ],
                                ),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(60.0)),
                                    child: Image.asset(
                                      "assets/images/profile.png",
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 4),
                        child: Row(
                          children: [
                            Text(
                              'John Doe',
                              style: custom.textStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.02,
                                  isDarkMode: isDarkMode),
                            ),
                            const SizedBox(
                              width: 5.5,
                            ),
                            const Tooltip(
                                message: 'This Account is Verified',
                                child: Icon(
                                  Icons.check_circle_sharp,
                                  color: Colors.blue,
                                  size: 15,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 4),
                        child: Row(
                          children: [
                            Text('Flutter Developer',
                                style: custom.textStyle(
                                    color:
                                        Colors.grey,
                                    isDarkMode: isDarkMode,
                                    fontSize: size.height * 0.02)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.6),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(0.0),
                  itemCount: drawerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return inkwell(drawerList[index], isDarkMode, size);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget inkwell(DrawerList listData, bool isDarkMode, Size size) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage!
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            listData.imageName,
                            color: widget.screenIndex == listData.index
                                ? Colors.white
                                : Colors.blue.withOpacity(0.6),
                          ),
                        )
                      : Icon(
                          listData.icon.icon,
                          color: (!isDarkMode)
                              ? widget.screenIndex == listData.index
                                  ? Colors.white
                                  : Colors.transparent.withOpacity(0.6)
                              : Colors.white,
                        ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: custom.textStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.02,
                        isDarkMode: isDarkMode),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}
