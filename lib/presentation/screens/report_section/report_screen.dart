import 'package:fitx_user/data_layer/models/user_weight/result.dart';
import 'package:fitx_user/data_layer/repositories/user_report_repo/user_completed.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/button_row.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/report_image_stack.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/report_page_alert.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../logic/report_bloc/report_bloc.dart';
import '../../constants/lists.dart';
import 'widget/circular_of_report.dart';

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
        child: Column(
          children: [
            const Divider(),
            BlocConsumer<ReportBloc, ReportState>(listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              if (state is ReportInitialState) {
                return Column(
                  children: [
                    Container(
                      height: screenHeight / 10,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 81, 79, 79),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) {
                            List<int> num = [
                              state.userReport.allCompletedExercise,
                              state.userReport.allCompletedCalorie,
                              state.userReport.allCompletedCategory
                            ];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  num[index].toString(),
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  names[index],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    spaceforHeight10,
                    ReportRowWidget(
                      text: 'WEEK GOAL',
                      buttonText: 'Edit',
                      onClicked: () async {
                        // await  UserReportRepo().getAllUserDetailes();
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
                    Container(
                      height: screenHeight / 7.50,
                      decoration: BoxDecoration(
                        // color: const Color.fromARGB(255, 81, 79, 79),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(3, (index) {
                              List<String> num = [
                                '${state.userReport.thisweekCompletedExercise.toString()}/${state.userReport.exerciseGoal.toString()}',
                                '${state.userReport.thisweekCompletedCalorie.toString()}/${state.userReport.calorieGoal.toString()}',
                                '${state.userReport.thisweekCompletedCategory.toString()}/${state.userReport.categoryGoal.toString()}'
                              ];
                              List<double> percentage = [
                                state.userReport.thisweekCompletedExercise /
                                    state.userReport.exerciseGoal,
                                state.userReport.thisweekCompletedCalorie /
                                    state.userReport.calorieGoal,
                                state.userReport.thisweekCompletedCategory /
                                    state.userReport.categoryGoal
                              ];
                              return CircularOfReport(
                                title: names[index],
                                contant: num[index],
                                percentage: percentage[index] <= 1
                                    ? percentage[index]
                                    : 1,
                              );
                            })),
                      ),
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
                              BlocProvider.of<ReportBloc>(context).add(UpdateWeightEvent(weight: double.parse(currentWeight.text), userReport: state.userReport));
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
                            dataSource:state.userReport.allWeights,
                              
                              xValueMapper: (datum, index) => datum.date.toString(),
                              yValueMapper: (datum, index) => datum.weight),
                        ]),
                    const Divider(),
                    Column(
                      children: List.generate(3, (index) {
                       List<double>weights=[];
                       weights.addAll(state.userReport.allWeights.map((e) => e.weight!));
                       weights.sort();
                        List<String> nums = [state.userReport.allWeights.last.weight!.toString(), weights.last.toString(),weights.first.toString()];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                reportPageWeight[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Text(
                                '${nums[index]} Kg',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 202, 200, 200)),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
            const Divider(),
            spaceforHeight10,
            ReportRowWidget(
              text: 'YOUR JOURNEY',
              buttonText: 'Add',
              onClicked: () {},
            ),
            ReportImageStack(size: size),
            ElevatedButtonWithIcon(
              text: 'View your Journey',
              onClicked: () {
                Navigator.pushNamed(context, 'JourneyView');
              },
            )
          ],
        ),
      ),
    ));
  }
}
