// lib/data/models/user_model.dart

class UserModel {
  final String name;
  final int age;
  final String city;
  final String country;
  final String imageUrl;

  UserModel({
    required this.name,
    required this.age,
    required this.city,
    required this.country,
    required this.imageUrl,
  });

  // From JSON - handles RandomUser API format
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle name - can be String or Object
    String parsedName = '';
    if (json['name'] is String) {
      parsedName = json['name'];
    } else if (json['name'] is Map) {
      final nameMap = json['name'] as Map<String, dynamic>;
      final first = nameMap['first']?.toString() ?? '';
      final last = nameMap['last']?.toString() ?? '';
      parsedName = '$first $last'.trim();
    }

    // Handle age/dob
    int parsedAge = 0;
    if (json['age'] is int) {
      parsedAge = json['age'];
    } else if (json['dob'] is Map) {
      parsedAge = json['dob']['age'] ?? 0;
    }

    // Handle location/city
    String parsedCity = '';
    if (json['city'] is String) {
      parsedCity = json['city'];
    } else if (json['location'] is Map) {
      final locationMap = json['location'] as Map<String, dynamic>;
      parsedCity = locationMap['city']?.toString() ?? '';
    }

    // Handle country/nat
    String parsedCountry = '';
    if (json['country'] is String) {
      parsedCountry = json['country'];
    } else if (json['nat'] is String) {
      parsedCountry = json['nat'];
    } else if (json['location'] is Map) {
      final locationMap = json['location'] as Map<String, dynamic>;
      parsedCountry = locationMap['country']?.toString() ?? '';
    }

    // Handle image URL
    String parsedImageUrl = '';
    if (json['imageUrl'] is String) {
      parsedImageUrl = json['imageUrl'];
    } else if (json['image'] is String) {
      parsedImageUrl = json['image'];
    } else if (json['picture'] is Map) {
      final pictureMap = json['picture'] as Map<String, dynamic>;
      parsedImageUrl = pictureMap['large']?.toString() ??
          pictureMap['medium']?.toString() ??
          pictureMap['thumbnail']?.toString() ?? '';
    }

    return UserModel(
      name: parsedName.isNotEmpty ? parsedName : 'Unknown',
      age: parsedAge,
      city: parsedCity.isNotEmpty ? parsedCity : 'Unknown',
      country: parsedCountry.isNotEmpty ? parsedCountry : 'Unknown',
      imageUrl: parsedImageUrl,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'city': city,
      'country': country,
      'imageUrl': imageUrl,
    };
  }
}