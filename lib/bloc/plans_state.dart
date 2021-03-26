part of 'plans_bloc.dart';

abstract class PlansState extends Equatable {
  const PlansState();

  @override
  List<Object> get props => [];
}

class PlansInitial extends PlansState {}

class PlansLoaded extends PlansState {
  final List<Plan> plans;
  PlansLoaded({this.plans});

  @override
  List<Object> get props => [plans];
}

class PlansError extends PlansState {}
