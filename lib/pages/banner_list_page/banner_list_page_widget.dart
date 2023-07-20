import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/model/banner_model/banner_model.dart';
import 'package:my_tune_admin/provider/banner_list_provider/banner_list_page_provider.dart';
import 'package:my_tune_admin/serveice/custom_popup.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_catched_network.dart';
import 'widgets/create_banner_dialog_box_widget.dart';
import 'widgets/edit_banner_dialog_box_widget.dart';

class BannerListPageWidget extends StatefulWidget {
  const BannerListPageWidget({super.key});

  @override
  State<BannerListPageWidget> createState() => _BannerListPageWidgetState();
}

class _BannerListPageWidgetState extends State<BannerListPageWidget> {
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<BannerListPageProvider>(
      builder: ((context, state, _) => Column(
            children: [
              AppBar(
                title: const Text(
                  'Banners',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                actions: [
                  IconButton(
                    onPressed: () async {
                      if (state.bannerList.length == 5) {
                        CustomToast.errorToast('maximum 5 banner allowed');
                      } else {
                        await showDialogMeassage(context: context);
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  kSizedBoxW10
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: state.bannerList.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          itemCount: state.bannerList.length,
                          // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 6, mainAxisSpacing: 6,childAspectRatio: 3/2)
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 3 / 2),
                          itemBuilder: ((context, index) {
                            final banner = state.bannerList[index];
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                CustomCatchedNetworkImage(url: banner.imageUrl),
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.1)),
                                    child: PopupMenuButton(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        onSelected: (value) {
                                          if (value == 'Edit') {
                                            CustomPopup.showPopup(
                                              context: context,
                                              title: 'Do you want to edit',
                                              content: '',
                                              buttonText: 'Yes',
                                              onPressed: () {
                                                Navigator.pop(context);
                                                showDialogMeassage(
                                                    context: context,
                                                    bannerModel: banner);
                                              },
                                            );
                                          } else {
                                            CustomPopup.showPopup(
                                              context: context,
                                              title: 'Do you want to delete',
                                              content: '',
                                              buttonText: 'Yes',
                                              onPressed: () {
                                                state.deleteBanner(
                                                  bannerModel: banner,
                                                );
                                                Navigator.pop(context);
                                              },
                                            );
                                          }
                                        },
                                        itemBuilder: ((context) {
                                          return <PopupMenuEntry>[
                                            const PopupMenuItem(
                                              value: 'Edit',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit),
                                                  kSizedBoxW10,
                                                  Text('Edit'),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuItem(
                                                value: 'Delete',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete),
                                                    kSizedBoxW10,
                                                    Text('Delete'),
                                                  ],
                                                ))
                                          ];
                                        })),
                                  ),
                                ),
                              ],
                            );
                          }),
                        )
                      : const Center(
                          child: Text('Empty'),
                        ),
                ),
              ),
            ],
          )),
    );
  }

  Future showDialogMeassage(
      {required BuildContext context, BannerModel? bannerModel}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: bannerModel == null
                ? const CustomCreateBannerDialogBoxWidget()
                : CustomEditBannerDialogBoxWidget(
                    bannerModel: bannerModel,
                  ),
          );
        });
  }
}
