import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/message_section/message_screen.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
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
              buildWhen: (previous, current) =>
                  current is! AllMessagesWithTrainer && current is! WastState,
              builder: (context, state) {
                if (state is MessageInitialState) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Column(
                            children: List.generate( state.allTrainers.length,
                                (index) {
                              return InkWell(
                                onTap: () {
                                  if (user.isPremium!) {
                                    Navigator.pushNamed(context, 'Message',
                                        arguments: MessageScreen(
                                            userOrTrainer: state.allTrainers[index].user!,
                                            channel: state.channel));
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('No Access !'),
                                        content: const Text(
                                            'You have no access to trainer, if you want try our premium.'),
                                        actions: [
                                          ElevatedButtonWithIcon(
                                            text: 'Subscirbe',
                                            onClicked: () {
                                              Navigator.pop(context);

                                              Navigator.pushNamed(
                                                  context, 'Premium',
                                                  arguments: user);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                },
                                child:state.allTrainers[index].user!.id !=
                                          user.id
                                      ?  Container(
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
                                              backgroundImage: NetworkImage(state
                                                      .allTrainers[index]
                                                      .user!
                                                      .profilePicture ??
                                                  "https://picsum.photos/250?image=18"),
                                            ),
                                            spaceforwidth10,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state.allTrainers[index].user!
                                                      .username!,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '${state.allTrainers[index].experience.toString().split(':').last} months Experience',
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.arrow_forward_ios))
                                          ],
                                        )
                                     
                                ) : const SizedBox(),
                              );
                            }),
                          ),
                          Column(
                            children:
                                List.generate(state.allUsers.length, (index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'Message',
                                      arguments: MessageScreen(
                                          userOrTrainer: state.allUsers[index],
                                          channel: state.channel));
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
                                              backgroundImage: NetworkImage(state
                                                      .allUsers[index]
                                                      .profilePicture ??
                                                  "https://picsum.photos/250?image=18"),
                                            ),
                                            spaceforwidth10,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  state.allUsers[index]
                                                      .username!,
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  state.allUsers[index].name!,
                                                  style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 14),
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.arrow_forward_ios))
                                          ],
                                        )
                                    
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
