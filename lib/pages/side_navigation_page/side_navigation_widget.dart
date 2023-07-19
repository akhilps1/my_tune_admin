import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'package:flutter/material.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:provider/provider.dart';

class SideNavigationWidget extends StatelessWidget {
  const SideNavigationWidget({super.key, required this.sideMenuController});
  final SideMenuController sideMenuController;

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadsPageProvider>(
      builder: (context, state, _) => SideMenu(
        items: [
          SideMenuItem(
            // Priority of item to show on SideMenu, lower value is displayed at the top
            priority: 0,
            title: 'Add Banner',
            onTap: (index, _) {
              sideMenuController.changePage(index);
            },
            icon: const Icon(Icons.view_carousel),
          ),
          SideMenuItem(
            priority: 1,
            title: 'Uploads',
            onTap: (index, _) {
              if (state.show == false) {
                state.showCategories(
                  value: true,
                  categoryId: null,
                  name: null,
                );
              }
              sideMenuController.changePage(index);
            },
            icon: const Icon(
              Icons.cloud_upload,
            ),
          ),
          SideMenuItem(
            priority: 2,
            title: 'User',
            onTap: (index, _) {
              sideMenuController.changePage(index);
            },
            icon: const Icon(Icons.group),
          ),
          SideMenuItem(
            priority: 3,
            title: 'Trending',
            onTap: (index, _) {
              sideMenuController.changePage(index);
            },
            icon: const Icon(Icons.trending_up),
          ),
          SideMenuItem(
            priority: 4,
            title: 'Todays Release',
            onTap: (index, _) {
              sideMenuController.changePage(index);
            },
            icon: const Icon(Icons.new_releases),
          ),
          SideMenuItem(
            priority: 5,
            title: 'Top 3 Release',
            onTap: (index, _) {
              sideMenuController.changePage(index);
            },
            icon: const Icon(
              Icons.interests,
            ),
          ),
          SideMenuItem(
            priority: 6,
            title: 'Notification',
            onTap: (index, _) {
              sideMenuController.changePage(index);
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
        controller: sideMenuController,
        style: SideMenuStyle(
            compactSideMenuWidth: 60,
            selectedIconColor: Colors.white,
            unselectedIconColor: Colors.white,
            itemOuterPadding: EdgeInsets.zero,
            itemInnerSpacing: 16,
            itemBorderRadius: const BorderRadius.all(Radius.zero),
            hoverColor: Colors.white.withOpacity(0.1),
            selectedTitleTextStyle: const TextStyle(color: Colors.white),
            unselectedTitleTextStyle: const TextStyle(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 11, 9, 73)),
        onDisplayModeChanged: (value) {},
      ),
    );
  }
}
