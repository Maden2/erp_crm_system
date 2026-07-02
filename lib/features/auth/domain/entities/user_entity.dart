import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String token;
  final String tenantId;
  final int userType;
  final List<String> roles;
  final String expiresIn;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.token,
    required this.tenantId,
    required this.userType,
    required this.roles,
    required this.expiresIn,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    email,
    token,
    tenantId,
    userType,
    roles,
    expiresIn,
  ];
}