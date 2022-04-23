import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: const Duration(seconds: 5),
);

Uri buildUri(String urlPath) {
  final Uri _uri =
      Uri(scheme: 'http', host: '192.168.0.4', port: 8080, path: urlPath);
  return _uri;
}
