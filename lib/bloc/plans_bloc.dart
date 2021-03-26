import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:travelApps/Firebase/model_activity.dart';
import 'package:travelApps/Firebase/model_plan.dart';
import 'package:travelApps/Objek/plan.dart';

part 'plans_event.dart';
part 'plans_state.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  PlansBloc() : super(PlansInitial());

  @override
  Stream<PlansState> mapEventToState(
    PlansEvent event,
  ) async* {
    if (event is RefreshPlans) {
      yield PlansInitial();
      try {
        List<QueryDocumentSnapshot> docs = await ModelPlan.getPlans(event.uid);
        List<Plan> plans = [];
        docs.forEach((doc) {
          plans.add(Plan(
              id: doc.id,
              planName: doc["planName"],
              startDate: (doc["startDate"] as Timestamp).toDate(),
              endDate: (doc["endDate"] as Timestamp).toDate(),
              thumbnail: null));
        });
        yield PlansLoaded(plans: plans);
      } catch (e) {
        yield PlansError();
      }
    }
  }
}
