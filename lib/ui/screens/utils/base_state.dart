
sealed class BaseState {}

final class BaseInitialState extends BaseState {}
final class BaseLoadingState extends BaseState {}
final class BaseSuccessState<Type> extends BaseState {
  Type? data;
  BaseSuccessState({this.data});
}
final class BaseErrorState extends BaseState {
  String errorMessage;

  BaseErrorState(this.errorMessage);
}
