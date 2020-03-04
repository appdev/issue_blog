class StringUtil {
  static bool isEmpty(String str) {
    return str == null || str == "null" || str.trim().length == 0 || str.isEmpty;
  }
}
