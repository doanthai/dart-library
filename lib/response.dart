/// Response blueprint that wrapper [data] from API.
///
/// [T] is type of [data] and [E] may be [T] or generic type of [T]
///
/// If [T] is [List]/[array] so [E] is generic type of this [List]
///
/// ```dart
/// // Raw data
/// String jsonStr = '{"statusCode": 200, "message": "Success", "data": 1}';
/// Response<int, int> resInt = Response.fromJSON(jsonDecode(jsonStr))
///
/// // Object
/// class User {
///   final String firstName;
///   final String lastName;
///
///   const User({required this.firstName, required this.lastName});
///
///   factory User.fromJson(Map<String, dynamic> json) {
///     return User(firstName: json['firstName'], lastName: json['lastName']);
///   }
/// }
///
/// String jsonStr = '{"statusCode": 200, "message": "Success", "data": {"firstName": "abc", "lastName": "def"}}';
/// Response<User, User> resUser = Response.fromJSON(jsonDecode(jsonStr), User.fromJson);
///
/// // List Object
/// String jsonStr = '{"statusCode": 200, "message": "Success", "data": [{"firstName": "abc", "lastName": "def"}]}';
/// Response<List<User>, User> resUsers = Response.fromJSON(jsonDecode(jsonStr), User.fromJson);
/// ```
///
///
class Response<T, E> {
  final int statusCode;
  final String message;
  final T data;

  Response({required this.statusCode, required this.message, required this.data});

  /// Create single instance [Response] from json data
  factory Response.fromJson(Map<String, dynamic> json, [E Function(Map<String, dynamic>)? constructor]) {
    return Response(
        statusCode: json['statusCode'] as int,
        message: json['message'],
        data: (json['data'] is List<dynamic>)
            ? json['data'].cast().map((e) => constructor != null ? constructor(e) : e as E).toList().cast<E>()
            : constructor != null
                ? constructor(json['data'])
                : json['data'] as E);
  }
}
