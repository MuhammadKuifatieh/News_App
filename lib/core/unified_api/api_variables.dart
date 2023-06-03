class ApiVariables {
  ApiVariables._();
  static const _scheme = 'https';
  static const _host = "newsapi.org";

  static Uri _mainUri({
    required String path,
    Map<String, String>? params,
  }) =>
      Uri(
        scheme: _scheme,
        host: _host,
        path: "v2/$path",
        queryParameters: params,
      );
  static getRepo(Map<String, String> params) => _mainUri(
        path: "everything",
        params: params,
      );
}
