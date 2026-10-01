import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kuis_mobile_124240172/main.dart';

// 1x1 transparent PNG byte array
final List<int> _transparentImage = <int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
];

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _createMockImageHttpClient();
  }
}

HttpClient _createMockImageHttpClient() {
  final client = _MockHttpClient();
  return client;
}

class _MockHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;
  @override
  Duration? connectionTimeout;
  @override
  Duration idleTimeout = const Duration(seconds: 15);
  @override
  int? maxConnectionsPerHost;
  @override
  String? userAgent;

  @override
  void addCredentials(
    Uri url,
    String realm,
    HttpClientCredentials credentials,
  ) {}
  @override
  void addProxyCredentials(
    String host,
    int port,
    String realm,
    HttpClientCredentials credentials,
  ) {}
  @override
  set authenticate(
    Future<bool> Function(Uri url, String scheme, String? realm)? f,
  ) {}
  @override
  set authenticateProxy(
    Future<bool> Function(String host, int port, String scheme, String? realm)?
    f,
  ) {}
  @override
  set badCertificateCallback(
    bool Function(X509Certificate cert, String host, int port)? callback,
  ) {}
  @override
  set connectionFactory(
    Future<ConnectionTask<Socket>> Function(
      Uri url,
      String? proxyHost,
      int? proxyPort,
    )?
    f,
  ) {}
  @override
  set findProxy(String Function(Uri url)? f) {}
  @override
  set keyLog(dynamic Function(String line)? callback) {}

  @override
  void close({bool force = false}) {}

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> open(
    String method,
    String host,
    int port,
    String path,
  ) async => _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> get(String host, int port, String path) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> post(String host, int port, String path) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> postUrl(Uri url) async => _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> put(String host, int port, String path) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> putUrl(Uri url) async => _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> delete(String host, int port, String path) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> deleteUrl(Uri url) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> patch(String host, int port, String path) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> patchUrl(Uri url) async => _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> head(String host, int port, String path) async =>
      _MockHttpClientRequest();
  @override
  Future<HttpClientRequest> headUrl(Uri url) async => _MockHttpClientRequest();
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _MockHttpHeaders();

  @override
  bool bufferOutput = true;
  @override
  int contentLength = 0;
  @override
  Encoding encoding = utf8;
  @override
  bool followRedirects = true;
  @override
  int maxRedirects = 5;
  @override
  bool persistentConnection = false;

  @override
  void add(List<int> data) {}
  @override
  void addError(Object error, [StackTrace? stackTrace]) {}
  @override
  Future addStream(Stream<List<int>> stream) async {}
  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();
  @override
  Future<HttpClientResponse> get done async => _MockHttpClientResponse();
  @override
  void abort([Object? exception, StackTrace? stackTrace]) {}
  @override
  Future flush() async {}
  @override
  void write(Object? object) {}
  @override
  void writeAll(Iterable objects, [String separator = ""]) {}
  @override
  void writeCharCode(int charCode) {}
  @override
  void writeln([Object? object = ""]) {}

  @override
  // TODO: implement connectionInfo
  HttpConnectionInfo? get connectionInfo => throw UnimplementedError();

  @override
  // TODO: implement cookies
  List<Cookie> get cookies => throw UnimplementedError();

  @override
  // TODO: implement method
  String get method => throw UnimplementedError();

  @override
  // TODO: implement uri
  Uri get uri => throw UnimplementedError();
}

class _MockHttpClientResponse extends Stream<List<int>>
    implements HttpClientResponse {
  @override
  int get statusCode => HttpStatus.ok;
  @override
  int get contentLength => _transparentImage.length;
  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;
  @override
  final HttpHeaders headers = _MockHttpHeaders();
  @override
  final List<Cookie> cookies = [];
  @override
  final String reasonPhrase = 'OK';
  @override
  final bool isRedirect = false;
  @override
  final bool persistentConnection = false;
  @override
  final List<RedirectInfo> redirects = [];

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentImage]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<Socket> detachSocket() async => throw UnimplementedError();
  HttpClientResponse get response => this;
  @override
  X509Certificate? get certificate => null;
  @override
  HttpConnectionInfo? get connectionInfo => null;

  @override
  Future<HttpClientResponse> redirect([
    String? method,
    Uri? url,
    bool? followLoops,
  ]) {
    // TODO: implement redirect
    throw UnimplementedError();
  }
}

class _MockHttpHeaders implements HttpHeaders {
  final Map<String, List<String>> _headers = {};

  @override
  List<String>? operator [](String name) => _headers[name];
  @override
  String? value(String name) => _headers[name]?.first;
  @override
  void add(String name, Object value, {bool preserveHeaderCase = false}) {
    _headers.putIfAbsent(name, () => []).add(value.toString());
  }

  @override
  void set(String name, Object value, {bool preserveHeaderCase = false}) {
    _headers[name] = [value.toString()];
  }

  @override
  void remove(String name, Object value) =>
      _headers[name]?.remove(value.toString());
  @override
  void removeAll(String name) => _headers.remove(name);
  @override
  void forEach(void Function(String name, List<String> values) action) =>
      _headers.forEach(action);
  @override
  void noFolding(String name) {}
  @override
  void clear() => _headers.clear();
  @override
  bool chunkedTransferEncoding = false;
  @override
  int contentLength = 0;
  @override
  ContentType? contentType = ContentType.parse('image/png');
  @override
  DateTime? date;
  @override
  DateTime? expires;
  @override
  String? host;
  @override
  DateTime? ifModifiedSince;
  @override
  bool persistentConnection = false;
  @override
  int? port;
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  testWidgets('App loads login page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const UniqloApp());
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Selamat Datang di Uniqlo'), findsOneWidget);
  });
}
