class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;

  ApiResponse({this.success = true, this.data, this.error})
      : assert(
          (success && error == null && data != null) ||
              (!success && error != null && data == null),
        );
}
