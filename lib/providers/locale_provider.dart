import 'package:flutter/material.dart';
import '../core/enums/enums.dart';

/// Localization provider managing French, Arabic, Darija
class LocaleProvider extends ChangeNotifier {
  AppLanguage _language = AppLanguage.fr;
  
  AppLanguage get language => _language;
  Locale get locale {
    switch (_language) {
      case AppLanguage.fr:
        return const Locale('fr', 'MA');
      case AppLanguage.ar:
        return const Locale('ar', 'MA');
      case AppLanguage.darija:
        return const Locale('ar', 'MA'); // Darija uses Arabic locale
    }
  }

  bool get isRTL => _language == AppLanguage.ar || _language == AppLanguage.darija;

  void setLanguage(AppLanguage language) {
    _language = language;
    notifyListeners();
  }

  /// Get translated string
  String t(String key) {
    final map = _translations[_language];
    return map?[key] ?? _translations[AppLanguage.fr]?[key] ?? key;
  }

  static final Map<AppLanguage, Map<String, String>> _translations = {
    AppLanguage.fr: {
      // General
      'app_name': 'Khddam.ma',
      'app_tagline': 'Trouvez des professionnels de confiance près de chez vous.',
      
      // Auth
      'login': 'Se connecter',
      'register': 'Créer un compte',
      'logout': 'Déconnexion',
      'full_name': 'Nom complet',
      'phone': 'Numéro de téléphone',
      'email': 'Email (optionnel)',
      'password': 'Mot de passe',
      'confirm_password': 'Confirmer le mot de passe',
      'city': 'Ville',
      'forgot_password': 'Mot de passe oublié?',
      'reset_password': 'Réinitialiser le mot de passe',
      'otp_title': 'Vérification',
      'otp_subtitle': 'Entrez le code envoyé à votre numéro',
      'verify': 'Vérifier',
      'resend_code': 'Renvoyer le code',
      'no_account': 'Pas encore de compte?',
      'have_account': 'Déjà un compte?',
      
      // Onboarding
      'onboarding_1_title': 'Trouvez des professionnels',
      'onboarding_1_desc': 'Trouvez des professionnels de confiance pour vos besoins quotidiens.',
      'onboarding_2_title': 'Demandez un service',
      'onboarding_2_desc': 'Décrivez votre problème et recevez des offres de professionnels.',
      'onboarding_3_title': 'Travail accompli',
      'onboarding_3_desc': 'Suivez votre demande et évaluez votre professionnel.',
      'skip': 'Passer',
      'next': 'Suivant',
      'get_started': 'Commencer',
      
      // Home
      'hello': 'Bonjour',
      'search_hint': 'De quel service avez-vous besoin?',
      'categories': 'Catégories',
      'featured_professionals': 'Professionnels recommandés',
      'nearby_professionals': 'Professionnels à proximité',
      'see_all': 'Voir tout',
      'available_today': 'Disponible aujourd\'hui',
      'from': 'À partir de',
      'reviews': 'avis',
      'km_away': 'km',
      'view_profile': 'Voir le profil',
      
      // Categories
      'plumber': 'Plombier',
      'electrician': 'Électricien',
      'cleaning': 'Nettoyage',
      'painting': 'Peinture',
      'mechanic': 'Mécanicien',
      'carpenter': 'Menuisier',
      'appliance_repair': 'Électroménager',
      'moving': 'Déménagement',
      'gardening': 'Jardinage',
      'locksmith': 'Serrurier',
      'air_conditioning': 'Climatisation',
      'other': 'Autre',
      
      // Service Request
      'request_service': 'Demander un service',
      'select_service': 'Sélectionner un service',
      'describe_problem': 'Décrivez votre problème...',
      'add_photos': 'Ajouter des photos',
      'location': 'Localisation',
      'use_current_location': 'Utiliser ma position actuelle',
      'preferred_date': 'Date préférée',
      'preferred_time': 'Heure préférée',
      'budget': 'Budget (optionnel)',
      'payment_method': 'Mode de paiement',
      'cash': 'Espèces',
      'online_payment': 'Paiement en ligne',
      'after_service': 'Après le service',
      'send_request': 'Envoyer la demande',
      
      // Request Status
      'request_created': 'Demande créée',
      'professional_reviewing': 'En cours d\'examen',
      'professional_accepted': 'Professionnel accepté',
      'professional_on_way': 'Professionnel en route',
      'service_in_progress': 'Service en cours',
      'completed': 'Terminé',
      'request_pending': 'En attente',
      'request_rejected': 'Refusée',
      'request_cancelled': 'Annulée',
      
      // Professional Profile
      'about': 'À propos',
      'services': 'Services',
      'service_area': 'Zone de service',
      'working_hours': 'Horaires',
      'portfolio': 'Portfolio',
      'verified': 'Vérifié',
      'years_experience': 'ans d\'expérience',
      'completed_jobs': 'travaux réalisés',
      'starting_price': 'Prix de départ',
      'chat': 'Chat',
      'call': 'Appeler',
      'contact_professional': 'Contacter le professionnel',
      
      // Navigation
      'home': 'Accueil',
      'search': 'Recherche',
      'requests': 'Demandes',
      'messages': 'Messages',
      'profile': 'Profil',
      
      // Chat
      'type_message': 'Tapez un message...',
      'online': 'En ligne',
      'offline': 'Hors ligne',
      
      // Reviews
      'rate_experience': 'Comment était votre expérience?',
      'write_review': 'Écrire un avis...',
      'submit_review': 'Soumettre l\'avis',
      
      // Profile
      'my_profile': 'Mon profil',
      'settings': 'Paramètres',
      'my_favorites': 'Mes favoris',
      'my_requests': 'Mes demandes',
      'my_reviews': 'Mes avis',
      'saved_addresses': 'Adresses enregistrées',
      'language': 'Langue',
      'notifications': 'Notifications',
      'dark_mode': 'Mode sombre',
      'privacy': 'Confidentialité',
      'security': 'Sécurité',
      'help': 'Aide',
      'terms': 'Conditions d\'utilisation',
      'about_app': 'À propos de Khddam.ma',
      
      // Filters
      'filters': 'Filtres',
      'distance': 'Distance',
      'rating': 'Note',
      'price': 'Prix',
      'availability': 'Disponibilité',
      'verified_only': 'Professionnels vérifiés',
      'sort_by': 'Trier par',
      'nearest': 'Plus proche',
      'highest_rated': 'Mieux noté',
      'lowest_price': 'Prix le plus bas',
      'available_now': 'Disponible maintenant',
      'apply_filters': 'Appliquer les filtres',
      'clear_filters': 'Effacer les filtres',
      
      // Empty States
      'no_requests': 'Aucune demande',
      'no_requests_desc': 'Vos demandes de service apparaîtront ici.',
      'no_messages': 'Aucun message',
      'no_messages_desc': 'Vos conversations apparaîtront ici.',
      'no_favorites': 'Aucun favori',
      'no_favorites_desc': 'Vos professionnels favoris apparaîtront ici.',
      'no_notifications': 'Aucune notification',
      'no_notifications_desc': 'Vos notifications apparaîtront ici.',
      'no_results': 'Aucun résultat',
      'no_results_desc': 'Essayez de modifier vos critères de recherche.',
      'find_professional': 'Trouver un professionnel',
      
      // Error
      'error_title': 'Erreur',
      'no_internet': 'Pas de connexion internet',
      'no_internet_desc': 'Vérifiez votre connexion et réessayez.',
      'request_failed': 'La demande a échoué',
      'request_failed_desc': 'Nous n\'avons pas pu envoyer votre demande. Réessayez.',
      'retry': 'Réessayer',
      'something_went_wrong': 'Quelque chose s\'est mal passé',
      
      // Professional Mode
      'pro_dashboard': 'Tableau de bord',
      'today_requests': 'Demandes aujourd\'hui',
      'pending_requests': 'Demandes en attente',
      'this_month': 'Ce mois',
      'earnings': 'Revenus',
      'accept': 'Accepter',
      'reject': 'Refuser',
      'manage_availability': 'Gérer la disponibilité',
      'available_toggle': 'Disponible pour de nouvelles demandes',
      'vacation_mode': 'Mode vacances',
      
      // Currency
      'currency': 'DH',
    },
    
    AppLanguage.ar: {
      'app_name': 'خدّام.ما',
      'app_tagline': 'ابحث عن مهنيين موثوقين بالقرب منك',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'logout': 'تسجيل الخروج',
      'full_name': 'الاسم الكامل',
      'phone': 'رقم الهاتف',
      'email': 'البريد الإلكتروني (اختياري)',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'city': 'المدينة',
      'forgot_password': 'نسيت كلمة المرور؟',
      'otp_title': 'التحقق',
      'otp_subtitle': 'أدخل الرمز المرسل إلى رقمك',
      'verify': 'تحقق',
      'hello': 'مرحباً',
      'search_hint': 'ما هي الخدمة التي تحتاجها؟',
      'categories': 'الفئات',
      'featured_professionals': 'مهنيون موصى بهم',
      'see_all': 'عرض الكل',
      'available_today': 'متاح اليوم',
      'from': 'ابتداءً من',
      'reviews': 'تقييمات',
      'view_profile': 'عرض الملف',
      'plumber': 'سباك',
      'electrician': 'كهربائي',
      'cleaning': 'تنظيف',
      'painting': 'دهان',
      'mechanic': 'ميكانيكي',
      'carpenter': 'نجار',
      'appliance_repair': 'تصليح أجهزة',
      'moving': 'نقل',
      'gardening': 'بستنة',
      'other': 'أخرى',
      'request_service': 'طلب خدمة',
      'send_request': 'إرسال الطلب',
      'home': 'الرئيسية',
      'search': 'بحث',
      'requests': 'الطلبات',
      'messages': 'الرسائل',
      'profile': 'الملف الشخصي',
      'settings': 'الإعدادات',
      'language': 'اللغة',
      'notifications': 'الإشعارات',
      'currency': 'درهم',
      'no_requests': 'لا توجد طلبات',
      'no_requests_desc': 'ستظهر طلبات الخدمة هنا.',
      'no_messages': 'لا توجد رسائل',
      'find_professional': 'ابحث عن مهني',
      'retry': 'إعادة المحاولة',
      'skip': 'تخطي',
      'next': 'التالي',
      'get_started': 'ابدأ',
      'chat': 'محادثة',
      'call': 'اتصال',
      'about': 'حول',
      'services': 'الخدمات',
      'verified': 'موثق',
      'accept': 'قبول',
      'reject': 'رفض',
      'earnings': 'الأرباح',
      'filters': 'التصفية',
      'apply_filters': 'تطبيق',
      'clear_filters': 'مسح',
      'completed': 'مكتمل',
    },
    
    AppLanguage.darija: {
      'app_name': 'خدّام.ما',
      'app_tagline': 'لقا شي professionnel قريب ليك',
      'login': 'دخل',
      'register': 'سجّل',
      'logout': 'خرج',
      'full_name': 'سميتك الكاملة',
      'phone': 'رقم التيليفون',
      'password': 'كلمة السر',
      'city': 'المدينة',
      'hello': 'سلام',
      'search_hint': 'شنو خصّك؟',
      'categories': 'الخدمات',
      'plumber': 'بلومبي',
      'electrician': 'تريسيان',
      'cleaning': 'تنظيف',
      'painting': 'صباغة',
      'mechanic': 'ميكانيسيان',
      'carpenter': 'نجار',
      'request_service': 'طلب خدمة',
      'send_request': 'صيفط الطلب',
      'home': 'لاكاي',
      'search': 'قلّب',
      'requests': 'الطلبات',
      'messages': 'الميساجات',
      'profile': 'البروفيل',
      'find_professional': 'لقا مهني',
      'available_today': 'موجود اليوم',
      'verified': 'موثوق',
      'accept': 'قبل',
      'reject': 'رفض',
      'currency': 'درهم',
      'skip': 'زيد',
      'next': 'كمل',
      'get_started': 'يالاه',
      'no_requests': 'ما كاين والو',
      'no_requests_desc': 'الطلبات ديالك غادي يبانو هنا.',
    },
  };
}
