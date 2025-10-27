class FormValidation {
  const FormValidation._();

  static String? emptyValidator(final String? value, [final String? field]) {
    if (value == null || value.isEmpty) {
      return '${field ?? 'Field'} is required';
    }
    return null;
  }

  static String? nameValidator(final String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required';
    } else if (value.length < 6) {
      return 'Full Name must be at least 6 characters';
    } else {
      return null;
    }
  }

  static String? validatePassword(final String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else {
      return null;
    }
  }

  static String? validateConformPassword(
    final String? value,
    final String password,
  ) {
    if (value == null || value.isEmpty) {
      return 'Confirm password cannot be empty';
    } else if (value.compareTo(password) != 0) {
      return "Confirm password doesn't match with password";
    } else {
      return null;
    }
  }

  static String? validateEmail(final String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }
}
