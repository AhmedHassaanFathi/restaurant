import '../../../auth/data/models/login_response_model.dart';

abstract class UserState{}

class UserInitial extends UserState{}
class UserLoading extends UserState{}
class UserSuccess extends UserState
{
  UserModel user;
  UserSuccess({required this.user});
}
class UserError extends UserState
{
  String error;
  UserError({required this.error});
}
