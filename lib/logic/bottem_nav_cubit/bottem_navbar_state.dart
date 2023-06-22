part of 'bottem_navbar_cubit.dart';

@immutable
abstract class BottemNavbarState {}

class BottemNavbarInitial extends BottemNavbarState {
  final int index;

  BottemNavbarInitial({required this.index});
}
