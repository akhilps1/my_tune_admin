import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';
import 'package:my_tune_admin/widgets/users_page/widgets/custom_search_field.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: "");
    return Column(
      children: [
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(8),
          height: 400,
          width: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(children: [
            const Text(
              'Search creaft and crew',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            kSizedBoxH10,
            TextFormField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {},
              decoration: InputDecoration(
                hoverColor: Colors.blue[400]!.withOpacity(0.2),
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
                hintText: 'Search carft and crew',
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  gapPadding: 0,
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100]),
            )
          ]),
        ),
        const Spacer(),
      ],
    );
  }
}
