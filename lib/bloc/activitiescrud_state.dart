part of 'activitiescrud_bloc.dart';

@immutable
abstract class ActivitiesCrudState extends Equatable {}

class ActivitiesCrudInitial extends ActivitiesCrudState {
  final List<Activity> activities = [];

  @override
  List<Object> get props => [];
}

class ActivitiesCrudLoaded extends ActivitiesCrudState {
  final List<Activity> activities;
  ActivitiesCrudLoaded({this.activities});

  @override
  List<Object> get props => [activities];

  ActivitiesCrudLoaded copyWith({List<Activity> activities}) {
    return ActivitiesCrudLoaded(activities: activities ?? this.activities);
  }
}
