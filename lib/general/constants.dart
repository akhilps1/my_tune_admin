import 'package:flutter/material.dart';

import '../widgets/banner_list_page/banner_list_page_widget.dart';
import '../widgets/add_product_page/add_product_page_widget.dart';
import '../widgets/notification_page/notification_page_widget.dart';
import '../widgets/release_page/release_page_widget.dart';
import '../widgets/trending_page/trending_page_widget.dart';
import '../widgets/users_page/users_page_widget.dart';

const List<Widget> pages = [
  BannerListPageWidget(),
  AddProductPageWidget(),
  UserPageWidget(),
  TrendingPageWidget(),
  ReleasePageWidget(),
  NotificationPageWidget()
];
const kSizedBoxW10 = SizedBox(
  width: 10,
);

const kSizedBoxH10 = SizedBox(
  height: 10,
);

// ignore: constant_identifier_names

