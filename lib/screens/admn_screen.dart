import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';

import '../widgets/side_navigation_page/side_navigation_widget.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  SideMenuController sideMenuController = SideMenuController();
  PageController pageController = PageController();

  @override
  void initState() {
    sideMenuController.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          SizedBox(
            child: SideNavigationWidget(
              sideMenuController: sideMenuController,
            ),
          ),
          Expanded(
            child: Column(children: [
              Expanded(
                child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: pages),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
