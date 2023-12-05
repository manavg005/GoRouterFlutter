import 'package:universal_html/html.dart' as html;

class CookieManager {
  static addToCookie(String key, String value) {
    // 2592000 sec = 30 days.
    html.document.cookie = "$key=$value; path=/;";
  }

  static String getCookie(String key) {
    String? cookies = html.document.cookie;
    List<String> listValues =
        cookies != null && cookies.isNotEmpty ? cookies.split(";") : [];
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String key0 = map[0].trim();
      String val = map[1].trim();
      if (key == key0) {
        matchVal = val;
        break;
      }
    }
    return matchVal;
  }
}
