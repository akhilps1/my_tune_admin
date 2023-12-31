import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/keywords.dart';
import 'package:my_tune_admin/model/product_model/product_model.dart';
import 'package:my_tune_admin/provider/products_page_provider/category_search_provider.dart';
import 'package:my_tune_admin/provider/products_page_provider/products_page_provider.dart';
import 'package:my_tune_admin/serveice/converter.dart';
import 'package:provider/provider.dart';

import '../../../serveice/custom_toast.dart';
import '../../../general/constants.dart';
import '../../banner_list_page/widgets/custom_memory_image_widget.dart';

import 'add_craft_and_crew.dart';
import 'custom_search_widget.dart';

class AddProductDialogBox extends StatefulWidget {
  const AddProductDialogBox({super.key});

  @override
  State<AddProductDialogBox> createState() => _AddProductDialogBoxState();
}

class _AddProductDialogBoxState extends State<AddProductDialogBox> {
  // bool isnormal = true;
  Uint8List? image;
  bool isloading = false;

  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductPageProvider, CategorySearchProvider>(
      builder: (context, state, state1, _) => Column(
        children: [
          Dialog(
            alignment: AlignmentDirectional.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)), //this right here
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 380,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Text(
                              'Publish New Video',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  state1.clearDoc();
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        height: 170,
                        width: 380,
                        child: InkWell(
                          onTap: () async {
                            if (isloading == false) {
                              await state.pickImage();
                              setState(
                                () {
                                  isloading = true;
                                },
                              );

                              await upload(state: state);
                            }
                          },
                          child: Card(
                            shadowColor: Colors.black,
                            elevation: 2,
                            child: image == null
                                ? Center(
                                    child: isloading == false
                                        ? const Icon(
                                            Icons.add,
                                          )
                                        : const CupertinoActivityIndicator(),
                                  )
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
                                            width: 380,
                                          )
                                        : const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                  ),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 380,
                        child: TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, top: 0, bottom: 0),
                            hintText: 'Enter video title',
                            border: OutlineInputBorder(
                              gapPadding: 0,
                            ),
                            errorBorder: OutlineInputBorder(
                              gapPadding: 0,
                            ),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 380,
                        child: TextFormField(
                          controller: descController,
                          maxLines: 4,
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          decoration: const InputDecoration(
                            hintText: 'Enter video description...',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 380,
                        child: ElevatedButton(
                          onPressed: () async {
                            show(context);
                          },
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          ),
                          child: const Text(
                            'Add craft and crew',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                            width: 0.4,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                        width: 380,
                        height: 100,
                        child: const AddCraftAndCrew(),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 380,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                          ),
                          onPressed: () async {
                            if (titleController.text.isEmpty) {
                              CustomToast.errorToast('Title cannot be empty');
                              return;
                            }
                            if (descController.text.isEmpty) {
                              CustomToast.errorToast(
                                  'Descripton cannot be empty');
                              return;
                            }
                            if (state1.categoriesTemp.isEmpty) {
                              CustomToast.errorToast(
                                  'Craft and crew cannot be empty');
                              return;
                            }
                            if (state.url == null) {
                              CustomToast.errorToast('Select image');
                              return;
                            }

                            // Map<String, Map<String, dynamic>> datas = {};

                            // for (var element in state1.categoriesTemp) {
                            //   datas[element.id!] = element.toMap();
                            // }

                            final ProductModel data = ProductModel(
                              categoryId: state.categoryId,
                              title: titleController.text,
                              description: descController.text,
                              imageUrl: state.url!,
                              isTodayRelease: false,
                              isTopThree: false,
                              likes: 0,
                              views: 0,
                              craftAndCrew: convertListToMap(
                                state1.categoriesTemp.toList(),
                              ),
                              visibility: true,
                              keywords: getKeywords(
                                titleController.text,
                              ),
                              timestamp: Timestamp.now(),
                              categories: state1.categoriesTemp.toList(),
                              isTrending: false,
                            );

                            await state.uploadProductDetails(
                              productModel: data,
                            );

                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                          child: state.isLoading == false
                              ? const Text(
                                  'Publish video',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
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
        ],
      ),
    );
  }

  void show(context) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => const Material(
        color: Colors.transparent,
        child: CustomSearchWidget(),
      ),
    );
  }

  Future<void> upload({required ProductPageProvider state}) async {
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
