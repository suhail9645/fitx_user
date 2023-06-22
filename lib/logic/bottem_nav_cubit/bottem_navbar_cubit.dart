import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottem_navbar_state.dart';

class BottemNavbarCubit extends Cubit<BottemNavbarState> {
  BottemNavbarCubit() : super(BottemNavbarInitial(index: 0));
  void onChanged(int index) {
    emit(BottemNavbarInitial(index: index));
  }
}
