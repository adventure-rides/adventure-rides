import 'package:adventure_rides/common/tour_guide/sortable/sortable_guides.dart';
import 'package:adventure_rides/features/book/controllers/all_tour_guides_controller.dart';
import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../Effects/vertical_guide_shimmer.dart';

class AllTourGuides extends StatelessWidget {
  const AllTourGuides({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<TourGuideModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    //Initialize controller for managing car fetching
    final controller = Get.put(AllTourGuidesController());
    return Scaffold(
      appBar: SAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchGuidesByQuery(query),
              builder: (context, snapshot) {
                //Check the state of the FutureBuilder snapshot
                const loader = SVerticalGuideShimmer();
                final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);

                //Return appropriate widget based on snapshot state
                if (widget != null) return widget;

                //Tour guides found!
                final guides = snapshot.data!;

                return SSortableGuides(guides: guides);
              }
          ),
        ),
      ),
    );
  }
}
