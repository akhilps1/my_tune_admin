import 'package:flutter/material.dart';
import 'package:my_tune_admin/general/constants.dart';

class AddCraftAndCrew extends StatelessWidget {
  const AddCraftAndCrew({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 6 / 1,
            ),
            itemCount: 20,
            itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      kSizedBoxW5,
                      const Text(
                        'ADataDataData',
                      ),
                      const Spacer(),
                      InkWell(
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      kSizedBoxW5,
                    ],
                  ),
                ))
      ],
    );
  }
}
