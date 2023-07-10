import 'package:fitx_user/logic/certificate_cubit/certificate_cubit.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainerAddScreen extends StatelessWidget {
  const TrainerAddScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.62,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    height: screenHeight * 0.56,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/login.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: screenHeight * 0.17,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(165, 12, 12, 12)),
                          child: const Text(
                            'If You are a Trainer ,You have a great opportunity to build a dream career in fitness ,you can join as trainer and work with professionals',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17, color: primaryColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.60),
                    child: CustomPaint(
                      size: Size(double.maxFinite, screenHeight / 3),
                      painter: RPSCustomPainter(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: screenHeight * 0.10,
                      backgroundImage: const NetworkImage(
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg'),
                    ),
                  )
                ],
              ),
            ),
            spaceforHeight20,
            Column(
              children: List.generate(
                2,
                (index) => CustomTextFormField(
                    controller: controllerListOfTrainerAddSection[index],
                    hint: hintListOfTrainerAddSection[index]),
              ),
            ),
            spaceforHeight10,
            const Text(
              'Add Certificates',
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(10),
                height: screenHeight * 0.21,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: BlocBuilder<CertificateCubit, CertificateState>(
                  builder: (context, state) {
                    final certificateState = state as CertificateInitial;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              certificateState.certificates.length + 1, (index) {
                                 String extension='';
                                if(index<certificateState.certificates.length){
                          extension=certificateState.certificates[index].path.split('.').last;
                                }
                        return index >= certificateState.certificates.length
                            ? InkWell(
                                onTap: () {
                                  BlocProvider.of<CertificateCubit>(context)
                                      .certificatePicking();
                                },
                                child: Container(
                                  // height: screenHeight*0.17,
                                  width: screenHeight * 0.14,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_upload,
                                        size: 35,
                                      ),
                                      Text('Add Files')
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: screenHeight * 0.14,
                                decoration: BoxDecoration(
                                  color: extension=='jpg'?const Color.fromARGB(255, 233, 195, 83):extension=='pdf'?Colors.red:Colors.redAccent,
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(7)),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    
                                    Text(extension.toUpperCase(),style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)],
                                ),
                              );
                      })),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 27, 25, 25)
      ..style = PaintingStyle.fill;

    Path path0 = Path();
    path0.moveTo(size.width, size.height * 0.9984125);
    path0.lineTo(size.width * 0.0057143, size.height * 0.9983042);
    path0.lineTo(size.width, size.height * 0.5415755);
    path0.lineTo(size.width, size.height * 0.9984125);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
