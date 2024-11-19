///Custom exception class to handle various firebase authentication  related errors
class SFirebaseException implements Exception{
  ///the error code associated with exceptions
  final String code;
  ///Constructor that takes an error code
  SFirebaseException(this.code);

  ///Get the corresponding error message based on the error code
  String get message{
    switch (code) {
      case 'app-not-authorized':
        return 'The app is not authorized to use Firebase services. Please check your configuration.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'app-offline':
        return 'The app is currently offline. Please check your internet connection.';
      case 'user-token-mismatch':
        return 'The provided user\'s token has a mismatch with the authenticated user\'s user ID.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'app-not-installed':
        return 'The app is not installed on this device. Please install the app and try again.';
      case 'api-key-invalid':
        return 'The API key is invalid. Please check your Firebase configuration.';
      case 'invalid-app-id':
        return 'The app ID is invalid. Please verify your Firebase project settings.';
      case 'invalid-dynamic-link-domain':
        return 'The dynamic link domain is invalid. Please check your dynamic link configuration.';
      case 'invalid-argument':
        return 'The argument provided is invalid. Please check the parameters and try again.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please check your Firebase usage limits.';
      case 'resource-exhausted':
        return 'Resource exhausted. Please check your Firebase project resources.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection and try again.';
      case 'unknown':
        return 'An unknown error occurred. Please try again later.';
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address is not valid. Please check and try again.';
      case 'user-not-found':
        return 'No user found with this email address. Please sign up or check the email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again and try.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'keychain-error':
        return 'A keychain error occurred. Please check the key chain and try again.';
      case 'internal-error':
        return 'An internal authentication error occurred. Please try again later.';
      case 'user-token-expired':
        return 'The user\'s token has expired, and authentication is required. Please sign in again.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}


