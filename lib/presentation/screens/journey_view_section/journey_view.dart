import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:flutter/material.dart';

class JourneyViewScreen extends StatelessWidget {
  const JourneyViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(150, 0, 0, 0),
        actions: [
          InkWell(
            onTap: () {},
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
              children: List.generate(
            5,
            (index) => Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://1.bp.blogspot.com/-yjeluXQXejQ/YHSTsP4VS0I/AAAAAAAAJn8/rq1aEjoceiALiznzIoo4doCgV7rTlPmDQCLcBGAsYHQ/s1350/hot-russian-blond-men-fit-muscular-shirtless-bearded-hunk-selfie.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
          )),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  }
}
