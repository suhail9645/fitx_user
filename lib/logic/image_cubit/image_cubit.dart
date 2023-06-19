import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
 
  ImageCubit() : super(ImageInitial(image: null,groupValue: null));

  void imagePicking(ImageSource source,String? groupValue)async{
    final image=await ImagePicker().pickImage(source: source);
    if(image!=null){
      emit(ImageInitial(image: File(image.path), groupValue:groupValue));
    }
  }
  void onChangeRadio(String groupValue,File? image){
   emit(ImageInitial(image:image, groupValue:groupValue));
  }
}

