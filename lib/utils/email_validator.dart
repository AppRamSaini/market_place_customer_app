String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please enter email";
  }

  // Basic but reliable email pattern
  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  final regex = RegExp(pattern);

  if (!regex.hasMatch(value.trim())) {
    return "Please enter a valid email address";
  }

  return null; // valid
}
