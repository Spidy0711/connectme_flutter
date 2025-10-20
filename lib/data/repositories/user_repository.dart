import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserRepository {
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=20'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}
