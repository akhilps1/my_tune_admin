import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tune_admin/enums/enums.dart';

import 'package:my_tune_admin/provider/users_page_provider.dart/user_page_provider.dart';
import 'package:my_tune_admin/widgets/users_page/widgets/custom_search_field.dart';
import 'package:provider/provider.dart';
import 'widgets/user_details_widget.dart';

class UserPageWidget extends StatefulWidget {
  const UserPageWidget({super.key});

  @override
  State<UserPageWidget> createState() => _UserPageWidgetState();
}

class _UserPageWidgetState extends State<UserPageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final Size size = MediaQuery.of(context).size;
    return Consumer<UserPageProvider>(
      builder: ((context, state, _) => Column(
            children: [
              AppBar(
                centerTitle: false,
                backgroundColor: Colors.white,
                elevation: 2,
                title: const Text(
                  'Users',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  SizedBox(
                    width: size.width * 0.2,
                    child: Center(
                      child: CustomSearchField(
                        hint: 'Mobile Number',
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onPress: () async {
                          searchController.clear();
                          state.clearDoc();

                          await state.getUsersByLimit(
                            loadstate: GetUserState.normal,
                          );
                        },
                        onFieldSubmitted: (value) async {
                          state.clearDoc();

                          await state.searchUserUsingMobileNumber(
                            loadstate: GetUserState.search,
                            mobileNumber: searchController.text,
                          );
                        },
                        controller: searchController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1000,
                      child: CustomScrollView(
                        slivers: [
                          state.loadDataFromFirebase == false
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: state.users.length,
                                    (context, index) {
                                      final appUser = state.users[index];

                                      return UserDetailsWidget(
                                        appUser: appUser,
                                      );
                                    },
                                  ),
                                )
                              : const SliverFillRemaining(
                                  child: SizedBox(
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),
                          SliverToBoxAdapter(
                            child: state.loadDataFromFirebase == false
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                      child: state.isDataEmpty == false &&
                                              state.users.length >= 7
                                          ? MaterialButton(
                                              color: Colors.black87,
                                              textColor: Colors.white,
                                              height: 50,
                                              minWidth: 200,
                                              onPressed: () async {
                                                if (state.currentState ==
                                                    GetUserState.normal) {
                                                  await state.getUsersByLimit(
                                                    loadstate:
                                                        GetUserState.normal,
                                                  );
                                                } else {
                                                  await state
                                                      .searchUserUsingMobileNumber(
                                                    loadstate:
                                                        GetUserState.search,
                                                    mobileNumber:
                                                        searchController.text,
                                                  );
                                                }
                                              },
                                              child: state.showCircularIndicater ==
                                                      false
                                                  ? const Text(
                                                      'Show More',
                                                    )
                                                  : const CupertinoActivityIndicator(
                                                      color: Colors.white,
                                                    ),
                                            )
                                          : const SizedBox(),
                                    ),
                                  )
                                : null,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
