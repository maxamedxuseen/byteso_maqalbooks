class Gateways {
  static final Gateways _instance = Gateways._internal(
    domains: "https://bytesotech.cloud/",
    port: "maqalbooks/api",
  );

  String domains;
  String port;

  factory Gateways() {
    return _instance;
  }

  Gateways._internal({required this.domains, required this.port});

  String get booksURL => "$domains$port/books/";
  String get catagoryURL => "$domains$port/catagory/";
  String get chaptersURL => "$domains$port/chepters/";
  String get customerLoginURL => "$domains$port/customer/login/";
  String get customersURL => "$domains$port/customer/";
}
