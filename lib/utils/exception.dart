class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
class ClientException implements Exception {
  final String message;
  ClientException(this.message);
}
class ExistException implements Exception {
  final String message;
  ExistException(this.message);
}