// ignore: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';
import 'package:my_tune_admin/widgets/banner_list_page/widgets/custom_catched_network.dart';
import 'package:provider/provider.dart';

import '../../../general/constants.dart';
import '../../../model/banner_list_model/banner_list_model.dart';
import '../../../provider/banner_list_provider/banner_list_page_provider.dart';
import 'custom_memory_image_widget.dart';

class CustomEditBannerDialogBoxWidget extends StatelessWidget {
  const CustomEditBannerDialogBoxWidget({Key? key, required this.bannerModel})
      : super(key: key);

  final BannerModel bannerModel;

  @override
  Widget build(BuildContext context) {
    TextEditingController urlController = TextEditingController();
    urlController.text = bannerModel.videoUrl;
    return Consumer<BannerListPageProvider>(
      builder: (context, state, _) => Column(
        children: [
          Dialog(
            alignment: AlignmentDirectional.center,

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)), //this right here
            child: SizedBox(
              height: 365,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 10, right: 10, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const Text(
                        'Create Banner',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        height: 170,
                        width: 300,
                        child: InkWell(
                          onTap: (() => state.pickImage()),
                          child: Card(
                            shadowColor: Colors.black,
                            elevation: 2,
                            child: state.bytesFromPicker == null
                                ? CustomCatchedNetworkImage(
                                    url: bannerModel.imageUrl)
                                : InkWell(
                                    onTap: () => state.pickImage(),
                                    child: CustomMemoryImageWidget(
                                      image: state.bytesFromPicker!,
                                      height: 170,
                                      width: 300,
                                    )),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: urlController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Video Url',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black54,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () async {
                            if (state.bytesFromPicker != null) {
                              await state.uploadImage(
                                  bytesImage: state.bytesFromPicker!);
                            } else {
                              CustomToast.errorToast(
                                  'Please select a banner image');
                              return;
                            }

                            if (state.url != null) {
                              await state.updateBanner(
                                bannerModel: BannerModel(
                                  id: bannerModel.id,
                                  imageUrl: state.url!,
                                  videoUrl: urlController.text,
                                  timestamp: Timestamp.now(),
                                ),
                              );
                            }

                            urlController.text = '';
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            state.clearData();
                          },
                          child: state.isLoading == false
                              ? const Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )
                              : const CupertinoActivityIndicator(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 33,
            backgroundColor: Colors.black38,
            child: IconButton(
                color: Colors.white,
                style: IconButton.styleFrom(
                  hoverColor: Colors.grey,
                ),
                onPressed: () {
                  urlController.text = '';
                  state.clearData();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                )),
          )
        ],
      ),
    );
  }
}
