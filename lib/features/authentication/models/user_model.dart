// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatbotstudy/utils/constants/image_strings.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String fatherName;
  final String motherName;
  final String phone;
  final String fatherPhone;
  String image;

  User({
    required this.fatherName,
    required this.motherName,
    required this.fatherPhone,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.image,
  });

  factory User.fromJson(jsonData) => User(
        id: jsonData['id'],
        firstName: jsonData['first_name'],
        lastName: jsonData['last_name'],
        phone: jsonData['phone'],
        image: jsonData['icon_url'] ?? AppImages.user,
        fatherName: jsonData['father_name'],
        motherName: jsonData['mother_name'],
        fatherPhone: jsonData['father_phone'],
      );

  toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'icon_url': image,
        'father_name': fatherName,
        'mother_name': motherName,
        'father_phone': fatherPhone,
      };

  String get fullName => '$firstName $lastName';

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, fatherName: $fatherName, motherName: $motherName, phone: $phone, fatherPhone: $fatherPhone, image: $image)';
  }
}
