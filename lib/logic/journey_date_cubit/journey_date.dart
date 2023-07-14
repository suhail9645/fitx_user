import 'package:flutter_bloc/flutter_bloc.dart';

class JourneyDateCubit extends Cubit<int>{
  JourneyDateCubit():super(0);
  void onChanged(int index){
    emit(index);
  }
  
}