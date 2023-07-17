import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitx_user/data_layer/repositories/user_report_repo/user_add_repo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../data_layer/models/user/user.dart';
part 'premium_state.dart';

class PremiumCubit extends Cubit<PremiumState> {
  PremiumCubit() : super(PremiumInitial());
  void subscribeEvent(User user) async {
    Razorpay razorpay = Razorpay();
      UserAddToPrimeRepo().addUserPrime();
    var options = {
      'key': 'rzp_test_NrP2oHZNW6MhM2',
      'amount': 10000,
      'name': 'FitX.',
      'description': 'Premium',
      'prefill': jsonEncode(user)
    };
    razorpay.open(options);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, ()  {
     UserAddToPrimeRepo().addUserPrime();
      emit(PremiumSuccessState());
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, () {
      emit(PremiumErrorState());
    });
  }
}
