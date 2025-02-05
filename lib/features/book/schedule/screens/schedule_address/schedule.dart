import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import 'package:adventure_rides/features/book/schedule/screens/schedule_address/widgets/single_schedule.dart';
import 'package:adventure_rides/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../personalization/controllers/schedule_controller.dart';
import 'add_new_schedule.dart';


class UserScheduleScreen extends StatelessWidget {
  const UserScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());

    return Scaffold(

      appBar: FixedScreenAppbar(
        title: 'Schedule'
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(SSizes.defaultSpace),
           child: Obx(
             () => FutureBuilder(
               //Use key to trigger refresh
               key: Key(controller.refreshData.value.toString()),
               future: controller.getAllUserSchedules(),
               builder: (context, snapshot) {

                 ///Helper function: handle loader,  no record, or error message
                  final response  = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                  if (response != null) return response;

                  final schedules = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                      itemCount: schedules.length,
                      itemBuilder: (_, index) => SingleSchedule(
                        schedule: schedules[index],
                          onTap: () => controller.selectSchedule(schedules[index]),
                      ),
                  );
                  },
             ),
           ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(onPressed: () => Get.to(() => AddNewScheduleScreen(
          controller: controller,
          onSchedule: (scheduleDetails) {
            // Handle the schedule details here
            if (kDebugMode) {
              print('Schedule Details: $scheduleDetails');
            }
          },
          isRoundTripNotifier: ValueNotifier<bool>(false),
        )),
          child: Icon(Iconsax.add, color: SColors.white),
        ),
      ),
    );
  }
}