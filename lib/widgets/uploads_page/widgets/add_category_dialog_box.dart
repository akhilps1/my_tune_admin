import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tune_admin/provider/banner_list_provider/banner_list_page_provider.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';
import 'package:my_tune_admin/serveice/pick_image_serveice.dart';
import 'package:provider/provider.dart';

import '../../../failures/main_failures.dart';
import '../../../general/constants.dart';
import '../../banner_list_page/widgets/custom_memory_image_widget.dart';

class AddCategoryDialogBox extends StatelessWidget {
  const AddCategoryDialogBox({super.key});

  // bool isnormal = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<BannerListPageProvider>(
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
                        'Create Category',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        height: 170,
                        width: 300,
                        child: InkWell(
                          onTap: () async {
                            Either<MainFailures, Uint8List> failureOrSuccess =
                                await PickImageServeice.pickImage();

                            failureOrSuccess.fold(
                              (failure) {
                                failure.maybeMap(
                                  imagePickerFailure: (_) {},
                                  fileSizeExeedFailure: (f) {
                                    CustomToast.errorToast(
                                        'this image: ${filesize(f.value)} | maximum file size allowed is 200KB');
                                  },
                                  orElse: () => null,
                                );
                              },
                              (success) {},
                            );
                          },
                          child: const Card(
                              shadowColor: Colors.black,
                              elevation: 2,
                              child: Center(child: Icon(Icons.add))
                              // : InkWell(
                              //     onTap: () {},
                              //     child: CustomMemoryImageWidget(
                              //       image: ,
                              //       height: 170,
                              //       width: 300,
                              //     ),
                              //   )
                              ),
                        ),
                      ),
                      // kSizedBoxH10,
                      // SizedBox(
                      //   width: 300,
                      //   child: DropdownButtonFormField<bool>(
                      //       dropdownColor: Colors.white,
                      //       value: isnormal,
                      //       iconEnabledColor: Colors.black,
                      //       iconDisabledColor: Colors.black,
                      //       decoration: const InputDecoration(
                      //         prefix: Padding(padding: EdgeInsets.only(left: 10)),
                      //         suffix: Padding(padding: EdgeInsets.only(left: 10)),
                      //         border: OutlineInputBorder(
                      //           gapPadding: 0,
                      //         ),
                      //         contentPadding: EdgeInsets.zero,
                      //       ),
                      //       hint: const Text(
                      //         'Select Category',
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //       items: [
                      //         DropdownMenuItem(
                      //           onTap: () {},
                      //           value: true,
                      //           child: const Text('Normal',
                      //               style: TextStyle(
                      //                   letterSpacing: 1.1,
                      //                   fontSize: 14,
                      //                   color: Colors.black)),
                      //         ),
                      //         DropdownMenuItem(
                      //           onTap: () {},
                      //           value: false,
                      //           child: const Text('Trending',
                      //               style: TextStyle(
                      //                   letterSpacing: 1.1,
                      //                   fontSize: 14,
                      //                   color: Colors.black)),
                      //         ),
                      //       ],
                      //       onChanged: (value) {
                      //         setState(() {
                      //           isnormal = value!;
                      //         });
                      //       }),
                      // ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 300,
                        child: TextFormField(
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
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                          child: false == false
                              ? const Text(
                                  'Add Category',
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
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                )),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
