import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:creator_platform_demo/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? profileImageUrl,
    @Default(false) bool isCreator,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    name: user.name,
    profileImageUrl: user.profileImageUrl,
    isCreator: user.isCreator,
    createdAt: user.createdAt,
    updatedAt: user.updatedAt,
  );
}

extension UserModelX on UserModel {
  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    profileImageUrl: profileImageUrl,
    isCreator: isCreator,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}