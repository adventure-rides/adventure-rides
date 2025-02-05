import 'package:adventure_rides/features/personalization/models/schedule_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constraints/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'cart_item_model.dart';


class BookingModel {
  String id;
  final String userId; //ID of the user making the booking
  final BookingStatus status; //Status of the booking
  final double totalAmount; // Total amount to be paid
  final DateTime bookingDate; // Date when the booking was made
  final String paymentMethod; //Method of payment
  final ScheduleModel? pickupLocation; //Where the tourist will pick up the car
  final ScheduleModel? dropoffLocation; //Where the tourist will drop off the car
  final DateTime? confirmDate; //Date when the booking was confirmed
  final List<CartItemModel> items; //In case of booking multiple cars (optional)
  final bool isRoundTrip; //True if it's a round trip booking

  BookingModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.bookingDate,
    this.paymentMethod = 'Paypal',
    this.pickupLocation,
    this.dropoffLocation,
    this.confirmDate,
    this.isRoundTrip = true,
  });
  String get formattedOrderDate => SHelperFunctions.getFormattedDate(bookingDate);

  String get formattedPickupDate => confirmDate != null ? SHelperFunctions.getFormattedDate(confirmDate!) : '';

  String get bookingStatusText => status == BookingStatus.completed
      ? 'Completed'
      : status == BookingStatus.inProgress
      ? 'Booking in progress'
      : 'Processing...';

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'userId': userId,
      'status': status.toString(), //Enum to string
      'totalAmount': totalAmount,
      'bookingDate': bookingDate,
      'paymentMethod': paymentMethod,
      'pickupLocation': pickupLocation?.toJson(), // Convert AddressModel to map
      'dropoffLocation': dropoffLocation?.toJson(), // Convert AddressModel to map
      'confirmDate': confirmDate,
      'isRoundTrip': isRoundTrip,
      'items' : items.map((item) => item.toJson()).toList(),
    };
  }
  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;

    return BookingModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      status: BookingStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      pickupLocation: ScheduleModel.fromMap(data['pickupLocation'] as dynamic),
      dropoffLocation: ScheduleModel.fromMap(data['dropoffLocation'] as dynamic),
      confirmDate: (data['confirmDate'] as Timestamp).toDate(),
      isRoundTrip: data.containsKey('isRoundTrip') && data['isRoundTrip'] != null ? data['isRoundTrip'] as bool : false,
      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    );
  }
}
