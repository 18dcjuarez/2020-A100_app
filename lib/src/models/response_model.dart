class ResponseModel {
  final dynamic data;
  final bool? success;
  final String? message;
  final int? statusCode;
  final Map<String, dynamic>? detail;

  ResponseModel({
    this.data = const {},
    this.message,
    this.success,
    this.statusCode,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return {
      'data': this.data,
      'message': this.message,
      'success': this.success,
      'statusCode': this.statusCode,
      'detail': this.detail,
    };
  }

  @override
  String toString() {
    return "DATA: $data, MESSAGE: $message, SUCCESS: $success, STATUSCODE: $statusCode, DETAIL: $detail";
  }
}
