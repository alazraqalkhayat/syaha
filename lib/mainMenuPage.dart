/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'core/widgets/Texts/primaryText.dart';


class MainMenuPage extends StatefulWidget {
  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  // late MotionTabController _tabController;
  List<String> popupItems = ['الإعدادات', 'من نحن', 'تقييم التطبيق'];
  int currentIndex = 0;
  dynamic screens = [
    ProfilePage(),
    HomePage(),
    MyOrdersPage(),
  ];

  @override
  void initState() {
    super.initState();
    // _tabController =  MotionTabController(initialIndex:1, vsync: null);
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: PrimaryText(
            text: currentIndex==0?'البروفايل':currentIndex==1?'الرئيسية':'طلباتي',
            textStyle:
                AppTheme.textTheme.headline3,
          ),
          leading: PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (context) {
              return popupItems
                  .map(
                    (e) => PopupMenuItem(
                      child: PrimaryText(
                          text: e, textStyle: AppTheme.textTheme.bodyText1),
                      value: e,
                    ),
                  )
                  .toList();
            },
            onSelected: (item) {
              int index = popupItems.indexOf(item);
              switch (index) {
                case 0:
                  {
                    log('trueeee');
                    break;
                  }
                case 1:
                  {
                    log('false');
                    break;
                  }
                case 2:
                  {
                    log('false');
                    break;
                  }
              }
            },
          ),
        ),
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        body: screens[currentIndex],

        */
/*bottomNavigationBar: FancyBottomNavigation(
            initialSelection: 1,

            tabs: [
              TabData(iconData: Icons.search, title: "Search",),
              TabData(iconData: Icons.home, title: "Home"),
              TabData(iconData: Icons.shopping_cart, title: "Basket")
            ],
            onTabChangedListener: (position) {
              setState(() {
                currentIndex = position;
              });
            },
          )*//*

        */
/* bottomNavigationBar: MotionTabBar(

          labels: [
            "Account","Home","Dashboard"
          ],
          initialSelectedTab: "Home",
          tabIconColor: Colors.green,
          tabSelectedColor: Colors.red,
          onTabItemSelected: (int value){
            print(value);
            setState(() {
              if(value==2){
                currentIndex=0;
              }else if(value==0){
                currentIndex=2;
              }else{
                currentIndex = value;

              }
            });
          },
          icons: [
            Icons.account_box,Icons.home,Icons.menu
          ],
          textStyle: TextStyle(color: Colors.red),
        ),*//*

      ),
    );
  }
}
*/
