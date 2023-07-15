import 'package:flutter/material.dart';

import '../../../general/constants.dart';

class UserDeatils extends StatelessWidget {
  const UserDeatils({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          kSizedBoxW10,
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            content,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.5)),
          )
        ],
      ),
    );
  }
}
