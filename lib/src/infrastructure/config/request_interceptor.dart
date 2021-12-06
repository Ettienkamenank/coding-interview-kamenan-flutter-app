/// Token for insecure request
const String _insecureToken =
    'Bearer 0KaXYgPTBBQURFQzE0MEYyMDE0OUI3MzDNzA1MzNCODk2OEIyNUMwOTk4MzM5MjJCQkCN0E1DQprZXk9OEE5QNwRDJCQkM5MkY2NjBERIM2QTYzQzhGNEE1MDMyc2FsdD0zRDlFREM4NkU0NjVQzM4QTVFOEQxOTcwOUIxQzZFOE';

Map<String, String> appHttpHeaders({required String? sessionToken}) {
  return {
    'Accept-Language': 'fr',
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': sessionToken ?? _insecureToken
  };
}
