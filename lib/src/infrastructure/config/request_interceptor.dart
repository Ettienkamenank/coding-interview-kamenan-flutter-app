import 'package:coding_interview_flutter_app/src/shared/shared_preference_keys.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient extends http.BaseClient {
  final SharedPreferences prefs;

  HttpClient({required this.prefs});

  // Use a memory cache to avoid local storage access in each call
  String _inMemoryToken = '';
  String get userAccessToken {
    // use in memory token if available
    if (_inMemoryToken.isNotEmpty) return _inMemoryToken;

    // otherwise load it from local storage
    _inMemoryToken = _loadTokenFromSharedPreference();

    return _inMemoryToken;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // intercept each call and add the Authorization header if token is available
    if (userAccessToken.isNotEmpty) {
      request.headers.putIfAbsent('Authorization', () => userAccessToken);
      request.headers.putIfAbsent('Accept-Language', () => 'fr');
      request.headers.putIfAbsent('Content-Type', () => 'application/json');
    } else {
      throw ArgumentError.notNull("User session token should not be null");
    }

    return request.send();
  }

  String _loadTokenFromSharedPreference() {
    var accessToken = '';
    final token = prefs.getString(prefsSessionToken);

    // If user is already authenticated, we can load his token from cache
    if (token != null) {
      accessToken = token;
    }
    return accessToken;
  }

  // Don't forget to reset the cache when logging out the user
  void reset() {
    _inMemoryToken = '';
  }
}

/// Token for insecure request
const String _insecureToken =
    'Bearer 0KaXYgPTBBQURFQzE0MEYyMDE0OUI3MzDNzA1MzNCODk2OEIyNUMwOTk4MzM5MjJCQkCN0E1DQprZXk9OEE5QNwRDJCQkM5MkY2NjBERIM2QTYzQzhGNEE1MDMyc2FsdD0zRDlFREM4NkU0NjVQzM4QTVFOEQxOTcwOUIxQzZFOE';

class UnauthenticatedHttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.putIfAbsent('Authorization', () => _insecureToken);
    request.headers.putIfAbsent('Accept-Language', () => 'fr');
    request.headers.putIfAbsent(
      'Content-Type',
          () => 'application/json;charset=UTF-8',
    );
    request.headers.putIfAbsent('Charset', () => 'utf-8');

    return request.send();
  }
}