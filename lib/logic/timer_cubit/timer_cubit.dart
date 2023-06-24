import 'package:flutter_bloc/flutter_bloc.dart';

class WaitPageTimerCubit extends Cubit<bool>{
  WaitPageTimerCubit():super(true);
   void onResumeAndPause(bool isResume){
    emit(isResume);
   }
}