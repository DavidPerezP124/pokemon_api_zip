///This facilitates some custom functions for this pokemon API
///Available functions are
///```
///nameValidator() // Disallows numbers and special characters except ["_", "-"]
///
///passwordValidator() // Requires a minimum length of 6, at least 1 special character and mixed cases
///
///```
class Utilities {
  Utilities._();

  ///Names can only be alphanumeric (aAzZ, 0-9), with or without underscores and hyphens
  static String nameValidator(String value) {
    if (value.isEmpty) {
      return '*required';
    }
    if (!value.contains(new RegExp(r'^[a-zA-Z0-9_-]'))) {
      return 'Only digits & letters allowed';
    }
    if (value.contains(new RegExp(
        r'^\`|\~|\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\+|\=|\[|\{|\]|\}|\||\\|\<|\,|\.|\>|\?|\/|\""|\;|\:|\s|\'
        '|'))) {
      return 'Permitted special characters are _ and -';
    }
    if (!value.contains(new RegExp(r'^.{4,18}$'))) {
      return 'Must have between 4 and 18 characters';
    }
    return null;
  }

  static String passwordValidator(String value) {
    if (value.isEmpty) {
      return '*required';
    }
    if (!value.contains(new RegExp(r'^(?=.*[0-9])'))) {
      return 'must contain at least 1 digit';
    }
    if (!value.contains(new RegExp(r'(?=.*[a-z])'))) {
      return 'must contain at least 1 lowercase';
    }
    if (!value.contains(new RegExp(r'(?=.*[A-Z])'))) {
      return 'must contain at least 1 uppercase';
    }
    if (value.contains(new RegExp(r'(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\])'))) {
      return 'must contain at least 1 special character';
    }
    if (!value.contains(new RegExp(r'.{8,12}$'))) {
      return 'must have between 8 and 12 characters';
    }
    return null;
  }
}
