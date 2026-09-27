import '../core/enums/enums.dart';

class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final String? email;
  final String city;
  final String? profilePhotoUrl;
  final UserRole role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? fcmToken;
  final double? latitude;
  final double? longitude;
  final List<String> savedAddresses;
  final List<String> favoriteProIds;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    required this.city,
    this.profilePhotoUrl,
    this.role = UserRole.customer,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
    this.fcmToken,
    this.latitude,
    this.longitude,
    this.savedAddresses = const [],
    this.favoriteProIds = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      city: json['city'] as String,
      profilePhotoUrl: json['profile_photo_url'] as String?,
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.customer,
      ),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      fcmToken: json['fcm_token'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      savedAddresses: (json['saved_addresses'] as List<dynamic>?)
              ?.cast<String>() ??
          [],
      favoriteProIds: (json['favorite_pro_ids'] as List<dynamic>?)
              ?.cast<String>() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone': phone,
      'email': email,
      'city': city,
      'profile_photo_url': profilePhotoUrl,
      'role': role.name,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'fcm_token': fcmToken,
      'latitude': latitude,
      'longitude': longitude,
      'saved_addresses': savedAddresses,
      'favorite_pro_ids': favoriteProIds,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phone,
    String? email,
    String? city,
    String? profilePhotoUrl,
    UserRole? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fcmToken,
    double? latitude,
    double? longitude,
    List<String>? savedAddresses,
    List<String>? favoriteProIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      city: city ?? this.city,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fcmToken: fcmToken ?? this.fcmToken,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      favoriteProIds: favoriteProIds ?? this.favoriteProIds,
    );
  }
}
