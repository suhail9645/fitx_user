import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../constants/lists.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const Divider(),
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
                    List<String> num = ['25', '250', '5'];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          num[index],
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
              onClicked: () {},
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
                      List<String> num = ['25/35', '150/200', '5/10'];
                      List<double> percentage = [0.75, 0.85, .50];
                      return CircularOfReport(
                        title: names[index],
                        contant: num[index],
                        percentage: percentage[index],
                      );
                    })),
              ),
            ),
            ReportRowWidget(
              text: 'WEIGHT',
              buttonText: 'Add',
              onClicked: () {},
            ),
            Container(
                child: SfCartesianChart(

                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    plotAreaBorderColor: Colors.transparent,
                    series: <LineSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                      // Bind data source
                      dataSource: <SalesData>[
                        SalesData('Jan', 35),
                        SalesData('Feb', 28),
                        SalesData('Mar', 34),
                        SalesData('Apr', 32),
                        SalesData('May', 40),
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales)
                ])),
            const Divider(),
            Column(
              children: List.generate(3, (index) {
                List<String> nums = ['65.50', '64.90', '69.99'];
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
            const Divider(),
            spaceforHeight10,
            ReportRowWidget(
              text: 'YOUR JOURNEY',
              buttonText: 'Add',
              onClicked: () {},
            ),
            Stack(
              children: [
                Container(
                  height: screenHeight/3,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 238, 207, 49),
                        Color.fromARGB(255, 214, 255, 7),
                      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}

class ReportRowWidget extends StatelessWidget {
  const ReportRowWidget({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onClicked,
  });
  final String text;
  final String buttonText;
  final Function() onClicked;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 19),
        ),
        Container(
          height: 36,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 214, 219, 66),
                Color.fromARGB(255, 210, 172, 4)
              ])),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: onClicked,
            child: Text(
              buttonText,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

class CircularOfReport extends StatelessWidget {
  const CircularOfReport({
    super.key,
    required this.title,
    required this.contant,
    required this.percentage,
  });
  final String title;
  final String contant;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: CircularPercentIndicator(
        // rotateLinearGradient: true,
        backgroundWidth: 3,
        animation: true,
        animationDuration: 800,
        linearGradient: const LinearGradient(colors: [
          Color.fromARGB(255, 232, 211, 22),
          Color.fromARGB(255, 237, 41, 27),
        ]),
        radius: 36.0,
        lineWidth: 4.0,
        percent: percentage,
        center: TweenAnimationBuilder<Duration>(
            duration: const Duration(seconds: 1),
            tween: Tween(
                begin: const Duration(seconds: 0),
                end: const Duration(seconds: 25)),
            onEnd: () {
              // Navigator.pushReplacementNamed(context, 'ExercisePlay',
              //     arguments: ExercisePlayingScreen(
              //         category: category, index: 0));
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              const textStyle = TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(contant, textAlign: TextAlign.center, style: textStyle),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 193, 191, 191)))
                ],
              );
            }),

        backgroundColor: const Color.fromARGB(255, 51, 49, 49),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
