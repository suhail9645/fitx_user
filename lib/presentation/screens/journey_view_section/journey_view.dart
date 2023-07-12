import 'package:fitx_user/data_layer/models/user_transformation/result.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/report_bloc/report_bloc.dart';
import 'widget/delete_widget.dart';

class JourneyViewScreen extends StatelessWidget {
  const JourneyViewScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();

    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    // double screenHeight = size.width;
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        if (state is ReportInitialState) {
          List<TImage> tImages = state.userReport.tImages;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(150, 0, 0, 0),
              actions: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => DeleteAlertWidget(
                              onTap: () {
                                double imageIndex = controller.page!;
                                int imageId = tImages[(tImages.length - 1) -
                                        imageIndex.toInt()]
                                    .id!;
                                tImages.removeAt(
                                    (tImages.length - 1) - imageIndex.toInt());
                                BlocProvider.of<ReportBloc>(context).add(
                                    DeleteTransformationImage(
                                        tImages: tImages,
                                        userReport: state.userReport,
                                        id: imageId));
                                  Navigator.pop(ctx);
                              },
                            ));
                  },
                  child: Container(
                    height: 32,
                    width: 78,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadiusDirectional.circular(4)),
                    child: const Center(
                        child: Text(
                      'Delete',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                spaceforwidth10,
              ],
            ),
            body: Stack(
              children: [
                PageView(
                    controller: controller,
                    children: List.generate(tImages.length, (index) {
                      return Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  tImages[(tImages.length - 1) - index].image!),
                              fit: BoxFit.fill),
                        ),
                      );
                    })),
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.black,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0.89),
                  child: Container(
                    width: screenWidth * 0.85,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(150, 0, 0, 0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '01/09/2030',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '06:55',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

