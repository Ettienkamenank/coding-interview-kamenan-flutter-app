class ApiEndpoint {
  static const String _baseUrl = 'http://192.168.43.199:8091/api';
  // static const String baseUrl = 'http://192.168.1.13:8091/api';
  // static const String baseUrl = 'http://192.168.1.17:8091/api';
  // static const String baseUrl = 'http://192.168.1.102:8091/api';

  static const String _unauthenticatedURL = "$_baseUrl/v1";
  static const String _authenticatedURL = "$_baseUrl/secured/v1";

  static const String authenticationEndpoint = '$_unauthenticatedURL/user';

  static const String userEndpoint = '$_authenticatedURL/user';

  static const String activityAreaEndpoint = '$_authenticatedURL/activity-area';

  static const String announcementEndpoint = '$_authenticatedURL/announcement';
}