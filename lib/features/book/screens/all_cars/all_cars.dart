import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/cars/sortable/sortable_cars.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../Effects/vertical_car_shimmer.dart';
import '../../controllers/all_cars_controller.dart';
import '../../models/car_model.dart';

class AllCars extends StatelessWidget {
  const AllCars({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<CarModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    //Initialize controller for managing car fetching
    final controller = Get.put(AllCarsController());
    return Scaffold(
      appBar: SAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchCarsByQuery(query),
            builder: (context, snapshot) {
              //Check the state of the FutureBuilder snapshot
              const loader = SVerticalCarShimmer();
              final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

              //Return appropriate widget based on snapshot state
              if (widget != null) return widget;

              //Cars found!
              final cars = snapshot.data!;

              return SSortableCars(cars: cars);
            }
          ),
        ),
      ),
    );
  }
}
