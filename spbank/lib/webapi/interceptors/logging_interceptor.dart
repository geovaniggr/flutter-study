import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request:');
    print('\n-------------\n');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    print('\n-------------\n');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('\n-------------\n');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('statusCode: ${data.statusCode}');
    print('body: ${data.body}');
    print('\n-------------\n');
    return data;
  }
}

