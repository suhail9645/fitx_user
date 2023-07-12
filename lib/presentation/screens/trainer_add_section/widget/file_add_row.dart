import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/certificate_cubit/certificate_cubit.dart';
import '../../../constants/colors.dart';

class AddCertificateRow extends StatelessWidget {
  const AddCertificateRow({
    super.key,
    required this.certificates,
    required this.screenHeight,
  });

  final List<File> certificates;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          certificates.length + 1,
          (index) {
            String extension = '';
            if (index < certificates.length) {
              extension = certificates[index].path.split('.').last;
            }
            return index >= certificates.length
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
                        color: extension == 'jpg'
                            ? const Color.fromARGB(255, 233, 195, 83)
                            : extension == 'pdf'
                                ? Colors.red
                                : Colors.redAccent,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(7)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          extension.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
