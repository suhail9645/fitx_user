import 'package:fitx_user/data_layer/models/user_transformation/result.dart';
import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReportImageStack extends StatelessWidget {
  const ReportImageStack({super.key, required this.size, required this.images});
  final Size size;
  final List<TImage> images;

  @override
  Widget build(BuildContext context) {
    List<Widget> threeImages = [];
    List<Widget> twoImages = [
      CircleAvatar(
        radius: size.width * 0.37,
        backgroundColor: const Color.fromARGB(255, 229, 235, 104),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            images.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DownloadsImageWidget(
                    image: images[index].image!,
                    angle: 0,
                    margin: const EdgeInsets.only(),
                    size: Size(size.width * 0.35, size.height * 0.25),
                  ),
                )),
      )
    ];
    if (images.length > 2) {
      threeImages = [
        CircleAvatar(
          radius: size.width * 0.37,
          backgroundColor: const Color.fromARGB(255, 229, 235, 104),
        ),
        DownloadsImageWidget(
          image: images[images.length - 3].image!,
          angle: 0.34,
          margin: const EdgeInsets.only(left: 140, bottom: 50),
          size: Size(size.width * 0.39, size.height * 0.25),
        ),
        DownloadsImageWidget(
          image: images[images.length - 2].image!,
          angle: -0.34,
          margin: const EdgeInsets.only(right: 140, bottom: 50),
          size: Size(size.width * 0.39, size.height * 0.25),
        ),
        DownloadsImageWidget(
          image: images[images.length - 1].image!,
          angle: 0,
          margin: const EdgeInsets.only(left: 0),
          size: Size(size.width * 0.39, size.height * 0.29),
        )
      ];
    }
    return images.isNotEmpty
        ? SizedBox(
            width: size.width,
            height: size.width - 20,
            child: Stack(
                alignment: Alignment.center,
                children: images.length > 2
                    ? threeImages
                    : images.length > 1
                        ? twoImages
                        : [
                            CircleAvatar(
                              radius: size.width * 0.37,
                              backgroundColor:
                                  const Color.fromARGB(255, 229, 235, 104),
                            ),
                            DownloadsImageWidget(
                              image: images.first.image!,
                              angle: 0,
                              margin: const EdgeInsets.only(left: 0),
                              size: Size(size.width * 0.45, size.height * 0.35),
                            )
                          ]),
          )
        : Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            padding: const EdgeInsets.all(8),
            height: size.height * 0.20,
            width: size.width * 0.80,
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Text(
                '"You can add images every morning or any time ,than you can track and explore your transformation journey"',
                textAlign: TextAlign.center,
              ),
            ),
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
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          margin: margin,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Container(
          margin: margin,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.red),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Something wrong',
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.error)
            ],
          ),
        ),
      ),
    );
  }
}
