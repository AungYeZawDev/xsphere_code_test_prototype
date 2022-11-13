import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/drawer/drawer.dart';
import 'package:xsphere_code_test_prototype/drawer/drawer_model.dart';
import 'package:xsphere_code_test_prototype/screen/profile_screen.dart';

class DrawerMenuController extends StatefulWidget {
  const DrawerMenuController({
    Key? key,
    this.drawerWidth = 250,
    required this.onDrawerCall,
    this.screenView,
    this.animationController,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    required this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex) onDrawerCall;
  final Widget? screenView;
  final Function(AnimationController)? animationController;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData animatedIconData;
  final Widget? menuView;
  final DrawerIndex screenIndex;

  @override
  State<DrawerMenuController> createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerMenuController>
    with TickerProviderStateMixin {
  late ScrollController scrollController;
  late AnimationController iconAnimationController;
  late AnimationController animationController;

  double scrolloffset = 0.0;
  bool isSetDawer = false;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));

    iconAnimationController.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);

    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);

    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        if (scrolloffset != 1.0) {
          setState(() {
            scrolloffset = 1.0;
            try {
              widget.drawerIsOpen!(true);
            } catch (_) {}
          });
        }

        iconAnimationController.animateTo(0.0,
            duration: const Duration(milliseconds: 0), curve: Curves.linear);
      } else if (scrollController.offset > 0 &&
          scrollController.offset < widget.drawerWidth) {
        iconAnimationController.animateTo(
            (scrollController.offset * 100 / (widget.drawerWidth)) / 100,
            duration: const Duration(milliseconds: 0),
            curve: Curves.linear);
      } else if (scrollController.offset <= widget.drawerWidth) {
        if (scrolloffset != 0.0) {
          setState(() {
            scrolloffset = 0.0;
            try {
              widget.drawerIsOpen!(false);
            } catch (_) {}
          });
        }

        iconAnimationController.animateTo(1.0,
            duration: const Duration(milliseconds: 0), curve: Curves.linear);
      }
    });

    getInitState();

    super.initState();
  }

  Future<bool> getInitState() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 300));
    try {
      widget.animationController!(iconAnimationController);
    } catch (_) {}

    await Future<dynamic>.delayed(const Duration(milliseconds: 100));
    scrollController.jumpTo(
      widget.drawerWidth,
    );

    setState(() {
      isSetDawer = true;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: Opacity(
          opacity: isSetDawer ? 1 : 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width + widget.drawerWidth,
            child: Container(
              color: Colors.white54,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: widget.drawerWidth,
                    height: MediaQuery.of(context).size.height,
                    child: AnimatedBuilder(
                      animation: iconAnimationController,
                      builder: (BuildContext context, Widget? child) {
                        return Transform(
                          transform: Matrix4.translationValues(
                              scrollController.offset, 0.0, 0.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: widget.drawerWidth,
                            child: DrawerMenu(
                              screenIndex: widget.screenIndex,
                              iconAnimationController: iconAnimationController,
                              callBackIndex: (DrawerIndex indexType) {
                                onDrawerClick();
                                try {
                                  widget.onDrawerCall(indexType);
                                  // ignore: empty_catches
                                } catch (e) {}
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.indigo.withOpacity(0.2),
                              blurRadius: 24),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          IgnorePointer(
                            ignoring: false,
                            child: widget.screenView ??
                                Container(
                                  color: Colors.white,
                                ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).padding.top + 6,
                                    left: 8),
                                child: SizedBox(
                                  width: AppBar().preferredSize.height - 8,
                                  height: AppBar().preferredSize.height - 8,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(
                                          AppBar().preferredSize.height),
                                      child: Center(
                                        child: widget.menuView ??
                                            AnimatedIcon(
                                              icon: widget.animatedIconData,
                                              progress: iconAnimationController,
                                              color: (brightness !=
                                                      Brightness.light)
                                                  ? Colors.blueAccent
                                                  : Colors.white,
                                            ),
                                      ),
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        onDrawerClick();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).padding.top + 8,
                                    left: 8,
                                    right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfileScreen()));
                                  },
                                  child: Hero(
                                    tag: 'profile',
                                    child: SizedBox(
                                        width:
                                            AppBar().preferredSize.height - 14,
                                        height:
                                            AppBar().preferredSize.height - 14,
                                        child: const CircleAvatar(
                                          radius: 28,
                                          backgroundImage: AssetImage(
                                              'assets/images/profile.png'),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onDrawerClick() {
    if (scrollController.offset != 0.0) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
