part of 'activitiesonline_bloc.dart';

abstract class ActivitiesOnlineEvent extends Equatable {
  const ActivitiesOnlineEvent();

  @override
  List<Object> get props => [];
}

class AddActivity extends ActivitiesOnlineEvent {
  final Activity activity;
  AddActivity({this.activity});
  @override
  // TODO: implement props
  List<Object> get props => [activity];
}

class DeleteActivity extends ActivitiesOnlineEvent {
  final int index;
  DeleteActivity({this.index});
  @override
  List<Object> get props => [index];
}

class SetActivities extends ActivitiesOnlineEvent {
  final List<Activity> activities;
  SetActivities({this.activities});
  @override
  List<Object> get props => [activities];
}
