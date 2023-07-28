import 'package:flutter/material.dart';

import '../../../../data_layer/models/category/category_page/result.dart';
import '../../../constants/colors.dart';
import '../../../constants/sized_box.dart';

class DetailesBottemSheet extends StatelessWidget {
  const DetailesBottemSheet(
      {super.key,
      required this.screenHeight,
      required this.category,
      required this.index});

  final double screenHeight;
  final Category category;
  final int index;

  @override
  Widget build(BuildContext context) {
    int lisint = -1;
    List<String> focusedAreas =
        category.exercises[index].focusedArea!.split(',');
    return SizedBox(
      height: screenHeight / 1.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DETAILES',
                  style: TextStyle(fontSize: 23),
                )
              ],
            ),
            const Divider(),
            Container(
              height: screenHeight / 3.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(category.exercises[index].demo!),
                    fit: BoxFit.fill),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        category.exercises[index].name!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  spaceforHeight10,
                  Text(
                    category.exercises[index].description!,
                    textAlign: TextAlign.start,
                  ),
                  const Text(
                    'Focued Area',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: List.generate(
                        focusedAreas.length ~/ 2,
                        (index) => Row(
                              children: List.generate(2, (index2) {
                                lisint++;
                                return Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    title: Text(focusedAreas[lisint]),
                                    leading: const Icon(
                                      Icons.circle,
                                      size: 18,
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }),
                            )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
