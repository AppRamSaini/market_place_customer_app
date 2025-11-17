String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please provide the email address";
  }

  // Simple email regex
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(value.trim())) {
    return "Please enter a valid email address";
  }

  return null; // valid
}
