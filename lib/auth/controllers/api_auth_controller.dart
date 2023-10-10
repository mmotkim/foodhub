// import 'package:flutter/widgets.dart';
// import 'package:foodhub/api/user_api.dart';
// import 'package:foodhub/models/token_entity.dart';
// import 'package:foodhub/models/user_entity.dart';
// import 'package:foodhub/system/system_controller.dart';
// import 'package:provider/provider.dart';

// class ApiAuthController extends ChangeNotifier {
//   final _sys = SystemController();

//   Future<TokenEntity> signUpWithEmail(BuildContext context, String userName,
//       String email, String password) async {
//     _sys.showLoading();
//     final userSignUp = {
//       "userName": userName,
//       "email": email,
//       "password": password
//     };
//     final userResponseEntity = await UserApi.apiSignUp(userSignUp);

//     return TokenEntity(
//         token: userResponseEntity.results.token,
//         refreshToken: userResponseEntity.results.refreshToken);
//   }

//   Future<TokenEntity> signIn(String email, String password) async {
//     final userData = {
//       'email': email,
//       'password': password,
//     };

//     final userResponseEntity = await UserApi.apiSignIn(userData);

//     return TokenEntity(
//       token: userResponseEntity.results.token,
//       refreshToken: userResponseEntity.results.refreshToken,
//     );
//   }

//   Future<UserEntity> getProfile(String token) async {
//     final userResponseEntity = await UserApi.apiGetProfile(token);

//     return userResponseEntity.results;
//   }
// }

