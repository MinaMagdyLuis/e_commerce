import 'package:dartz/dartz.dart';
import 'package:e_commerce/data/model/Failure.dart';
import 'package:e_commerce/data/model/request/register_auth_body.dart';
import 'package:e_commerce/domain/auth_repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class RegisterUseCase {
  AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  Future<Either<Failure, bool>> register(RegisterAuthBody body)async {
    return authRepo.register(body);
  }
}
