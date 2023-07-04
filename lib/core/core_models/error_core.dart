class ErrorCore {
  final String _errorTitle;
  final String _errorDescription;

  ErrorCore({required String errorTitle, required String errorDescription})
      : _errorTitle = errorTitle,
        _errorDescription = errorDescription;

  String get errorDescription => _errorDescription;

  String get errorTitle => _errorTitle;
}
