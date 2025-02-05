import 'package:adventure_rides/features/book/screens/all_cars/all_cars.dart';
import 'package:adventure_rides/features/book/screens/all_guides/all_tour_guides.dart';
import 'package:adventure_rides/route/routes.dart';
import 'package:get/get.dart';
import '../features/authentication/screens/Login/login.dart';
import '../features/authentication/screens/home/widgets/home.dart';
import '../features/authentication/screens/onboarding/onboarding.dart';
import '../features/authentication/screens/password_configuration/forget_password.dart';
import '../features/authentication/screens/profile/profile.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/book/reservation/reservations.dart';
import '../features/book/screens/booking/bookings.dart';
import '../features/book/screens/car_reviews/car_reviews_screen.dart';
import '../features/book/screens/cart/cart.dart';
import '../features/book/screens/checkout/checkout.dart';
import '../features/book/screens/trip_hub/trip_hub.dart';
import '../features/book/screens/wishlist/wishlist.dart';
import '../features/personalization/screens/address/address.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: SRoutes.home, page: () => const HomeScreen()),
    GetPage(name: SRoutes.tripHub, page: () => const TripHubScreen()),
    GetPage(name: SRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: SRoutes.settings, page: () => const TripHubScreen()),
    GetPage(name: SRoutes.carReviews, page: () => const CarReviewsScreen()),
    GetPage(name: SRoutes.booking, page: () => const BookingScreen()),
    GetPage(name: SRoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: SRoutes.cart, page: () => const CartScreen()),
    GetPage(name: SRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: SRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: SRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: SRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: SRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: SRoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: SRoutes.onBoarding, page: () => const OnBoardingScreen()),

    GetPage(name: SRoutes.vehicles, page: () => AllCars(title: '')),
    GetPage(name: SRoutes.bookVehicle, page: () => AllCars(title: '')),
    GetPage(name: SRoutes.bookRide, page: () => BookingScreen()),
    GetPage(name: SRoutes.viewCars, page: () => AllCars(title: '')),
    GetPage(name: SRoutes.exploreGuides, page: () => AllTourGuides(title: '')),
    GetPage(name: SRoutes.reserve, page: () => ReservationsScreen()),

  ];
}