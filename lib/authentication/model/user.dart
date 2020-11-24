import 'package:equatable/equatable.dart';

class LoggedUser extends Equatable {
  final String email;
  final String name;
  final String id;
  final String photo;

  LoggedUser({this.email, this.name, this.id, this.photo}) : assert(id != null);

  @override
  List<Object> get props => [email, id, name, photo];

  @override
  String toString() {
    return 'name: $name, email: $email, id: $id';
  }
}
