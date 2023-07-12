
import 'package:fitx_user/data_layer/models/user_weight/result.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/button_row.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/report_image_stack.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/report_page_alert.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/total_completed_container.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../logic/report_bloc/report_bloc.dart';
import '../../constants/lists.dart';
import 'widget/goal_percentage.dart';
import 'widget/report_skelton.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ReportBloc>(context).add(ReportInitialEvent());
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: BlocConsumer<ReportBloc, ReportState>(
            listener: (context, state) {
              
            },
            builder: (context, state) {
              if (state is ReportInitialState) {
                return Column(
                  children: [
                    Column(
                      children: [
                        TotalCompletedContainer(
                          screenHeight: screenHeight,
                          userReport: state.userReport,
                        ),
                        spaceforHeight10,
                        ReportRowWidget(
                          text: 'WEEK GOAL',
                          buttonText: 'Edit',
                          onClicked: () async {
                            showDialog(
                              context: context,
                              builder: (ctx) => ReportPageAlert(
                                screenHeight: screenHeight,
                                onTap: () {
                                  BlocProvider.of<ReportBloc>(context).add(
                                      UpadateGoalEvent(
                                          int.parse(categoryGoal.text),
                                          int.parse(exerciseGoal.text),
                                          int.parse(caloryGoal.text),
                                          state.userReport));
                                  Navigator.pop(ctx);
                                },
                                goalOrWeight: ReportPageGoalOrWeight.goal,
                                stateKey: _formKey,
                              ),
                            );
                          },
                        ),
                        spaceforHeight10,
                        GoalPercentage(
                          screenHeight: screenHeight,
                          userReport: state.userReport,
                        ),
                        ReportRowWidget(
                          text: 'WEIGHT',
                          buttonText: 'Add',
                          onClicked: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => ReportPageAlert(
                                screenHeight: screenHeight,
                                onTap: () {
                                  BlocProvider.of<ReportBloc>(context).add(
                                      UpdateWeightEvent(
                                          weight:
                                              double.parse(currentWeight.text),
                                          userReport: state.userReport));
                                  Navigator.pop(ctx);
                                },
                                goalOrWeight: ReportPageGoalOrWeight.weight,
                                stateKey: _formKey,
                              ),
                            );
                          },
                        ),
                        SfCartesianChart(
                            palette: const <Color>[
                              Color.fromRGBO(86, 250, 4, 1),
                              Color.fromRGBO(244, 4, 72, 1),
                            ],
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(),
                            plotAreaBorderColor: Colors.transparent,
                            series: <LineSeries<Weight, String>>[
                              LineSeries<Weight, String>(
                                  dataSource: state.userReport.allWeights,
                                  xValueMapper: (datum, index) =>
                                      datum.date.toString(),
                                  yValueMapper: (datum, index) => datum.weight),
                            ]),
                        const Divider(),
                        Column(
                          children: List.generate(3, (index) {
                            List<double> weights = [];
                            weights.addAll(state.userReport.allWeights
                                .map((e) => e.weight!));
                            weights.sort();
                            List<String> nums = [
                              state.userReport.allWeights.last.weight!
                                  .toString(),
                              weights.last.toString(),
                              weights.first.toString()
                            ];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    reportPageWeight[index],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '${nums[index]} Kg',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 202, 200, 200)),
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    const Divider(),
                    spaceforHeight10,
                    ReportRowWidget(
                      text: 'YOUR JOURNEY',
                      buttonText: 'Add',
                      onClicked: () {
                        BlocProvider.of<ReportBloc>(context).add(
                            AddTransformationImage(
                                userReport: state.userReport));
                      },
                    ),
                    ReportImageStack(
                      size: size,
                      images: state.userReport.tImages,
                    ),
                    ElevatedButtonWithIcon(
                      text: 'View your Journey',
                      onClicked: () {
                        Navigator.pushNamed(context, 'JourneyView',
                          );
                      },
                    )
                  ],
                );
              } else if (state is ReportLoadingState) {
                return ReportSkelton(screenHeight: screenHeight);
              } else {
                return const SizedBox();
              }
            }),
      ),
    ));
  }
}
