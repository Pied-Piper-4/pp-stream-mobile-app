class ApiResponse<T, E> {
  bool hasError;
  E? error;
  T? data;
  ApiResponse({this.hasError = false, this.error, this.data});
  ApiResponse.withError(this.data) : hasError = true;
  ApiResponse.success(this.data) : hasError = false;
}
