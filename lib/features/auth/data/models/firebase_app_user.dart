import 'package:auth_app/features/auth/domain/entities/app_user.dart';

class UserModel extends AppUser {
  UserModel({required super.uid, required super.email, required super.name});

  // Convert JSON (from Firebase) to UserModel (data) model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'], email: json['email'], name: json['name']);
  }

  // Convert UserModel (data) to JSON (for Firebase)
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email, 'name': name};
  }
}
