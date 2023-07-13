import '../constants.dart';
String errorMessage(int? statusCode) {
  if (statusCode == 400) {
    return StringConstants.error400;
  } else if (statusCode == 404) {
    return StringConstants.error404;
  } else if (statusCode == 409) {
    return StringConstants.error409;
  } else if (statusCode == 500) {
    return StringConstants.error500;
  } else {
    return StringConstants.initialMsg;
  }
}