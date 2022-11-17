class Constants {
  static const ENVIROMENT = "PRODUCTION";
  static const APIURL = ENVIROMENT == "PRODUCTION"
      ? "https://clientes.s-ii.com.mx"
      : "http://192.168.1.208:8000";
  static const APICLEANURL = ENVIROMENT == "PRODUCTION"
      ? "https://clientes.s-ii.com.mx"
      : "http://192.168.1.208:8000";
}
