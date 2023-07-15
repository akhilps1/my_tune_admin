import 'dart:developer';
import 'dart:typed_data';

import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_tune_admin/provider/uploads_page_provider/uploads_page_provider.dart';
import 'package:my_tune_admin/serveice/custom_toast.dart';
import 'package:provider/provider.dart';

import '../../../general/constants.dart';
import '../../banner_list_page/widgets/custom_memory_image_widget.dart';

class UpdateProductDialogBox extends StatefulWidget {
  const UpdateProductDialogBox({super.key});

  @override
  State<UpdateProductDialogBox> createState() => _UpdateProductDialogBoxState();
}

class _UpdateProductDialogBoxState extends State<UpdateProductDialogBox> {
  // bool isnormal = true;
  Uint8List? image;
  bool isloading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController castController = TextEditingController();
  TextEditingController descController = TextEditingController();

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
                  left: 10,
                  right: 10,
                  bottom: 5,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 350,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Text(
                              'Edit Video Details',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
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
                        width: 350,
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
                                              width: 350,
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
                        width: 350,
                        child: TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Enter video title',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: castController,
                          decoration: const InputDecoration(
                            hintText: 'Enter cast and crew',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      kSizedBoxH10,
                      SizedBox(
                        width: 350,
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
                        width: 350,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () async {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
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
