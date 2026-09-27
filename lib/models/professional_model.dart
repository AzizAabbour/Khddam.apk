import '../core/enums/enums.dart';

class ProfessionalModel {
  final String id;
  final String userId;
  final String fullName;
  final String phone;
  final String? email;
  final String city;
  final String? profilePhotoUrl;
  final String? bio;
  final List<ServiceCategory> services;
  final List<String> serviceAreas;
  final double rating;
  final int reviewCount;
  final int completedJobs;
  final int yearsExperience;
  final double? startingPrice;
  final Map<String, String>? workingHours;
  final VerificationStatus verificationStatus;
  final AvailabilityStatus availabilityStatus;
  final bool isActive;
  final double? latitude;
  final double? longitude;
  final List<String> portfolioPhotos;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ProfessionalModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phone,
    this.email,
    required this.city,
    this.profilePhotoUrl,
    this.bio,
    this.services = const [],
    this.serviceAreas = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    this.completedJobs = 0,
    this.yearsExperience = 0,
    this.startingPrice,
    this.workingHours,
    this.verificationStatus = VerificationStatus.unverified,
    this.availabilityStatus = AvailabilityStatus.available,
    this.isActive = true,
    this.latitude,
    this.longitude,
    this.portfolioPhotos = const [],
    required this.createdAt,
    this.updatedAt,
  });

  bool get isVerified => verificationStatus == VerificationStatus.verified;
  bool get isAvailable => availabilityStatus == AvailabilityStatus.available;

  String get formattedPrice {
    if (startingPrice == null) return '';
    return 'À partir de ${startingPrice!.toStringAsFixed(0)} DH';
  }

  String get primaryService {
    if (services.isEmpty) return '';
    return services.first.displayNameFr;
  }

  factory ProfessionalModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      city: json['city'] as String,
      profilePhotoUrl: json['profile_photo_url'] as String?,
      bio: json['bio'] as String?,
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => ServiceCategory.values.firstWhere(
                    (s) => s.name == e,
                    orElse: () => ServiceCategory.other,
                  ))
              .toList() ??
          [],
      serviceAreas:
          (json['service_areas'] as List<dynamic>?)?.cast<String>() ?? [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['review_count'] as int? ?? 0,
      completedJobs: json['completed_jobs'] as int? ?? 0,
      yearsExperience: json['years_experience'] as int? ?? 0,
      startingPrice: (json['starting_price'] as num?)?.toDouble(),
      workingHours: (json['working_hours'] as Map<String, dynamic>?)
          ?.map((k, v) => MapEntry(k, v.toString())),
      verificationStatus: VerificationStatus.values.firstWhere(
        (e) => e.name == json['verification_status'],
        orElse: () => VerificationStatus.unverified,
      ),
      availabilityStatus: AvailabilityStatus.values.firstWhere(
        (e) => e.name == json['availability_status'],
        orElse: () => AvailabilityStatus.available,
      ),
      isActive: json['is_active'] as bool? ?? true,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      portfolioPhotos:
          (json['portfolio_photos'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'full_name': fullName,
      'phone': phone,
      'email': email,
      'city': city,
      'profile_photo_url': profilePhotoUrl,
      'bio': bio,
      'services': services.map((e) => e.name).toList(),
      'service_areas': serviceAreas,
      'rating': rating,
      'review_count': reviewCount,
      'completed_jobs': completedJobs,
      'years_experience': yearsExperience,
      'starting_price': startingPrice,
      'working_hours': workingHours,
      'verification_status': verificationStatus.name,
      'availability_status': availabilityStatus.name,
      'is_active': isActive,
      'latitude': latitude,
      'longitude': longitude,
      'portfolio_photos': portfolioPhotos,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  ProfessionalModel copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? phone,
    String? email,
    String? city,
    String? profilePhotoUrl,
    String? bio,
    List<ServiceCategory>? services,
    List<String>? serviceAreas,
    double? rating,
    int? reviewCount,
    int? completedJobs,
    int? yearsExperience,
    double? startingPrice,
    Map<String, String>? workingHours,
    VerificationStatus? verificationStatus,
    AvailabilityStatus? availabilityStatus,
    bool? isActive,
    double? latitude,
    double? longitude,
    List<String>? portfolioPhotos,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfessionalModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      city: city ?? this.city,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      bio: bio ?? this.bio,
      services: services ?? this.services,
      serviceAreas: serviceAreas ?? this.serviceAreas,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      completedJobs: completedJobs ?? this.completedJobs,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      startingPrice: startingPrice ?? this.startingPrice,
      workingHours: workingHours ?? this.workingHours,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      isActive: isActive ?? this.isActive,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      portfolioPhotos: portfolioPhotos ?? this.portfolioPhotos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
