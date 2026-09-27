import '../core/enums/enums.dart';

class ServiceRequest {
  final String id;
  final String customerId;
  final String? professionalId;
  final String customerName;
  final String? professionalName;
  final ServiceCategory category;
  final String description;
  final List<String> photos;
  final double latitude;
  final double longitude;
  final String address;
  final String city;
  final DateTime preferredDate;
  final String preferredTime;
  final double? budget;
  final double? estimatedPrice;
  final double? finalPrice;
  final RequestStatus status;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final String? cancellationReason;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;

  const ServiceRequest({
    required this.id,
    required this.customerId,
    this.professionalId,
    required this.customerName,
    this.professionalName,
    required this.category,
    required this.description,
    this.photos = const [],
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.preferredDate,
    required this.preferredTime,
    this.budget,
    this.estimatedPrice,
    this.finalPrice,
    this.status = RequestStatus.pending,
    this.paymentMethod = PaymentMethod.cash,
    this.paymentStatus = PaymentStatus.pending,
    this.cancellationReason,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    this.acceptedAt,
    this.completedAt,
  });

  bool get isActive => status.isActive;
  bool get isCompleted => status == RequestStatus.completed;

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      professionalId: json['professional_id'] as String?,
      customerName: json['customer_name'] as String,
      professionalName: json['professional_name'] as String?,
      category: ServiceCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => ServiceCategory.other,
      ),
      description: json['description'] as String,
      photos: (json['photos'] as List<dynamic>?)?.cast<String>() ?? [],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      city: json['city'] as String,
      preferredDate: DateTime.parse(json['preferred_date'] as String),
      preferredTime: json['preferred_time'] as String,
      budget: (json['budget'] as num?)?.toDouble(),
      estimatedPrice: (json['estimated_price'] as num?)?.toDouble(),
      finalPrice: (json['final_price'] as num?)?.toDouble(),
      status: RequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RequestStatus.pending,
      ),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == json['payment_method'],
        orElse: () => PaymentMethod.cash,
      ),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.name == json['payment_status'],
        orElse: () => PaymentStatus.pending,
      ),
      cancellationReason: json['cancellation_reason'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'] as String)
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'professional_id': professionalId,
      'customer_name': customerName,
      'professional_name': professionalName,
      'category': category.name,
      'description': description,
      'photos': photos,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'city': city,
      'preferred_date': preferredDate.toIso8601String(),
      'preferred_time': preferredTime,
      'budget': budget,
      'estimated_price': estimatedPrice,
      'final_price': finalPrice,
      'status': status.name,
      'payment_method': paymentMethod.name,
      'payment_status': paymentStatus.name,
      'cancellation_reason': cancellationReason,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'accepted_at': acceptedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  ServiceRequest copyWith({
    String? id,
    String? customerId,
    String? professionalId,
    String? customerName,
    String? professionalName,
    ServiceCategory? category,
    String? description,
    List<String>? photos,
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    DateTime? preferredDate,
    String? preferredTime,
    double? budget,
    double? estimatedPrice,
    double? finalPrice,
    RequestStatus? status,
    PaymentMethod? paymentMethod,
    PaymentStatus? paymentStatus,
    String? cancellationReason,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? acceptedAt,
    DateTime? completedAt,
  }) {
    return ServiceRequest(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      professionalId: professionalId ?? this.professionalId,
      customerName: customerName ?? this.customerName,
      professionalName: professionalName ?? this.professionalName,
      category: category ?? this.category,
      description: description ?? this.description,
      photos: photos ?? this.photos,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      preferredDate: preferredDate ?? this.preferredDate,
      preferredTime: preferredTime ?? this.preferredTime,
      budget: budget ?? this.budget,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      finalPrice: finalPrice ?? this.finalPrice,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
