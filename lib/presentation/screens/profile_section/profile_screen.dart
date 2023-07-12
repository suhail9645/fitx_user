import 'package:fitx_user/data_layer/models/user/user.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: screenHeight * 0.20,
                    width: screenHeight * 0.20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 241, 219, 16),
                          Color.fromARGB(255, 244, 52, 38),
                        ])),
                    child: CircleAvatar(
                      // radius: 65,
                      backgroundImage: user.profilePicture != null
                          ? NetworkImage('http://10.4.4.26:8000${user.profilePicture}')
                          : null,
                    ),
                  ),
                  spaceforwidth10,
                  ElevatedButtonWithIcon(
                    text: 'Are You A Trainer',
                    width: screenWidth * 0.23,
                    onClicked: () {
                      Navigator.pushNamed(context, 'TrainerAdd',arguments: user.profilePicture);
                    },
                  )
                ],
              ),
              spaceforHeight10,
              Row(
                children: [
                  Text(
                    user.username!,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              spaceforHeight10,
              Column(
                children: List.generate(
                  profileList.length,
                  (index) => ListTile(
                    title: Text(profileList[index]),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_right_outlined,
                          size: 35,
                        )),
                  ),
                ),
              ),
              spaceforHeight20,
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'Premium');
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: screenHeight * 0.11,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(109, 66, 65, 65),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 15,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Align(
                                child: Text(
                              'Pro',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.bold),
                            )),
                          ),
                          const Text(
                            'Upgrade To Premium',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Text('Get Unlimited Access')
                        ],
                      ),
                      const Icon(
                        Icons.arrow_right_outlined,
                        size: 35,
                        color: primaryColor,
                      )
                    ],
                  ),
                ),
              ),
              spaceforHeight20,
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Are You Sure'),
                      content: const Text('Are you Logout from FitX'),
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            SharedPreferences shrd =
                                await SharedPreferences.getInstance();
                            await shrd.clear();
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'signInAndSignUp', (route) => false);
                          },
                          child: const Text('Yes'),
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('No'))
                      ],
                    ),
                  );
                },
                child: Container(
                  height: screenHeight * 0.08,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color: Color.fromARGB(125, 158, 158, 158))),
                  ),
                  child: const Center(
                      child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 19, color: Colors.red),
                  )),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
