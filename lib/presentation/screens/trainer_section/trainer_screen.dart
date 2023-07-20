import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/message_section/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/models/user/user.dart';
import '../../../logic/message_bloc/message_bloc.dart';

class TrainerScreen extends StatelessWidget {
  const TrainerScreen({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            return BlocBuilder<MessageBloc, MessageState>(
              buildWhen: (previous, current) => current is !AllMessagesWithTrainer,
              builder: (context, state) {
                
                if(state is MessageInitialState){
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Column(
                          children: List.generate(state.allTrainers.length, (index) {
                            List<String> urls = [
                              "https://via.placeholder.com/150",
                              "https://picsum.photos/250?image=9",
                              "https://picsum.photos/250?image=10",
                              "https://picsum.photos/250?image=11",
                              "https://picsum.photos/250?image=12",
                              "https://picsum.photos/250?image=13",
                              "https://picsum.photos/250?image=14",
                              "https://picsum.photos/250?image=15",
                              "https://picsum.photos/250?image=16",
                              "https://picsum.photos/250?image=17",
                              "https://picsum.photos/250?image=18",
                              "https://picsum.photos/250?image=19",
                              "https://picsum.photos/250?image=20",
                              "https://picsum.photos/250?image=21",
                              "https://picsum.photos/250?image=22"
                            ];
                            List<String> names = [
                              "Aarav",
                              "Advik",
                              "Atharv",
                              "Kiaan",
                              "Viraj",
                              "Syed",
                              "Aarush",
                              "Yug",
                              "Emmanuel",
                              "Ryan",
                              "Muhammad",
                              "Rudra",
                              "Ishaan",
                              "Shivay",
                              "Rudransh"
                            ];

                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'Message',arguments:MessageScreen(userOrTrainer: state.allTrainers[index].user!, channel: state.channel));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: screenHeight * 0.10,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 37, 36, 36),
                                    borderRadius:
                                        BorderRadiusDirectional.circular(7)),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundImage:
                                          NetworkImage(state.allTrainers[index].user!.profilePicture??urls[index]),
                                    ),
                                    spaceforwidth10,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.allTrainers[index].user!.username!,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${state.allTrainers[index].experience} year Experience',
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.arrow_forward_ios))
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                );
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
