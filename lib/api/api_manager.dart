import 'package:market_place_customer/utils/exports.dart';

class ApiManager {
  final Dio _dio = Dio();

  /// POST method: Supports optional token and file upload
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> data,
    bool useToken = true,
    BuildContext? context,
  }) async {
    try {
      final token = useToken ? LocalStorage.getString(Pref.token) : null;

      print('$url \n$token');

      final headers = {
        if (useToken && token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      dynamic requestData;
      bool hasFile =
          data.values.any((value) => value is File || value is List<File>);

      if (hasFile) {
        final formMap = <String, dynamic>{};
        for (var entry in data.entries) {
          final value = entry.value;

          if (value is File) {
            formMap[entry.key] = await MultipartFile.fromFile(
              value.path,
              filename: value.path.split('/').last,
            );
          } else if (value is List<File>) {
            formMap[entry.key] = await Future.wait(value.map((file) async {
              return await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              );
            }).toList());
          } else {
            formMap[entry.key] = value;
          }
        }
        requestData = FormData.fromMap(formMap);
        headers['Content-Type'] = 'multipart/form-data';
      } else {
        print('object');
        requestData = jsonEncode(data);
      }

      final response = await _dio.post(
        url,
        data: requestData,
        options: Options(
          headers: headers,
          sendTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          validateStatus: (status) {
            // Allow 200, 201 and 401 as valid responses
            return status != null &&
                (status >= 200 && status < 300 ||
                    status == 401 ||
                    status == 403 ||
                    status == 404 ||
                    status == 500);
          },
        ),
      );

      print(response.statusCode);

      return _handleStatusCode(response, context: context);
    } on DioException catch (e) {
      print("DioException: $e");
      return _handleDioError(e);
    } on SocketException {
      return "Internet connection error!. Please try again";
    } catch (e) {
      return "Something went wrong. Please try again.";
    }
  }

  /// GET method: With optional query params and token
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParams,
    bool useToken = true,
    BuildContext? context,
  }) async {
    final token = useToken ? LocalStorage.getString(Pref.token) : null;
    print('$url \n\n$token');

    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {
            if (useToken && token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          sendTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1),
          validateStatus: (status) {
            return status != null &&
                (status >= 200 && status < 300 ||
                    status == 401 ||
                    status == 403 ||
                    status == 500);
          },
        ),
      );
      print(response.statusCode);
      return _handleStatusCode(response, context: context);
    } on DioException catch (e) {
      return _handleDioError(e);
    } on SocketException {
      return "Internet connection error!. Please try again";
    } catch (e) {
      return "Something went wrong. Please try again.";
    }
  }

  /// Handle response status codes
  dynamic _handleStatusCode(Response response, {BuildContext? context}) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        return "Bad Request: ${response.data['message'] ?? 'Invalid input.'}";
      case 401:
        // if (context != null) {
        //   LocalStorage.clearAll(context);
        // }
        return "unauthorized";
      case 403:
        return "access_denied";
      case 404:
        return "not_found";
      case 500:
        return "Internal Server Error: Please try again later.";
      default:
        return "Unhandled status code: ${response.statusCode}";
    }
  }

  /// Handle Dio Errors
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return "Connection timeout. Please check your network.";
      case DioExceptionType.badResponse:
        final message = e.response?.data['message'] ?? "Server error occurred.";
        return "$message";
      case DioExceptionType.cancel:
        return "Request cancelled.";
      case DioExceptionType.unknown:
        // mostly internet OFF
        if (e.error is SocketException) {
          return "no_internet";
        }
        return "No Internet Connection. \nPlease check your internet connection.";

      default:
        return "no_internet";
    }
  }
}
