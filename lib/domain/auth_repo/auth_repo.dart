import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/request/register_auth_body.dart';
abstract class AuthRepo {
  Future<Either<Failure, bool>> login(String email, String password);
  Future<Either<Failure, bool>> register(RegisterAuthBody body);
}
