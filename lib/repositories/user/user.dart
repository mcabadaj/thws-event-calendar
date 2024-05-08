import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String password;

  const User(this.name, this.password);

  @override
  List<Object> get props => [name];

  static const empty = User('-', '');
}
