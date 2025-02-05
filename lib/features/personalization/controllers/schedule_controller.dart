import 'package:adventure_rides/features/book/schedule/screens/schedule_address/widgets/single_schedule.dart';
import 'package:adventure_rides/features/personalization/models/schedule_model.dart';
import 'package:adventure_rides/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/Network/network_manager.dart';
import '../../../common/loaders/circular_loader.dart';
import '../../../common/widgets/Text/section_heading.dart';
import '../../../data/repositories/schedule/schedule_repository.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../book/schedule/screens/schedule_address/add_new_schedule.dart';

class ScheduleController extends GetxController {
  static ScheduleController get instance => Get.find();

  final pickupLocation = TextEditingController();
  final pickupDate = TextEditingController();
  final pickupTime = TextEditingController();
  final dropoffLocation = TextEditingController();
  final dropoffDate = TextEditingController();
  final dropoffTime = TextEditingController();

  GlobalKey<FormState> scheduleFormKey = GlobalKey<FormState>();

  // State variable to track if the trip is a round trip
  ValueNotifier<bool> isRoundTrip = ValueNotifier<bool>(false);

  RxBool refreshData = true.obs;
  final Rx<ScheduleModel> selectedSchedule = ScheduleModel.empty().obs;
  final scheduleRepository = Get.put(ScheduleRepository());

  ///fetch all user specific schedules
  Future<List<ScheduleModel>> getAllUserSchedules() async {
    try{
      final schedules = await scheduleRepository.fetchUserSchedules();
      selectedSchedule.value = schedules.firstWhere((element) => element.selectedSchedule, orElse: () => ScheduleModel.empty());
      return schedules;
    }catch (e) {
      SLoaders.errorSnackBar(title: 'Schedule not found', message: e.toString());
      return [];
    }
  }
  Future selectSchedule(ScheduleModel newSelectedSchedule) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async { return false; },
        backgroundColor: Colors.transparent,
        content: const SCircularLoader(text: ''),
      );

      if (kDebugMode) {
        print('Attempting to select schedule with ID: ${newSelectedSchedule.id}');
      }
      // Clear the selected field for the previously selected schedule
      if (selectedSchedule.value.id.isNotEmpty) {
        await scheduleRepository.updateSelectedField(selectedSchedule.value.id, false);
        selectedSchedule.value.selectedSchedule = false; // Update local state
      }

      // Assign new selected schedule
      newSelectedSchedule.selectedSchedule = true;
      selectedSchedule.value = newSelectedSchedule;

      // Set the "selected" field to true for the newly selected schedule
      await scheduleRepository.updateSelectedField(newSelectedSchedule.id, true);

      Get.back();
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Error in Selection', message: e.toString());
    }
  }

  ///Add new address
  Future<void> addNewSchedule() async {
    try {
      // Display loading indicator
      SFullScreenLoader.openLoadingDialog('Storing Schedule...', SImages.processAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        SLoaders.errorSnackBar(title: 'No Internet', message: 'Please check your connection.');
        return;
      }

      // Validate the form
      if (!scheduleFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        SLoaders.errorSnackBar(title: 'Invalid Input', message: 'Please correct the errors in the form.');
        return;
      }

      // Save schedule data
      final schedule = ScheduleModel(
        id: '',
        pickupLocation: pickupLocation.text.trim(),
        pickupDate: pickupDate.text.trim(),
        pickupTime: pickupTime.text.trim(),
        dropoffLocation: dropoffLocation.text.trim(),
        dropoffDate: dropoffDate.text.trim(),
        dropoffTime: dropoffTime.text.trim(),
        isRoundTrip: isRoundTrip.value,
        selectedSchedule: true,
      );
      // Add the schedule to the repository
      final id = await scheduleRepository.addSchedule(schedule);

      // Update the selected schedule status
      schedule.id = id;
      await selectSchedule(schedule);

      //Remove the loader
      SFullScreenLoader.stopLoading();

      //Show success message
      SLoaders.successSnackBar(title: 'Success', message: 'Your schedule has been saved successfully.');

      // Refresh the data
      refreshData.toggle();

      // Reset the form
      resetFormFields();

      // Redirect the user
      //Redirect
      Navigator.of(Get.context!).pop();
      //Get.back();
    } catch (e, stackTrace) {
      debugPrint('Error in addNewSchedule: $e\n$stackTrace');
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
  /*
  Future addNewSchedule() async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog('Storing Schedule...', SImages.processAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        return;
      }
      //Form validation
      if(!scheduleFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }
      //Save address data
      final schedule = ScheduleModel(
        id: '',
        pickupLocation: pickupLocation.text.trim(),
        pickupDate: pickupDate.text.trim(),
        pickupTime: pickupTime.text.trim(),
        dropoffLocation: dropoffLocation.text.trim(),
        dropoffDate: dropoffDate.text.trim(),
        dropoffTime: dropoffTime.text.trim(),
        isRoundTrip: true,
        selectedSchedule: true,
      );
      final id = await scheduleRepository.addSchedule(schedule);

      //update selected address status
      schedule.id = id;
      selectedSchedule(schedule);

      //Remove loader
      SFullScreenLoader.stopLoading();

      //Show success message
      SLoaders.successSnackBar(title: 'Congratulations', message: 'Your schedule has been saved successfully');

      //Refresh addresses data
      refreshData.toggle();

      //Reset fields
      resetFormFields();

      //Redirect
      Navigator.of(Get.context!).pop();
    }catch (e){
      SLoaders.errorSnackBar(title: 'Schedule not found', message: e.toString());
    }
  }
  */

  Map<String, dynamic> getScheduleDetails() {
    return {
      'pickupLocation': pickupLocation.text,
      'pickupDate': pickupDate.text,
      'pickupTime': pickupTime.text,
      'dropoffLocation': dropoffLocation.text,
      'dropoffDate': dropoffDate.text,
      'dropoffTime': dropoffTime.text,
      'isRoundTrip': isRoundTrip.value, // Include round trip status
    };
  }
  ///Show addresses modalButtonSheet at checkout
  Future<dynamic> selectNewSchedulePopup(BuildContext context){
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(SSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SSectionHeading(title: 'Select Schedule', showActionButton: false),
            FutureBuilder(
              future: getAllUserSchedules(),
              builder: (_, snapshot) {
                ///Helper functions: handle loader, no record, or error message
                final response = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                if(response != null) return response;

                // Ensure snapshot.data is not null
                //final addresses = snapshot.data ?? [];

                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => SingleSchedule(
                      schedule: snapshot.data![index],
                      onTap: () async {
                        await selectSchedule(snapshot.data![index]);
                        Get.back();
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: SSizes.defaultSpace * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.to(() => AddNewScheduleScreen(
                //controller: controller,
                controller: ScheduleController.instance,
                onSchedule: (scheduleDetails) {
                  // Handle the schedule details here
                  if (kDebugMode) {
                    print('Schedule Details: $scheduleDetails');
                  }
                },
                isRoundTripNotifier: ValueNotifier<bool>(false),
              )), child: const Text('Add new Schedule')),
            )
          ],
        ),
      ),
    );
  }

  ///Function to reset form fields
  void resetFormFields() {
    pickupLocation.clear();
    pickupDate.clear();
    pickupTime.clear();
    dropoffLocation.clear();
    dropoffDate.clear();
    dropoffTime.clear();
    isRoundTrip.value = false; // Reset round trip state
    scheduleFormKey.currentState?.reset();
  }
}