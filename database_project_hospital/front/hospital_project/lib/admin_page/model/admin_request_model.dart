import 'package:json_annotation/json_annotation.dart';
part 'admin_request_model.g.dart';

@JsonSerializable()
class AdminRequestModel{
  final String name;
  final String address;
  final String phoneNumber;
  final String username;
  final String password;
  final String role;
  final String departmentName;

  AdminRequestModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.username,
    required this.password,
    required this.role,
    required this.departmentName,
  });
  factory AdminRequestModel.fromJson(Map<String, dynamic> json)
  => _$AdminRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdminRequestModelToJson(this);
}