import '../core/enums/enums.dart';

class ReviewModel {
  final String id;
  final String requestId;
  final String customerId;
  final String professionalId;
  final String customerName;
  final String? customerPhotoUrl;
  final double rating;
  final String? comment;
  final List<String> photos;
  final ServiceCategory category;
  final DateTime createdAt;

  const ReviewModel({
    required this.id,
    required this.requestId,
    required this.customerId,
    required this.professionalId,
    required this.customerName,
    this.customerPhotoUrl,
    required this.rating,
    this.comment,
    this.photos = const [],
    required this.category,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      requestId: json['request_id'] as String,
      customerId: json['customer_id'] as String,
      professionalId: json['professional_id'] as String,
      customerName: json['customer_name'] as String,
      customerPhotoUrl: json['customer_photo_url'] as String?,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      photos: (json['photos'] as List<dynamic>?)?.cast<String>() ?? [],
      category: ServiceCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => ServiceCategory.other,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_id': requestId,
      'customer_id': customerId,
      'professional_id': professionalId,
      'customer_name': customerName,
      'customer_photo_url': customerPhotoUrl,
      'rating': rating,
      'comment': comment,
      'photos': photos,
      'category': category.name,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String requestId;
  final String content;
  final String? imageUrl;
  final bool isRead;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.requestId,
    required this.content,
    this.imageUrl,
    this.isRead = false,
    required this.createdAt,
  });

  bool get isImage => imageUrl != null && imageUrl!.isNotEmpty;

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      requestId: json['request_id'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'request_id': requestId,
      'content': content,
      'image_url': imageUrl,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ChatConversation {
  final String id;
  final String requestId;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserPhotoUrl;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isOnline;

  const ChatConversation({
    required this.id,
    required this.requestId,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserPhotoUrl,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'] as String,
      requestId: json['request_id'] as String,
      otherUserId: json['other_user_id'] as String,
      otherUserName: json['other_user_name'] as String,
      otherUserPhotoUrl: json['other_user_photo_url'] as String?,
      lastMessage: json['last_message'] as String?,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
      unreadCount: json['unread_count'] as int? ?? 0,
      isOnline: json['is_online'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request_id': requestId,
      'other_user_id': otherUserId,
      'other_user_name': otherUserName,
      'other_user_photo_url': otherUserPhotoUrl,
      'last_message': lastMessage,
      'last_message_at': lastMessageAt?.toIso8601String(),
      'unread_count': unreadCount,
      'is_online': isOnline,
    };
  }
}

class NotificationModel {
  final String id;
  final String userId;
  final NotificationType type;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.data,
    this.isRead = false,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.system,
      ),
      title: json['title'] as String,
      body: json['body'] as String,
      data: json['data'] as Map<String, dynamic>?,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.name,
      'title': title,
      'body': body,
      'data': data,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
