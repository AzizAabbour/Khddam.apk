/// Enums used throughout the Khddam.ma application

enum UserRole { customer, professional, admin }

enum RequestStatus {
  pending,
  reviewing,
  accepted,
  rejected,
  onTheWay,
  inProgress,
  completed,
  cancelled,
}

enum PaymentMethod { cash, online, afterService }

enum PaymentStatus { pending, paid, refunded }

enum NotificationType {
  newRequest,
  requestAccepted,
  requestRejected,
  professionalArriving,
  newMessage,
  serviceCompleted,
  newReview,
  system,
}

enum ServiceCategory {
  plumber,
  electrician,
  cleaning,
  painting,
  mechanic,
  carpenter,
  applianceRepair,
  moving,
  gardening,
  locksmith,
  airConditioning,
  roofing,
  tiling,
  welding,
  other,
}

enum AvailabilityStatus { available, busy, offline, vacation }

enum AppLanguage { fr, ar, darija }

enum VerificationStatus { unverified, pending, verified, rejected }

/// Extensions for display values
extension ServiceCategoryExtension on ServiceCategory {
  String get displayNameFr {
    switch (this) {
      case ServiceCategory.plumber:
        return 'Plombier';
      case ServiceCategory.electrician:
        return 'Électricien';
      case ServiceCategory.cleaning:
        return 'Nettoyage';
      case ServiceCategory.painting:
        return 'Peinture';
      case ServiceCategory.mechanic:
        return 'Mécanicien';
      case ServiceCategory.carpenter:
        return 'Menuisier';
      case ServiceCategory.applianceRepair:
        return 'Électroménager';
      case ServiceCategory.moving:
        return 'Déménagement';
      case ServiceCategory.gardening:
        return 'Jardinage';
      case ServiceCategory.locksmith:
        return 'Serrurier';
      case ServiceCategory.airConditioning:
        return 'Climatisation';
      case ServiceCategory.roofing:
        return 'Toiture';
      case ServiceCategory.tiling:
        return 'Carrelage';
      case ServiceCategory.welding:
        return 'Soudure';
      case ServiceCategory.other:
        return 'Autre';
    }
  }

  String get displayNameAr {
    switch (this) {
      case ServiceCategory.plumber:
        return 'سباك';
      case ServiceCategory.electrician:
        return 'كهربائي';
      case ServiceCategory.cleaning:
        return 'تنظيف';
      case ServiceCategory.painting:
        return 'دهان';
      case ServiceCategory.mechanic:
        return 'ميكانيكي';
      case ServiceCategory.carpenter:
        return 'نجار';
      case ServiceCategory.applianceRepair:
        return 'تصليح أجهزة';
      case ServiceCategory.moving:
        return 'نقل';
      case ServiceCategory.gardening:
        return 'بستنة';
      case ServiceCategory.locksmith:
        return 'حداد';
      case ServiceCategory.airConditioning:
        return 'تكييف';
      case ServiceCategory.roofing:
        return 'سقف';
      case ServiceCategory.tiling:
        return 'بلاط';
      case ServiceCategory.welding:
        return 'لحام';
      case ServiceCategory.other:
        return 'أخرى';
    }
  }

  String get icon {
    switch (this) {
      case ServiceCategory.plumber:
        return 'plumbing';
      case ServiceCategory.electrician:
        return 'electrical_services';
      case ServiceCategory.cleaning:
        return 'cleaning_services';
      case ServiceCategory.painting:
        return 'format_paint';
      case ServiceCategory.mechanic:
        return 'build';
      case ServiceCategory.carpenter:
        return 'carpenter';
      case ServiceCategory.applianceRepair:
        return 'kitchen';
      case ServiceCategory.moving:
        return 'local_shipping';
      case ServiceCategory.gardening:
        return 'yard';
      case ServiceCategory.locksmith:
        return 'lock';
      case ServiceCategory.airConditioning:
        return 'ac_unit';
      case ServiceCategory.roofing:
        return 'roofing';
      case ServiceCategory.tiling:
        return 'grid_view';
      case ServiceCategory.welding:
        return 'hardware';
      case ServiceCategory.other:
        return 'more_horiz';
    }
  }
}

extension RequestStatusExtension on RequestStatus {
  String get displayNameFr {
    switch (this) {
      case RequestStatus.pending:
        return 'En attente';
      case RequestStatus.reviewing:
        return 'En cours d\'examen';
      case RequestStatus.accepted:
        return 'Acceptée';
      case RequestStatus.rejected:
        return 'Refusée';
      case RequestStatus.onTheWay:
        return 'En route';
      case RequestStatus.inProgress:
        return 'En cours';
      case RequestStatus.completed:
        return 'Terminée';
      case RequestStatus.cancelled:
        return 'Annulée';
    }
  }

  bool get isActive {
    return this == RequestStatus.pending ||
        this == RequestStatus.reviewing ||
        this == RequestStatus.accepted ||
        this == RequestStatus.onTheWay ||
        this == RequestStatus.inProgress;
  }
}
