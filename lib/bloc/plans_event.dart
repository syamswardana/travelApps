part of 'plans_bloc.dart';

abstract class PlansEvent extends Equatable {
  const PlansEvent();

  @override
  List<Object> get props => [];
}

class RefreshPlans extends PlansEvent {
  final String uid;
  RefreshPlans({this.uid});
  @override
  List<Object> get props => [uid];
}
