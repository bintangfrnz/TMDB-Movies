import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bnb_event.dart';

class BnbBloc extends Bloc<BnbEvent, int> {
  BnbBloc() : super(0) {
    on<OnTapBnb>((event, emit) => emit(event.index));
  }
}
