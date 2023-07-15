import 'package:flutter/material.dart';

class TrendingPageWidget extends StatefulWidget {
  const TrendingPageWidget({super.key});

  @override
  State<TrendingPageWidget> createState() => _TrendingPageWidgetState();
}

class _TrendingPageWidgetState extends State<TrendingPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('trending'),
    );
  }
}
