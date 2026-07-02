import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.token,
    required super.tenantId,
    required super.userType,
    required super.roles,
    required super.expiresIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final user = data['user'];

    return UserModel(
      id: user['id'] ?? '',
      fullName: user['fullName'] ?? '',
      email: user['email'] ?? '',
      tenantId: user['tenantId'] ?? '',
      userType: user['userType'] ?? 0,
      roles: List<String>.from(user['roles'] ?? []),
      token: data['token'] ?? '',
      expiresIn: data['expiresIn'] ?? '',
    );
  }
}