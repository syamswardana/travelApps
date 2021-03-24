part of 'activitiesonline_bloc.dart';

abstract class ActivitiesOnlineState extends Equatable {
  const ActivitiesOnlineState();

  @override
  List<Object> get props => [];
}

class ActivitiesOnlineInitial extends ActivitiesOnlineState {}

class ActivitiesOnlineLoaded extends ActivitiesOnlineState {
  final List<Activity> activities;
  final List<Activity> deletedActivities;

  ActivitiesOnlineLoaded({this.activities, this.deletedActivities});

  @override
  List<Object> get props => [activities, deletedActivities];
}
