import 'package:doneapp_driver/orders.page.core.dart';
import 'package:doneapp_driver/orders_botoombar.page.core.dart';
import 'package:doneapp_driver/shared_module/ui/pages/my_profile.page.profile.dart';
import 'package:doneapp_driver/home.page.core.dart';
import 'package:doneapp_driver/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp_driver/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp_driver/shared_module/controllers/controller.shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LandingPage_Core extends StatefulWidget {
  const LandingPage_Core({super.key});

  @override
  State<LandingPage_Core> createState() => _LandingPage_CoreState();
}

class _LandingPage_CoreState extends State<LandingPage_Core>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final sharedController = Get.find<SharedController>();

  List<int> tabHistory = [];
  late TabController _tabController;
  int _currentIndex = 0;
  bool isConnectivityVisible = false;
  bool isProfileCompletionAsked = false;
  bool isFirstLaunch = true;

  List<Widget> _tabList = [HomePage_Core(), OrdersPageBottomBar_Core(),MyProfilePage_Profile()];

  List<BottomNavigationBarItem> bottomNavigationBarItemsTwo = [
    BottomNavigationBarItem(
      icon: Icon(Ionicons.home_outline, size: APPSTYLE_FontSize24),
      activeIcon: Icon(Ionicons.home, size: APPSTYLE_FontSize24),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.delivery_dining_outlined, size: APPSTYLE_FontSize24),
      activeIcon: Icon(Icons.delivery_dining, size: APPSTYLE_FontSize24),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Ionicons.person_outline, size: APPSTYLE_FontSize24),
      activeIcon: Icon(Ionicons.person, size: APPSTYLE_FontSize24),
      label: "",
    ),
  ];

  @override
  void initState() {
    super.initState();
    // checkNotificationsPermission();
    tabHistory.add(0);
    bool isValidSubscriptionPresent = false;
    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabController.animateTo(_currentIndex);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
        if(_currentIndex==1){
          sharedController.getAllMyOrders();
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _currentIndex == 0
            ? APPSTYLE_PrimaryColor
            : APPSTYLE_BackgroundWhite,
        onDrawerChanged: (isOpened) {},
        body: Container(
            padding: EdgeInsets.only(top: isConnectivityVisible ? 30.0 : 0.0),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _tabList,
            )),
        bottomNavigationBar: Container(
            decoration: APPSTYLE_TopShadowedContainerLargeDecoration.copyWith(
                color: _currentIndex == 0
                    ? APPSTYLE_PrimaryColor
                    : APPSTYLE_BackgroundOffWhite),
            child: BottomNavigationBar(
                selectedFontSize: 0.0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: APPSTYLE_BackgroundOffWhite,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                selectedItemColor: APPSTYLE_PrimaryColor,
                unselectedItemColor: APPSTYLE_Grey60,
                onTap: (int index) {
                  tabHistory.add(index);
                  setState(() {
                    _currentIndex = index;
                  });

                  _tabController.animateTo(_currentIndex);
                },
                items: bottomNavigationBarItemsTwo
                // items:_tabList.length==2?bottomNavigationBarItemsTwo :bottomNavigationBarItemsThree
                )));
  }
}
