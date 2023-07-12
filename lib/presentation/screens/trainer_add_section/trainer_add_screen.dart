import 'dart:io';
import 'package:fitx_user/logic/certificate_cubit/certificate_cubit.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:fitx_user/presentation/constants/sized_box.dart';
import 'package:fitx_user/presentation/screens/trainer_add_section/widget/file_add_row.dart';
import 'package:fitx_user/presentation/widget/elevated_button_without_icon.dart';
import 'package:fitx_user/presentation/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/trainer_bloc/trainer_bloc.dart';
import '../../widget/rps_painter.dart';

class TrainerAddScreen extends StatelessWidget {
  TrainerAddScreen({super.key, required this.profileUrl});
  final _formKey = GlobalKey<FormState>();
  final String? profileUrl;
  @override
  Widget build(BuildContext context) {
    List<File> certificates = [];
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;
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
                      backgroundImage: profileUrl != null
                          ? NetworkImage('http://10.4.4.26:8000$profileUrl')
                          : const AssetImage('assets/profile.avif')
                              as ImageProvider,
                    ),
                  )
                ],
              ),
            ),
            spaceforHeight20,
            Form(
              key: _formKey,
              child: Column(
                children: List.generate(
                  2,
                  (index) => CustomTextFormField(
                      controller: controllerListOfTrainerAddSection[index],
                      hint: hintListOfTrainerAddSection[index]),
                ),
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
                padding: const EdgeInsets.all(10),
                height: screenHeight * 0.21,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: BlocBuilder<CertificateCubit, CertificateState>(
                  builder: (context, state) {
                    final certificateState = state as CertificateInitial;
                    certificates = certificateState.certificates;
                    return AddCertificateRow(certificates: certificateState.certificates, screenHeight: screenHeight);
                  },
                ),
              ),
            ),
            spaceforHeight20,
            BlocConsumer<TrainerBloc, TrainerState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ElevatedButtonWithIcon(
                  width: screenWidth * 0.70,
                  text: 'Apply',
                  onClicked: () {
                    if (_formKey.currentState!.validate() &&
                        certificates.isNotEmpty &&
                        profileUrl != null) {
                      BlocProvider.of<TrainerBloc>(context)
                          .add(TrainerApplyEvent(certificates: certificates));
                    } else if (certificates.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please add atleast one certificate'),
                        ),
                      );
                    } else if (profileUrl == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please add Your profile picture'),
                        ),
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

