enum PlatformToolsExceptionType {
  unknown,
  platformToolsNotFound,
  noDeviceSelected,
}

class PlatformToolsException implements Exception {
  PlatformToolsExceptionType type;
  String message;

  PlatformToolsException(this.type, this.message);

  @override
  String toString() {
    return 'PlatformToolsException: ${type.name} - $message';
  }
}
