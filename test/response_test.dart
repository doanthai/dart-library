import 'dart:convert';

import 'package:test/test.dart';
import 'package:dart_library/response.dart';

class User {
  final String firstName;
  final String lastName;

  const User({required this.firstName, required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(firstName: json['firstName'], lastName: json['lastName']);
  }
}

void main() {
  test('Convert Json single data', () {
    const String jsonStr = '{"statusCode": 200, "message": "Success", "data": '
        '{"firstName": "SP", "lastName": "Mobile"}}';
    Response<User, User> resUser = Response.fromJson(jsonDecode(jsonStr), User.fromJson);
    expect(resUser.statusCode, 200);
    expect(resUser.message, "Success");
    expect(resUser.data.firstName, "SP");
    expect(resUser.data.lastName, "Mobile");
  });

  test('Convert Json list data', () {
    const String jsonStr = '{"statusCode": 200, "message": "Success", "data": ['
        '{"firstName": "SP", "lastName": "Mobile"},'
        '{"firstName": "SP1", "lastName": "Mobile1"}]}';
    Response<List<User>, User> resUser = Response.fromJson(jsonDecode(jsonStr), User.fromJson);
    expect(resUser.statusCode, 200);
    expect(resUser.message, "Success");
    expect(resUser.data[0].firstName, "SP");
    expect(resUser.data[0].lastName, "Mobile");
    expect(resUser.data[1].firstName, "SP1");
    expect(resUser.data[1].lastName, "Mobile1");
  });

  test('Convert Json list integer', () {
    const String jsonStr = '{"statusCode": 200, "message": "Success", "data": [1,2,3]}';
    Response<List<int>, int> resUser = Response.fromJson(jsonDecode(jsonStr));
    expect(resUser.statusCode, 200);
    expect(resUser.message, "Success");
    expect(resUser.data[0], 1);
    expect(resUser.data[1], 2);
  });

  test('Convert Json single integer', () {
    const String jsonStr = '{"statusCode": 200, "message": "Success", "data": 1}';
    Response<int, int> resUser = Response.fromJson(jsonDecode(jsonStr));
    expect(resUser.statusCode, 200);
    expect(resUser.message, "Success");
    expect(resUser.data, 1);
  });
}
