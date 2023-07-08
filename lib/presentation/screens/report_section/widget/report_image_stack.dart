import 'package:flutter/material.dart';

class ReportImageStack extends StatelessWidget {
  const ReportImageStack({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.width - 20,
      child: Stack(alignment: Alignment.center, children: [
        CircleAvatar(
          radius: size.width * 0.37,
          backgroundColor: const Color.fromARGB(255, 229, 235, 104),
        ),
        DownloadsImageWidget(
          image: 'https://i.redd.it/bqspaohir0p71.jpg',
          angle: 0.34,
          margin: const EdgeInsets.only(left: 140, bottom: 50),
          size: Size(size.width * 0.39, size.height * 0.25),
        ),
        DownloadsImageWidget(
          image: 'https://i.redd.it/bqspaohir0p71.jpg',
          angle: -0.34,
          margin: const EdgeInsets.only(right: 140, bottom: 50),
          size: Size(size.width * 0.39, size.height * 0.25),
        ),
        DownloadsImageWidget(
          image:
              'https://i.pinimg.com/originals/ab/1e/08/ab1e08d530a418d1efb79a5f726c9ae9.jpg',
          angle: 0,
          margin: const EdgeInsets.only(left: 0),
          size: Size(size.width * 0.39, size.height * 0.29),
        )
      ]),
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    super.key,
    required this.image,
    required this.angle,
    required this.margin,
    required this.size,
  });

  final String image;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: angle,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
