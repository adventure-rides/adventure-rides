///Custom exception class to handle various firebase authentication  related errors
class SPlatformException implements Exception{
  ///the error code associated with exceptions
  final String code;
  ///Constructor that takes an error code
  SPlatformException(this.code);

  ///Get the corresponding error message based on the error code
  String get message{
    switch(code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid Login credentials. Please double check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect Password. Please try again.';
      case 'invalid-phone-number':
        return 'The provided phone number is invalid.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your firebase project.';
      case 'session-cookie-expired':
        return 'The Firebase cookie has expired. Please sign-in again.';
      case 'uid-already-exists':
        return 'The provided user ID is already in use by another user.';
      case 'sign-in-failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'AUTH_INVALID_CREDENTIAL':
        return 'The credentials provided are invalid. Please check your login details and try again.';
      case 'AUTH_USER_NOT_FOUND':
        return 'No user found with the provided credentials. Please check your email or sign up.';
      case 'AUTH_USER_DISABLED':
        return 'This user account has been disabled. Please contact support for assistance.';
      case 'AUTH_INVALID_EMAIL':
        return 'The email address is not valid. Please check and try again.';
      case 'AUTH_EMAIL_ALREADY_IN_USE':
        return 'The email address is already registered. Please use a different email address.';
      case 'AUTH_WEAK_PASSWORD':
        return 'The password is too weak. Please choose a stronger password.';
      case 'AUTH_OPERATION_NOT_ALLOWED':
        return 'This operation is not allowed. Please check your Firebase configuration.';
      case 'AUTH_TOO_MANY_REQUESTS':
        return 'Too many requests have been made. Please try again later.';
      case 'AUTH_REQUIRES_RECENT_LOGIN':
        return 'Recent authentication is required for this operation. Please log in again and try.';
      case 'AUTH_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return 'An account already exists with this email but with a different sign-in method.';
      case 'AUTH_INVALID_VERIFICATION_CODE':
        return 'The verification code is invalid. Please check and try again.';
      case 'AUTH_INVALID_VERIFICATION_ID':
        return 'The verification ID is invalid. Please request a new code.';
      case 'NETWORK_ERROR':
        return 'Network error occurred. Please check your internet connection and try again.';
      case 'TIMEOUT_ERROR':
        return 'The request timed out. Please try again later.';
      case 'invalid-credential':
        return 'Invalid Credential. Please enter valid credential.';
      case 'session-expired':
        return 'The session has expired. Please request a new verification code.';
      case 'UNKNOWN_ERROR':
        return 'An unknown error occurred. Please try again.';
      default:
        return 'An unexpected error occurred. Please try again.';

    }
  }

}

