import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/auth_response.dart';
import 'package:e_commerce/data/model/request/register_auth_body.dart';
import 'package:e_commerce/data/utils/shared_preference_utils.dart';
import 'package:e_commerce/domain/auth_repo/auth_repo.dart';
import 'package:e_commerce/domain/di/di.dart';
import 'package:e_commerce/ui/screens/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
@Injectable( as: AuthRepo )
class AuthRepoImpl extends AuthRepo {
  Connectivity connectivity;
   AuthRepoImpl(this.connectivity);
  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    final List<ConnectivityResult> connectivityResult = await (connectivity
        .checkConnectivity());
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        Uri uri = Uri.https('ecommerce.routemisr.com', '/api/v1/auth/signin');
        http.Response response = await http.post(
          uri,
          body: {"email": email, "password": password},
        );
        AuthResponse authResponse = AuthResponse.fromJson(
          jsonDecode(response.body),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {

          SharedPreferenceUtils prefs=getIt();
          prefs.saveUser(authResponse.user!);
          prefs.saveToken(authResponse.token!);
          return Right(true);
        } else {
          return Left(
            Failure(
              authResponse.message ??
                 Constants.defaultErrorMessage,
            ),
          );
        }
      } else {
        return Left(NetworkFailure(Constants.networkErrorMessage));
      }
    }  catch (e) {
      return Left(Failure(Constants.networkErrorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> register(RegisterAuthBody body) async {
    final List<ConnectivityResult> connectivityResult = await (connectivity
        .checkConnectivity());
    try {
      if (connectivityResult.contains(ConnectivityResult.wifi) ||
          connectivityResult.contains(ConnectivityResult.mobile)) {
        Uri uri = Uri.https('ecommerce.routemisr.com', '/api/v1/auth/signup');
        http.Response response = await http.post(uri, body: body.toJson());
        AuthResponse authResponse = AuthResponse.fromJson(
          jsonDecode(response.body),
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {

          SharedPreferenceUtils prefs=getIt();
          prefs.saveUser(authResponse.user!);
          prefs.saveToken(authResponse.token!);
          return Right(true);
        } else {
          return Left(Failure(authResponse.message ?? Constants.defaultErrorMessage));
        }
      } else {
        return Left(NetworkFailure(Constants.networkErrorMessage));
      }
    }   catch (e) {
      return Left(Failure(Constants.defaultErrorMessage));    }
  }
}
