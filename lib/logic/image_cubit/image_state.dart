part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {
  final File? image;
  final String? groupValue;

  ImageInitial({required this.image, required this.groupValue});
  ImageInitial copyWith(File? image, String? groupValue) => ImageInitial(
      image: image ?? this.image, groupValue: groupValue ?? this.groupValue);
}
