// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:my_tune_admin/general/keywords.dart';
import 'package:my_tune_admin/model/uploads_model/category_model.dart';
import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';

import '../../../general/constants.dart';
import '../../banner_list_page/widgets/custom_catched_network.dart';
import '../../banner_list_page/widgets/custom_memory_image_widget.dart';

class EditCategoryDialogBox extends StatefulWidget {
  const EditCategoryDialogBox({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  final CategoryModel categoryModel;

  @override
  State<EditCategoryDialogBox> createState() => _EditCategoryDialogBoxState();
}

class _EditCategoryDialogBoxState extends State<EditCategoryDialogBox> {
  // bool isnormal = true;
  Uint8List? image;
  bool isloading = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.categoryModel.categoryName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadsPageProvider>(
      builder: (context, state, _) => Column(
        children: [
          const Spacer(),
          Dialog(
            alignment: AlignmentDirectional.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)), //this right here
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 10, right: 10, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const Text(
                        'Update Category',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        height: 170,
                        width: 300,
                        child: InkWell(
                          onTap: () async {
                            if (isloading == false) {
                              await state.pickImage();
                              setState(() {
                                isloading = true;
                              });

                              await upload(state: state);
                            }
                          },
                          child: Card(
                              shadowColor: Colors.black,
                              elevation: 2,
                              child: image == null && isloading == false
                                  ? CustomCatchedNetworkImage(
                                      url: widget.categoryModel.imageUrl)
                                  : InkWell(
                                      onTap: () async {
                                        await state.pickImage();
                                        setState(() {
                                          isloading = true;
                                        });
                                        await upload(state: state);
                                      },
                                      child: isloading == false
                                          ? CustomMemoryImageWidget(
                                              image: image!,
                                              height: 170,
                                              width: 300,
                                            )
                                          : const Center(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            ),
                                    )),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Enter Category Name',
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
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () async {
                            // if (image == null) {
                            //   CustomToast.errorToast('Please select an image');
                            //   return;
                            // }
                            if (controller.text.isEmpty) {
                              CustomToast.errorToast(
                                  'Please add category name');
                              return;
                            }

                            final CategoryModel categoryModel = CategoryModel(
                              id: widget.categoryModel.id,
                              visibility: true,
                              categoryName: controller.text,
                              imageUrl:
                                  state.url ?? widget.categoryModel.imageUrl,
                              timestamp: Timestamp.now(),
                              keywords: getKeywords(controller.text),
                              followers: widget.categoryModel.followers,
                            );

                            await state.updateCategory(
                                categoryModel: categoryModel);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                          child: state.isLoading == false
                              ? const Text(
                                  'Update Category',
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
            radius: 25,
            backgroundColor: Colors.black38,
            child: IconButton(
                color: Colors.white,
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                )),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Future<void> upload({required UploadsPageProvider state}) async {
    state.failureOrSuccess!.fold(
      (failure) {
        failure.maybeMap(
          imagePickerFailure: (_) {
            setState(
              () {
                isloading = false;
              },
            );
          },
          fileSizeExeedFailure: (f) {
            setState(() {
              isloading = false;
            });
            CustomToast.errorToast(
                'this image: ${filesize(f.value)} | maximum file size allowed is 200KB');
          },
          orElse: () => null,
        );
      },
      (success) async {
        log(success.length.toString());
        await state.uploadImage(bytesImage: success);

        setState(() {
          image = success;
          isloading = false;
        });
      },
    );
  }
}
