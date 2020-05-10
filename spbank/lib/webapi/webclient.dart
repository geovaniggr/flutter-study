import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 2)
);
final String baseUrl = "ENV.URL8080/transactions";
