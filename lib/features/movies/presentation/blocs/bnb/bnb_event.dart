part of 'bnb_bloc.dart';

sealed class BnbEvent extends Equatable {
  final int index;
  const BnbEvent(this.index);

  @override
  List<Object> get props => [index];
}

class OnTapBnb extends BnbEvent {
  const OnTapBnb(super.index);
}
