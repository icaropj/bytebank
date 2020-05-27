import 'package:bytebank/http/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
const String BASE_URL = 'http://192.168.5.234:8080/transactions';
