import 'package:fitx_user/data_layer/repositories/user_report_repo/user_completed.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/button_row.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/report_image_stack.dart';
import 'package:fitx_user/presentation/screens/report_section/widget/report_page_alert.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constants/lists.dart';
import 'widget/circular_of_report.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    UserReportRepo().getAllCategoryReport();
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
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
              onClicked: () {
                showDialog(
                  context: context,
                  builder: (context) => ReportPageAlert(screenHeight: screenHeight),
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
            SfCartesianChart(
                palette: const <Color>[
                  Color.fromRGBO(86, 250, 4, 1),
                  Color.fromRGBO(244, 4, 72, 1),
                ],
                // Initialize category axis
                primaryXAxis: CategoryAxis(),
                plotAreaBorderColor: Colors.transparent,
                series: <LineSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                      // Bind data source
                      dataSource: <SalesData>[
                        SalesData('Jan', 35),
                        SalesData('Feb', 34),
                        SalesData('Feb', 38),
                        SalesData('Apr', 32),
                        SalesData('May', 40),
                        SalesData('May', 45),
                        SalesData('Jun', 28),
                        SalesData('Jun', 34),
                        SalesData('Jul', 32),
                        SalesData('Aug', 40),
                        SalesData('Sep', 45),
                        SalesData('Oct', 28),
                        SalesData('Nov', 34),
                        SalesData('Dec', 32),
                        SalesData('Dec', 40),
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales)
                ]),
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

