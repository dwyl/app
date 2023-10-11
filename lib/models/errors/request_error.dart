/// Simple class pertaining to a given request error. 
/// Has the error HTTP [code] and a [description] of the error occured.
class RequestError {
  final int code;
  final String description;

  RequestError({required this.code, required this.description});
}
