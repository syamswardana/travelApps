part of 'activitiescrud_bloc.dart';

@immutable
abstract class ActivitiesCrudEvent extends Equatable {}

class AddActivity extends ActivitiesCrudEvent {
  final Activity activity;
  AddActivity({this.activity});

  @override
  List<Object> get props => [activity];
}

class SetToNull extends ActivitiesCrudEvent {
  @override
  List<Object> get props => [];
}

class DeleteActivity extends ActivitiesCrudEvent {
  final int index;

  DeleteActivity({this.index});

  @override
  List<Object> get props => [index];
}
