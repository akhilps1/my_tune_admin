import 'package:flutter/material.dart';
import 'package:my_tune_admin/pages/top_three_release/top_three_release_page.dart';

import '../pages/banner_list_page/banner_list_page_widget.dart';
import '../pages/uploads_page/uploads_page_widget.dart';
import '../pages/notification_page/notification_page_widget.dart';
import '../pages/release_page/release_page_widget.dart';
import '../pages/trending_page/trending_page_widget.dart';
import '../pages/users_page/users_page_widget.dart';

const List<Widget> pages = [
  BannerListPageWidget(),
  UploadsPageWidget(),
  UserPageWidget(),
  TrendingPageWidget(),
  ReleasePageWidget(),
  TopThreeReleasePageWidget(),
  NotificationPageWidget(),
];
const kSizedBoxW10 = SizedBox(
  width: 10,
);

const kSizedBoxH10 = SizedBox(
  height: 10,
);

const kSizedBoxH5 = SizedBox(
  height: 5,
);
const kSizedBoxW5 = SizedBox(
  width: 5,
);
// ignore: constant_identifier_names



