import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelApps/Objek/activity.dart';

part 'activitiesonline_event.dart';
part 'activitiesonline_state.dart';

class ActivitiesOnlineBloc
    extends Bloc<ActivitiesOnlineEvent, ActivitiesOnlineState> {
  ActivitiesOnlineBloc() : super(ActivitiesOnlineInitial());

  @override
  Stream<ActivitiesOnlineState> mapEventToState(
    ActivitiesOnlineEvent event,
  ) async* {
    // TODO: implement mapEventToState
    List<Activity> tempActivities = [];
    List<Activity> tempDeleted = [];
    if (event is SetActivities) {
      yield ActivitiesOnlineLoaded(activities: event.activities);
    } else if (event is AddActivity) {
      tempActivities.add(event.activity);
      yield ActivitiesOnlineLoaded(
          activities:
              (state as ActivitiesOnlineLoaded).activities + tempActivities);
    } else if (event is DeleteActivity) {
      List<Activity> activities = (state as ActivitiesOnlineLoaded).activities;
      for (var i = 0; i < activities.length; i++) {
        if (i != event.index) {
          tempActivities.add(activities[i]);
        }
      }
      tempDeleted.add(activities[event.index]);
      if ((state as ActivitiesOnlineLoaded).deletedActivities != null) {
        yield ActivitiesOnlineLoaded(
            activities: tempActivities,
            deletedActivities:
                (state as ActivitiesOnlineLoaded).deletedActivities +
                    tempDeleted);
      } else {
        yield ActivitiesOnlineLoaded(
            activities: tempActivities, deletedActivities: tempDeleted);
      }
    } else if (event is SetToError) {
      yield ActivitiesOnlineError(error: event.error);
    }
  }
}
