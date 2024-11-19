///Custom exception class to handle various firebase authentication  related errors
class SFirebaseAuthException implements Exception{
  ///the error code associated with exceptions
  final String code;
  ///Constructor that takes an error code
  SFirebaseAuthException(this.code);

  ///Get the corresponding error message based on the error code
  String get message{
    switch(code) {
      case'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case'user-disabled':
        return 'This user account has been disabled. Please contact support for assistance';
      case'user-not-found':
        return 'Invalid login details. User not found.';
      case'wrong-password':
        return 'Incorrect password. Please check your password and try again';
      case'invalid-verification-code':
        return 'Invalid verification ID. Please request a new verification code.';
      case'quota-exceed':
        return 'Quota exceeded. Please try again later.';
      case'email-already-exists':
        return 'The email address already exists. Please use a different email.';
      case'provider-already-linked':
        return 'The accounts is already linked with another provider.';
      case'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case'user-mismatch':
        return 'The supplied credential do not correspond to the previously signed in user.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again and try.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email but with a different sign-in method.';
      case 'invalid-credential':
        return 'Invalid Credential. Please enter valid credential.';
      case 'session-expired':
        return 'The session has expired. Please request a new verification code.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

}