abstract class BasicApiEndpoint {

  /// Base of the target class url
  late String baseUrl;

  /// calls .fromJson of the target class
  dynamic createFromJson(parms);
}