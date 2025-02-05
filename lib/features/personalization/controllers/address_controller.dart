import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/Network/network_manager.dart';
import '../../../common/loaders/circular_loader.dart';
import '../../../common/widgets/Text/section_heading.dart';
import '../../../data/repositories/address/address_repository.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/address_model.dart';
import '../screens/address/add_new_address.dart';
import '../screens/address/widgets/single_address.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  ///Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());

      return addresses;
    }catch (e){
      SLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {return false;},
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const SCircularLoader(text: 'Loading...'),
      );
      // Clear the selected field
      if(selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }
      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //Set the 'selected' field to true for the newly selected address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);

      //Get.back();
    }catch (e){
      SLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }
  ///Add new address
  Future addNewAddress() async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog('Storing Address...', SImages.processAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        SFullScreenLoader.stopLoading();
        return;
      }
      //Form validation
      if(!addressFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }
      //Save address data
      final address = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      //update selected address status
      address.id = id;
      selectedAddress(address);

      //Remove loader
      SFullScreenLoader.stopLoading();

      //Show success message
      SLoaders.successSnackBar(title: 'Congratulations', message: 'Your address has been saved successfully');

      //Refresh addresses data
      refreshData.toggle();

      //Reset fields
      resetFormFields();

      //Redirect
      Navigator.of(Get.context!).pop();


    }catch (e){
      SLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  ///Show addresses modalButtonSheet at checkout
  Future<dynamic> selectedNewAddressPopup(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: const EdgeInsets.all(SSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SSectionHeading(title: 'Select Address', showActionButton: false),
              FutureBuilder(
                  future: getAllUserAddresses(),
                  builder: (_, snapshot) {
                    ///Helper functions: handle loader, no record, or error message
                    final response = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                    if(response != null) return response;

                    // Ensure snapshot.data is not null
                    //final addresses = snapshot.data ?? [];

                    return ListView.builder(
                      shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => SSingleAddress(
                            address: snapshot.data![index],
                            onTap: () async {
                              selectedAddress(snapshot.data![index]);
                              Get.back();
                            },
                        ),
                    );
                  },
              ),
              const SizedBox(height: SSizes.defaultSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.to(() => const AddNewAddressScreen()), child: const Text('Add new address')),
              )
            ],
          ),
        ),
    );
  }

  //Function to reset form fields

    void resetFormFields() {
      name.clear();
      phoneNumber.clear();
      street.clear();
      postalCode.clear();
      city.clear();
      state.clear();
      country.clear();
      addressFormKey.currentState?.reset();
    }
}