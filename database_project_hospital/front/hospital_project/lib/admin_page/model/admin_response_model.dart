import 'package:json_annotation/json_annotation.dart';
part 'admin_response_model.g.dart';

@JsonSerializable()
class AdminResponseModel{
  final int id;
  late final String name;
  final String address;
  final String phoneNumber;
  final String username;
  final String password;
  final String role;
  final String departmentName;

  AdminResponseModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.username,
    required this.password,
    required this.role,
    required this.departmentName,
  });
  factory AdminResponseModel.fromJson(Map<String, dynamic> json)
  => _$AdminResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdminResponseModelToJson(this);
}