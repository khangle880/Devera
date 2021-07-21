class ErrorCode {
  final String errorType;
  final String errorDescription;

  const ErrorCode({required this.errorType, required this.errorDescription});

  String getErrorType() {
    return errorType;
  }

  String getErrorDescription() {
    return errorDescription;
  }
}

//? Errors when using Sign-In
ErrorCode signUpErrorCodes(String errorCode) {
  switch (errorCode) {
    case "weak-password":
      return ErrorCode(
          errorType: "Weak Password!",
          errorDescription: "Your password is weak");
    case "email-already-in-use":
      return ErrorCode(
          errorType: "Email is already in use!",
          errorDescription: "PLease use another Email");
    case "invalid-email":
      return ErrorCode(
          errorType: "Invalid email!",
          errorDescription: "Your email is invalid");
    default:
      return ErrorCode(
          errorType: "Internet connection error!",
          errorDescription: "PLease check your internet connection");
  }
}
//?------------------------------------------------------------------------------

//? Errors when using Sign-Up
ErrorCode signInErrorCodes(String errorCode) {
  switch (errorCode) {
    case "invalid-email":
      return ErrorCode(
          errorType: "Email or Password is invalid!",
          errorDescription: "Your Email or Password is wrong ");
    case "wrong-password":
      return ErrorCode(
          errorType: "Email or Password is invalid!",
          errorDescription: "Your Email or Password is wrong ");
    case "user-not-found":
      return ErrorCode(
          errorType: "Email or Password is invalid!",
          errorDescription: "Your Email or Password is wrong ");
    case "user-disabled":
      return ErrorCode(
          errorType: "Your account have been banned",
          errorDescription:
              "PLease check our website to know why your account has been banned");
    default:
      return ErrorCode(
          errorType: "Internet connection error!",
          errorDescription: "PLease check your internet connection");
  }
}

//?------------------------------------------------------------------------------
