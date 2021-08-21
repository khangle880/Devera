import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class AuthRepository {
  Future<String> _getUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value;

      return userId;
    } catch (e) {
      throw e;
    }
  }

  Future<String?> attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();

      return session.isSignedIn ? (await _getUserIdFromAttributes()) : null;
    } catch (e) {}
  }

  Future<String?> login({required username, required password}) async {
    print(username);
    try {
      final result =
          await Amplify.Auth.signIn(username: username, password: password);
      return result.isSignedIn ? (await _getUserIdFromAttributes()) : null;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> signUp(
      {required String username,
      required String password,
      required String email}) async {
    final options =
        CognitoSignUpOptions(userAttributes: {'email': email.trim()});

    try {
      final result = await Amplify.Auth.signUp(
        username: username.trim(),
        password: password.trim(),
        options: options,
      );
      return result.isSignUpComplete;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> confirmSignUp(
      {required username, required confirmationCode}) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username.trim(),
        confirmationCode: confirmationCode.trim(),
      );
      return result.isSignUpComplete;
    } catch (e) {
      throw e;
    }
  }

  Future<String> resendSignUpCode({required String username}) async {
    try {
      final result = await Amplify.Auth.resendSignUpCode(username: username);

      return result.codeDeliveryDetails.destination;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      ResetPasswordResult res = await Amplify.Auth.resetPassword(
        username: email,
      );

      return res.isPasswordReset;
    } on AmplifyException catch (e) {
      throw e;
    }
  }

  Future<void> confirmPassword(
      {required String email,
      required String password,
      required confirmationCode}) async {
    try {
      await Amplify.Auth.confirmPassword(
          username: email,
          newPassword: password,
          confirmationCode: confirmationCode);
    } on AmplifyException catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
