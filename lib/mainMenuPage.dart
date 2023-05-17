import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/fetures/addPlace/presentation/page/addPlacePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../core/app_theme.dart';
import '../../core/util/ScreenUtil.dart';
import '../../core/util/common.dart';
import '../../core/widgets/cachedNetworkImage.dart';
import 'core/others/constants.dart';
import 'core/widgets/Texts/primaryText.dart';
import 'fetures/aboutAppPage.dart';
import 'fetures/contactUs/presentation/page/contactUsPage.dart';
import 'fetures/favorite/presentation/page/favoritePage.dart';
import 'fetures/home/presentation/page/homePage.dart';
import 'fetures/search/presentation/page/searchPage.dart';
import 'fetures/users/data/models/userModel.dart';

class MainMenuPage extends StatefulWidget {
  int currentIndex;

  MainMenuPage({this.currentIndex = 0});

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int _counter = 0;
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  UserModel? user;

  dynamic screens = [
    HomePage(),
    SearchPage(),
    FavoritePage(),
  ];

  @override
  void initState() {
    checkUserLoggedIn().fold((l) {
      user = l;
    }, (r) {
      user = null;
    });

    super.initState();
  }

  ScreenUtil screenUtil = ScreenUtil();
  Widget canner_appDataWidget = Container();
  bool logoutRequestPending = false;

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return SideMenu(
      key: _endSideMenuKey,
      inverse: true,
      // end side menu
      background: AppTheme.scaffoldBackgroundColor,
      type: SideMenuType.slideNRotate,
      closeIcon: Icon(
        Icons.close,
        color: Colors.black,
      ),
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: buildMenu(),
      ),

      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: SideMenu(
        key: _sideMenuKey,
        menu: buildMenu(),
        type: SideMenuType.shrikNRotate,
        radius: BorderRadius.circular(20),
        inverse: true,
        onChange: (_isOpened) {
          setState(() => isOpened = _isOpened);
        },
        child: IgnorePointer(
          ignoring: isOpened,
          ignoringSemantics: true,
          child: Scaffold(
            backgroundColor: AppTheme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: AppTheme.scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () => toggleMenu(true),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notification_add_rounded,
                    color: Colors.black,
                  ),
                  onPressed: (){
                    _bottomSheet();
                  },
                ),
              ],
            ),
            body: screens[widget.currentIndex],
            // body: IndexedStack(
            //   index: widget.currentIndex,
            //   children: ,
            // ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withOpacity(.1),
                    width: 1,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                elevation: 0.0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppTheme.primaryColor,
                unselectedItemColor: kMyGrey.withOpacity(.6),
                backgroundColor: Colors.red.withOpacity(0.0),
                currentIndex: widget.currentIndex,
                onTap: (index) {
                  setState(() {
                    widget.currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                        color: widget.currentIndex == 0
                            ? AppTheme.primaryColor
                            : kMyGrey.withOpacity(.6)),
                    label: "الرئيسية",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search,
                        color: widget.currentIndex == 1
                            ? AppTheme.primaryColor
                            : kMyGrey.withOpacity(.6)),
                    label: 'البحث',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite,
                        color: widget.currentIndex == 2
                            ? AppTheme.primaryColor
                            : kMyGrey.withOpacity(.6)),
                    label: "المفضلة",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenu() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                    height: screenUtil.orientation == Orientation.portrait
                        ? screenUtil.screenHeight * .18
                        : screenUtil.screenWidth / 18,
                    width: screenUtil.screenWidth * .35,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: user != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: cachedNetworkImage(image: user?.image ?? ''),
                          )
                        : Center()),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPlacePage()));
              },
              title: PrimaryText(
                text: 'أضف مكان',
                textStyle: AppTheme.textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUsPage()));
              },
              title: PrimaryText(
                text: 'تواصل معنا',
                textStyle: AppTheme.textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutAppPage()));
              },
              title: PrimaryText(
                text: 'عن التطبيق',
                textStyle: AppTheme.textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: PrimaryText(
                text: 'مشاركة التطبيق',
                textStyle: AppTheme.textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: PrimaryText(
                text: 'الإصدار',
                textStyle: AppTheme.textTheme.bodyText1,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ));
  }

  _bottomSheet() {
    showModalBottomSheet(
        context: context,
        barrierColor: AppTheme.appContainersTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                    text: 'الإشعارات',
                    textStyle: AppTheme.textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  ListTile(
                    title:PrimaryText(
                      text: 'قم الآن بتحديث التطبيق الى آخر إصدار',
                      textStyle: AppTheme.textTheme.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                    leading: Icon(Icons.notification_add_outlined,color: AppTheme.primarySwatch.shade500,),
                  ),

                  Divider(
                    color: Colors.black,
                  ),

                  ListTile(
                    title:PrimaryText(
                      text: 'الآن فندق البستان - صنعاء يقدم خصومات نهاية العام',
                      textStyle: AppTheme.textTheme.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                    leading: Icon(Icons.notification_add_outlined,color: AppTheme.primarySwatch.shade500,),
                  ),

                  Divider(
                    color: Colors.black,
                  ),

                  ListTile(
                    title:PrimaryText(
                      text: 'تخفيضات تصل الى 50 بالميه في مطاعم الشيباني 😍',
                      textStyle: AppTheme.textTheme.bodyText1,
                      textAlign: TextAlign.start,
                    ),
                    leading: Icon(Icons.notification_add_outlined,color: AppTheme.primarySwatch.shade500,),
                  ),

                  Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
