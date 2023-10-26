class ValidationUtils {
  ValidationUtils._();
  static String? validateEmptyTextField(String? value) {
    if (value != null && value.isEmpty) {
      return '*required';
    }
    return null; // Return null to indicate no error.
  }
}
