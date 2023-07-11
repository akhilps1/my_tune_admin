import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../general/constants.dart';
import '../../banner_list_page/widgets/custom_memory_image_widget.dart';

class AddCategoryDialogBox extends StatelessWidget {
  const AddCategoryDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    kSizedBoxH10,
                    SizedBox(
                      height: 170,
                      width: 300,
                      child: InkWell(
                        onTap: () {},
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
                                    fontSize: 20, fontWeight: FontWeight.w600),
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
    );
  }
}
