import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_management_event.dart';
part 'payment_management_state.dart';

class PaymentManagementBloc
    extends Bloc<PaymentManagementEvent, PaymentManagementState> {
  PaymentManagementBloc() : super(PaymentManagementInitial()) {
    on<PaymentManagementEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
