import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:travelApps/Objek/activity.dart';

part 'activitiescrud_event.dart';
part 'activitiescrud_state.dart';

class ActivitiesCrudBloc
    extends Bloc<ActivitiesCrudEvent, ActivitiesCrudState> {
  ActivitiesCrudBloc() : super(ActivitiesCrudInitial());

  @override
  Stream<ActivitiesCrudState> mapEventToState(
    ActivitiesCrudEvent event,
  ) async* {
    List<Activity> tempActivities = [];
    if (event is AddActivity) {
      if (state is ActivitiesCrudInitial) {
        tempActivities.add(event.activity);
        yield ActivitiesCrudLoaded(activities: tempActivities);
      } else if (state is ActivitiesCrudLoaded) {
        tempActivities.add(event.activity);
        yield ActivitiesCrudLoaded(
            activities:
                (state as ActivitiesCrudLoaded).activities + tempActivities);
      }
    } else if (event is SetToNull) {
      yield ActivitiesCrudInitial();
    } else if (event is DeleteActivity) {
      List<Activity> newList = [];
      tempActivities = (state as ActivitiesCrudLoaded).activities;
      for (var i = 0; i < tempActivities.length; i++) {
        if (i != event.index) newList.add(tempActivities[i]);
      }
      yield ActivitiesCrudLoaded(activities: newList);
      print((state as ActivitiesCrudLoaded).activities.length);
    }
  }
}
