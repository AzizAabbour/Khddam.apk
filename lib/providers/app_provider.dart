import 'package:flutter/material.dart';
import '../models/models.dart';
import '../core/enums/enums.dart';
import '../services/mock_data_service.dart';

/// App state management for services, requests, professionals
class AppProvider extends ChangeNotifier {
  final MockDataService _mockData = MockDataService();

  // State
  List<ProfessionalModel> _professionals = [];
  List<ProfessionalModel> _filteredProfessionals = [];
  List<ServiceRequest> _requests = [];
  List<ReviewModel> _reviews = [];
  List<ChatConversation> _conversations = [];
  List<NotificationModel> _notifications = [];
  ProfessionalModel? _selectedProfessional;
  ServiceRequest? _selectedRequest;

  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  ServiceCategory? _selectedCategory;
  String _selectedCity = 'Casablanca';
  int _currentNavIndex = 0;

  // Getters
  List<ProfessionalModel> get professionals =>
      _filteredProfessionals.isEmpty && _searchQuery.isEmpty
          ? _professionals
          : _filteredProfessionals;
  List<ServiceRequest> get requests => _requests;
  List<ServiceRequest> get activeRequests =>
      _requests.where((r) => r.isActive).toList();
  List<ServiceRequest> get completedRequests =>
      _requests.where((r) => r.isCompleted).toList();
  List<ReviewModel> get reviews => _reviews;
  List<ChatConversation> get conversations => _conversations;
  List<NotificationModel> get notifications => _notifications;
  int get unreadNotifications =>
      _notifications.where((n) => !n.isRead).length;
  int get unreadMessages =>
      _conversations.fold(0, (sum, c) => sum + c.unreadCount);
  ProfessionalModel? get selectedProfessional => _selectedProfessional;
  ServiceRequest? get selectedRequest => _selectedRequest;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  ServiceCategory? get selectedCategory => _selectedCategory;
  String get selectedCity => _selectedCity;
  int get currentNavIndex => _currentNavIndex;

  // Initialization
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    _professionals = _mockData.professionals;
    _requests = _mockData.serviceRequests;
    _reviews = _mockData.reviews;
    _conversations = _mockData.conversations;
    _notifications = _mockData.notifications;

    _isLoading = false;
    notifyListeners();
  }

  // Navigation
  void setNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }

  // Search
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setSelectedCategory(ServiceCategory? category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void setSelectedCity(String city) {
    _selectedCity = city;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredProfessionals = _professionals.where((pro) {
      bool matches = true;

      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        matches = matches &&
            (pro.fullName.toLowerCase().contains(query) ||
                pro.primaryService.toLowerCase().contains(query) ||
                pro.city.toLowerCase().contains(query) ||
                pro.bio?.toLowerCase().contains(query) == true);
      }

      if (_selectedCategory != null) {
        matches = matches && pro.services.contains(_selectedCategory);
      }

      return matches;
    }).toList();
  }

  // Professional selection
  void selectProfessional(ProfessionalModel professional) {
    _selectedProfessional = professional;
    notifyListeners();
  }

  void clearSelectedProfessional() {
    _selectedProfessional = null;
    notifyListeners();
  }

  // Request management
  void selectRequest(ServiceRequest request) {
    _selectedRequest = request;
    notifyListeners();
  }

  Future<bool> createRequest({
    required ServiceCategory category,
    required String description,
    required String address,
    required String city,
    required double latitude,
    required double longitude,
    required DateTime preferredDate,
    required String preferredTime,
    double? budget,
    List<String>? photos,
    PaymentMethod paymentMethod = PaymentMethod.cash,
    String? professionalId,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final request = ServiceRequest(
      id: 'req_${DateTime.now().millisecondsSinceEpoch}',
      customerId: 'user_001',
      professionalId: professionalId,
      customerName: 'Aziz Bennani',
      category: category,
      description: description,
      photos: photos ?? [],
      latitude: latitude,
      longitude: longitude,
      address: address,
      city: city,
      preferredDate: preferredDate,
      preferredTime: preferredTime,
      budget: budget,
      paymentMethod: paymentMethod,
      createdAt: DateTime.now(),
    );

    _requests.insert(0, request);
    _isLoading = false;
    notifyListeners();
    return true;
  }

  // Favorites
  List<ProfessionalModel> getFavorites(List<String> favoriteIds) {
    return _professionals
        .where((pro) => favoriteIds.contains(pro.id))
        .toList();
  }

  // Reviews for a professional
  List<ReviewModel> getReviewsForProfessional(String professionalId) {
    return _reviews
        .where((r) => r.professionalId == professionalId)
        .toList();
  }

  // Chat messages
  List<ChatMessage> getMessages(String conversationId) {
    return _mockData.getMessages(conversationId);
  }

  // Professional mode
  Map<String, dynamic> get professionalStats => _mockData.professionalStats;
  List<Map<String, dynamic>> get transactions => _mockData.transactions;

  // Accept/Reject request (professional mode)
  void updateRequestStatus(String requestId, RequestStatus status) {
    final index = _requests.indexWhere((r) => r.id == requestId);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(
        status: status,
        updatedAt: DateTime.now(),
        acceptedAt: status == RequestStatus.accepted ? DateTime.now() : null,
        completedAt: status == RequestStatus.completed ? DateTime.now() : null,
      );
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
