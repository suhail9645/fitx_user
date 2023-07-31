import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitx_user/data_layer/models/user_transformation/result.dart';
import 'package:fitx_user/logic/journey_date_cubit/journey_date.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/report_bloc/report_bloc.dart';
import 'widget/delete_widget.dart';
import 'package:intl/intl.dart';
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
    return BlocConsumer<ReportBloc, ReportState>(
      buildWhen: (previous, current) => current is! ImageAddLoadingState,
      // listenWhen: (previous, current) => current is ImageAddLoadingState,
      listener: (context, state) {
        if (state is ImageAddLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please wait a while')));
        }
        if (state is ReportInitialState && state.userReport.tImages.isEmpty) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is ReportInitialState) {
          List<TImage> tImages = state.userReport.tImages;
          BlocProvider.of<JourneyDateCubit>(context)
              .onChanged(tImages.length - 1);
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
                                if (imageIndex.toInt() == tImages.length - 1) {
                                  controller.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.bounceIn);
                                }
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
                    onPageChanged: (value) {
                      BlocProvider.of<JourneyDateCubit>(context)
                          .onChanged(value);
                    },
                    controller: controller,
                    children: List.generate(tImages.length, (index) {
                      // index2=controller.page!.toInt();
                      return CachedNetworkImage(
                        imageUrl:
                            tImages[(tImages.length - 1) - index].image ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
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
                  child: BlocBuilder<JourneyDateCubit, int>(
                    builder: (context, state) {
                      if (state < tImages.length) {
                        String date = tImages[state].date!.split('T').first;
                              final dateFormat = DateFormat('h:mm a');
                                final stringFormat = dateFormat.format(DateTime.parse( tImages[state].date!));
                        return Container(
                          width: screenWidth * 0.85,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(150, 0, 0, 0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  date,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                stringFormat,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
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
