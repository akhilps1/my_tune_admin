import 'package:flutter/material.dart';
import 'package:my_tune_admin/model/user_model/user_model.dart';

import '../../../general/constants.dart';
import 'user_contact_details.dart';
import 'user_personal_details.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    Key? key,
    required this.appUser,
  }) : super(key: key);

  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.black.withOpacity(
                      0.2,
                    ),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 50,
                  ),
                  kSizedBoxH10,
                  Text(appUser.userName),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: UserContactDetails(
                      appUser: appUser,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.s,
                        children: [
                          UserDeatils(
                            title: 'Favorate Singer',
                            content: appUser.favorateSinger,
                          ),
                          UserDeatils(
                            title: 'Age',
                            content: appUser.age,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.s,
                        children: [
                          UserDeatils(
                            title: ' Skills',
                            content: appUser.skills
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                          ),
                          UserDeatils(
                            title: 'Hobbies',
                            content: appUser.hobbies
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
