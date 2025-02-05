import 'package:adventure_rides/common/appbar/fixed_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  LatLng? userLocation;
  LatLng? vehicleLocation;
  TextEditingController searchController = TextEditingController();
  TextEditingController emergencyReasonController = TextEditingController();
  GoogleMapController? mapController;

  void sendEmergencyAlert() {
    if (emergencyReasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a reason for the emergency.")),
      );
      return;
    }

    FirebaseFirestore.instance.collection('alerts').add({
      'timestamp': Timestamp.now(),
      'status': 'Emergency triggered',
      'reason': emergencyReasonController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Emergency alert sent!")),
    );
  }

  Future<void> setLocationFromSearch(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        LatLng newLocation = LatLng(locations.first.latitude, locations.first.longitude);
        setState(() {
          userLocation = newLocation;
        });
        mapController?.animateCamera(CameraUpdate.newLatLngZoom(newLocation, 14));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location not found: $e")),
      );
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(userLocation!, 14));
  }

  void launchCaller(String phoneNumber) async {
    final Uri url = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  void launchSMS(String phoneNumber) async {
    final Uri url = Uri.parse("sms:$phoneNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FixedAppbar(
        title: Text('Emergency Rescue Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search location',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => setLocationFromSearch(searchController.text),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                ],
              ),
            ),
            SizedBox(
              height: 400,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: userLocation ?? LatLng(0, 0),
                  zoom: 2,
                ),
                markers: {
                  if (userLocation != null)
                    Marker(
                      markerId: MarkerId('user'),
                      position: userLocation!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    ),
                  if (vehicleLocation != null)
                    Marker(
                      markerId: MarkerId('vehicle'),
                      position: vehicleLocation!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    ),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Emergency Alert Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextField(
                    controller: emergencyReasonController,
                    decoration: InputDecoration(
                      hintText: 'Enter reason for emergency',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: sendEmergencyAlert,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: Size(double.infinity, 50)),
                    child: Text('Trigger Emergency', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 16),
                  Text('Emergency Contacts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        leading: Icon(Icons.phone, color: Colors.blue),
                        title: Text('Emergency Helpline'),
                        trailing: Icon(Icons.call, color: Colors.green),
                        onTap: () => launchCaller("+254746036853"), //Enter whatsapp phone number
                      ),
                      ListTile(
                        leading: Icon(Icons.message, color: Colors.blue),
                        title: Text('Tour Guide'),
                        trailing: Icon(Icons.message, color: Colors.orange),
                        onTap: () => launchSMS("+255750823146"), //enter sms phone number
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}