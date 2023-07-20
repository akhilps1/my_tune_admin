import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/provider/banner_list_provider/banner_list_page_provider.dart';
import 'package:my_tune_admin/provider/notification_provider/notification_provider.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';
import 'package:my_tune_admin/pages/banner_list_page/widgets/custom_memory_image_widget.dart';
import 'package:my_tune_admin/pages/notification_page/widgets/custom_textfield_widget.dart';
import 'package:provider/provider.dart';

class NotificationPageWidget extends StatelessWidget {
  const NotificationPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    return Consumer2<NotificationProvider, BannerListPageProvider>(
      builder: ((context, state, state1, child) => Column(
            children: [
              AppBar(
                title: const Text(
                  'Sent Notification',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: -1,
              ),
              Expanded(
                child: ListView(
                  children: [
                    kSizedBoxH10,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(8),
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(20),
                              height: 300,
                              width: 1000,
                              color: Colors.white,
                              constraints: const BoxConstraints(
                                maxWidth: 1000,
                                minWidth: 600,
                              ),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "It is not mandatory to provide the image while you are making the notification.",
                                        style: TextStyle(
                                            // fontFamily: "pop",
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          state1.pickImage();
                                        },
                                        child: state1.bytesFromPicker == null
                                            ? Card(
                                                elevation: 5,
                                                child: Container(
                                                    padding: EdgeInsets.zero,
                                                    height: 200,
                                                    width: 200,
                                                    color: Colors.white,
                                                    child: const Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.add),
                                                        Text("Add image"),
                                                      ],
                                                    )),
                                              )
                                            : CustomMemoryImageWidget(
                                                image: state1.bytesFromPicker!,
                                                height: 200,
                                                width: 200,
                                              ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            CustomTextField(
                                              controller: titleController,
                                              hint: "Enter notification title",
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            CustomTextField(
                                              controller: contentController,
                                              hint:
                                                  "Enter notification content",
                                              maxLines: 2,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                MaterialButton(
                                                  color: Colors.black87,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                  ),
                                                  height: 50,
                                                  onPressed: () async {
                                                    if (titleController
                                                        .text.isEmpty) {
                                                      CustomToast.errorToast(
                                                          "Please enter notification title.");
                                                      return;
                                                    } else if (contentController
                                                        .text.isEmpty) {
                                                      CustomToast.errorToast(
                                                          "Please enter notification content.");
                                                      return;
                                                    } else {
                                                      await state
                                                          .callOnFcmApiSendPushNotifications(
                                                        context: context,
                                                        title: titleController
                                                            .text,
                                                        body: contentController
                                                            .text,
                                                      );
                                                      state1.clearData();
                                                      titleController.clear();
                                                      contentController.clear();
                                                    }
                                                  },
                                                  child: state.isSending ==
                                                          false
                                                      ? const Text(
                                                          "Sent",
                                                          style: TextStyle(
                                                            fontFamily: "pop",
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : const CupertinoActivityIndicator(
                                                          color: Colors.white,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
