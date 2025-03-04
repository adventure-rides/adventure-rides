import 'package:adventure_rides/features/personalization/models/schedule_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constraints/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'cart_item_model.dart';

class BookingModel {
  String id;
  final String userId;
  final BookingStatus status;
  final double totalAmount;
  final DateTime bookingDate;
  final String paymentMethod;
  final ScheduleModel? pickupLocation;
  final DateTime? confirmDate;
  final List<CartItemModel> items;
  final bool isRoundTrip;

  ///Fields for cancellation and refunds
  bool isCanceled;
  DateTime? cancellationDate;
  double refundAmount;

  BookingModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.bookingDate,
    this.paymentMethod = 'VISA',
    this.pickupLocation,
    this.confirmDate,
    this.isRoundTrip = true,

    this.isCanceled = false,
    this.cancellationDate,
    this.refundAmount = 0.0, // Default refund is 0
  });

  /// Getter for Cancelled Status
  bool get isBookingCanceled => isCanceled;

  /// Getter for Refund Status
  String get refundStatus => isCanceled
      ? refundAmount > 0
      ? 'Refunded \$${refundAmount.toStringAsFixed(2)}'
      : 'No refund'
      : 'Active Booking';


  String get formattedBookingDate => SHelperFunctions.getFormattedDate(bookingDate);

  String get formattedPickupDate => confirmDate != null
      ? SHelperFunctions.getFormattedDate(confirmDate!)
      : '';
  String get formattedCancellationDate =>
      cancellationDate != null ? SHelperFunctions.getFormattedDate(cancellationDate!) : 'N/A';

  String get bookingStatusText => status == BookingStatus.completed
      ? 'Completed'
      : status == BookingStatus.inProgress
      ? 'Booking in progress'
      : 'Processing...';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'bookingDate': bookingDate,
      'paymentMethod': paymentMethod,
      'pickupLocation': pickupLocation?.toJson(),
      'confirmDate': confirmDate,
      'isRoundTrip': isRoundTrip,

      'isCanceled': isCanceled = false,
      'cancellationDate': cancellationDate != null ? Timestamp.fromDate(cancellationDate!) : null,
      'refundAmount': refundAmount,

      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory BookingModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return BookingModel(
      id: data['id'] as String, // Use document ID from snapshot
      userId: data['userId'] as String,
      status: BookingStatus.values.firstWhere((e) => e.toString() == data['status']),
      totalAmount: data['totalAmount'] as double,
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'] as String,
      pickupLocation: ScheduleModel.fromMap(data['pickupLocation'] as dynamic),
      confirmDate: data['confirmDate'] == null ? null : (data['confirmDate'] as Timestamp).toDate(),
      isRoundTrip: data['isRoundTrip'] as bool? ?? false,

      isCanceled: data['isCanceled'] ?? false,
      cancellationDate: data.containsKey('cancellationDate') && data['cancellationDate'] != null
          ? (data['cancellationDate'] as Timestamp).toDate()
          : null,
      refundAmount: (data['refundAmount'] as num?)?.toDouble() ?? 0.0,

      items: (data['items'] as List<dynamic>).map((itemData) => CartItemModel.fromJson(itemData as Map<String, dynamic>)).toList(),
    );
  }
}