class ApiEndpoint {
  static const String baseUrl = 'http://192.168.43.199:8091/api';
  // static const String baseUrl = 'http://192.168.1.13:8091/api';
  // static const String baseUrl = 'http://192.168.1.17:8091/api';
  // static const String baseUrl = 'http://192.168.1.102:8091/api';

  static const String unauthenticatedURL = "$baseUrl/v1";
  static const String authenticatedURL = "$baseUrl/secured/v1";

  static const String authenticationEndpoint = '$unauthenticatedURL/user';

  static const String userEndpoint = '$authenticatedURL/user';

  static const String activityAreaEndpoint = '$authenticatedURL/activity-area';

  static const String announcementEndpoint = '$authenticatedURL/announcement';
}