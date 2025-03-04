import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/booking_model.dart';

class TrackBookingScreen extends StatefulWidget {
  final BookingModel booking;

  const TrackBookingScreen({super.key, required this.booking});

  @override
  _TrackBookingScreenState createState() => _TrackBookingScreenState();
}

class _TrackBookingScreenState extends State<TrackBookingScreen> {
  GoogleMapController? mapController;
  LatLng? vehicleLocation;
  StreamSubscription<DocumentSnapshot>? vehicleSubscription;

  @override
  void initState() {
    super.initState();
    _listenForVehicleUpdates();
  }

  void _listenForVehicleUpdates() {
    vehicleSubscription = FirebaseFirestore.instance
        .collection('vehicles')
        .doc(widget.booking.id) // Track vehicle based on booking ID
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          vehicleLocation = LatLng(snapshot.get('latitude'), snapshot.get('longitude'));
        });
        mapController?.animateCamera(CameraUpdate.newLatLng(vehicleLocation!));
      }
    });
  }

  @override
  void dispose() {
    vehicleSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Track Your Booking')),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: vehicleLocation ?? const LatLng(0, 0),
          zoom: 14,
        ),
        markers: {
          if (vehicleLocation != null)
            Marker(
              markerId: const MarkerId('vehicle'),
              position: vehicleLocation!,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
        },
      ),
    );
  }
}