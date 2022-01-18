enum HTTPMethod { GET, POST, PATCH, DELETE, PUT }

class RequestModel {
  final String path;
  final dynamic body;
  final HTTPMethod method;
  final Map<String, String>? headers;
  final Map<String, dynamic>? queryParams;

  RequestModel({
    required this.path,
    required this.method,
    this.body,
    this.headers = const {},
    this.queryParams = const {},
  });

  @override
  String toString() {
    return 'PATH: $path -- BODY: $body -- METHOD: $method -- HEADERS: $headers -- PARAMS: $queryParams';
  }
}
