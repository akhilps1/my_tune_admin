// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:my_tune_admin/model/user_model/user_model.dart';

import '../../../general/constants.dart';

class UserContactDetails extends StatelessWidget {
  const UserContactDetails({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withOpacity(
              0.2,
            ),
          ),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.s,
        children: [
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                kSizedBoxW10,
                const Text(
                  'Mobile: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  appUser.mobileNumber,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.5)),
                )
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                kSizedBoxW10,
                const Text(
                  'Email: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  appUser.email,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.5)),
                )
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                kSizedBoxW10,
                const Text(
                  'City: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  appUser.city,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.5)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
