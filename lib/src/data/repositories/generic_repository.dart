// import 'dart:io';
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:gestion/src/data/enum/shared_preferences_key.dart';
// import 'package:gestion/src/data/repositories/shared_preferences_repository.dart';
// import 'package:gestion/src/models/request_model.dart';
// import 'package:gestion/src/models/response_model.dart';

// class GenericRepository extends SimpleProvider {
//   GenericRepository._internal();

//   static GenericRepository get instance => _instance;

//   static final GenericRepository _instance = GenericRepository._internal();

//   // @override
//   // Future<ResponseModel?> sendRequest(RequestModel req) {
//   //   return super.sendRequest(req);
//   // }
// }

// class SimpleProvider {
//   final _client = Dio(BaseOptions(
//     baseUrl: dotenv.env['API_URL']!,
//     connectTimeout: 1000,
//     receiveTimeout: 10000,
//     contentType: 'application/json',
//   ));

//   Function getMethodCall(HTTPMethod method) {
//     switch (method) {
//       case HTTPMethod.POST:
//         return _client.post;
//       case HTTPMethod.GET:
//         return _client.get;
//       case HTTPMethod.DELETE:
//         return _client.delete;
//       case HTTPMethod.PATCH:
//         return _client.patch;
//       case HTTPMethod.PUT:
//         return _client.put;
//       default:
//         return _client.get;
//     }
//   }

//   Future<ResponseModel?> get(String path,
//       {Map<String, String>? headers, Map<String, dynamic>? queryParams}) async {
//     print('GET METHOD');
//     print('HEADERSGETT-- $headers');
//     headers = {};
//     final String? token = await SharedPreferencesRepository.instance
//         .getData(SharedPreferencesKey.TOKEN);
//     print('TOKEN SENDREQUEST $token');
//     if (token != null) {
//       print('ISIDE CONDITION');
//       headers.addAll({'Authorization': 'JWT $token'});
//     }
//     print('HEADERSGETT222-- $headers');

//     return sendRequest(
//       RequestModel(
//         path: path,
//         headers: headers,
//         method: HTTPMethod.GET,
//         queryParams: queryParams,
//       ),
//     );
//   }

//   Future<ResponseModel?> post(String path,
//       {dynamic body,
//       Map<String, String>? headers,
//       Map<String, dynamic>? queryParams}) {
//     return sendRequest(
//       RequestModel(
//         body: body,
//         path: path,
//         headers: headers,
//         method: HTTPMethod.POST,
//         queryParams: queryParams,
//       ),
//     );
//   }

//   Future<ResponseModel?> delete(String path,
//       {Map<String, String>? headers, Map<String, dynamic>? queryParams}) {
//     return sendRequest(
//       RequestModel(
//         path: path,
//         headers: headers,
//         queryParams: queryParams,
//         method: HTTPMethod.DELETE,
//       ),
//     );
//   }

//   Future<ResponseModel?> patch(String path,
//       {dynamic body,
//       Map<String, String>? headers,
//       Map<String, dynamic>? queryParams}) {
//     return sendRequest(
//       RequestModel(
//         body: body,
//         path: path,
//         headers: headers,
//         method: HTTPMethod.PATCH,
//         queryParams: queryParams,
//       ),
//     );
//   }

//   Future<ResponseModel?> put(String path,
//       {dynamic body,
//       Map<String, String>? headers,
//       Map<String, dynamic>? queryParams}) {
//     return sendRequest(
//       RequestModel(
//         body: body,
//         path: path,
//         headers: headers,
//         method: HTTPMethod.PUT,
//         queryParams: queryParams,
//       ),
//     );
//   }

//   Future<ResponseModel?> sendRequest(RequestModel req) async {
//     try {
//       await InternetAddress.lookup('google.com');
//       Map<String, String> headers = {};
//       // final String? token = await SharedPreferencesRepository.instance
//       //     .getData(SharedPreferencesKey.TOKEN);
//       // print('TOKEN SENDREQUEST $token');
//       // if (token != null) {
//       //   headers.addAll({HttpHeaders.authorizationHeader: 'JWT $token'});
//       // }
//       // if (req.headers != null) headers.addAll(req.headers!);
//       Function methodClient = getMethodCall(req.method);
//       Response? res;
//       print('PATH22 ${req.path}');
//       print('HEADERS $headers');
//       print('REQ BODY ${req.body}}');
//       print('REQ $req');
//       print('CLIENT $methodClient');
//       print('req Method ${req.method}');
//       if (req.body != null) {
//         res = await methodClient(
//           req.path,
//           data: req.body,
//           queryParameters: req.queryParams,
//           options: Options(headers: headers),
//         );
//       } else {
//         res = await methodClient(
//           req.path,
//           queryParameters: req.queryParams,
//           options: Options(headers: headers),
//         );
//       }

//       print('SUCCES $res');
//       return ResponseModel(
//           message: res!.statusMessage,
//           statusCode: res.statusCode,
//           success: (res.statusCode! >= 200 && res.statusCode! <= 299),
//           data: res.data is String &&
//                   res.data.toString().contains('{') &&
//                   res.data.toString().contains('}')
//               ? json.decode(res.data)
//               : res.data,
//           detail: null);
//     } on DioError catch (e) {
//       print('ERROR $e');
//       return ResponseModel(
//         data: null,
//         success: false,
//         detail: null,
//         statusCode: e.response!.statusCode,
//         message: e.response!.data != null && e.response!.data is Map
//             ? e.response!.data['errors']?.join(', ')
//             : (e.response!.data is String ? e.response!.data : e.message),
//       );
//     } on SocketException catch (_) {
//       print('SOCKET ERROR $_');
//       return ResponseModel(
//           data: null,
//           message: 'Revisa tu conexión de internet',
//           success: false,
//           statusCode: 404,
//           detail: null);
//     } catch (e) {
//       return null;
//     }
//   }
// }
