///Custom exception class to handle various firebase authentication  related errors
class SFormatException implements Exception{
  ///the error code associated with exceptions
  final String message;

  ///Constructor that takes an error code
  const SFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);
  ///Create a format exception from a specific error message
  factory SFormatException.fromMessage(String message) {
    return SFormatException(message);
  }
  ///Get the corresponding error message
  String get formattedMessage => message;
  ///Create a format exception from a specific error code
  factory SFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const SFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const SFormatException('the provided phone number format is invalid. Please enter a valid phone number.');
      case 'invalid-date-format':
        return const SFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const SFormatException('The URL format is invalid. Please enter a valid url.');
      case 'invalid-credit-card-format':
        return const SFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return const SFormatException('The input should be a valid numeric format.');
      case 'invalid-json-format':
        return const SFormatException('The JSON format is invalid. Please ensure the JSON is correctly structured.');
      case 'unexpected-character':
        return const SFormatException('Unexpected character encountered. Please check the input and try again.');
      case 'missing-required-field':
        return const SFormatException('A required field is missing. Please ensure all required fields are provided.');
      case 'out-of-range':
        return const SFormatException('The value is out of the acceptable range. Please enter a valid value.');
      case 'unexpected-end-of-input':
        return const SFormatException('Unexpected end of input. Please check the input and complete the necessary information.');
      default:
        return const SFormatException('An input format error occurred. Please check your data and try again.');
    }
  }
}