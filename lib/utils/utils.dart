class Utils {
  static String getUsername(String email) => "live:${email.split('@')[0]}";

  static String getInitials(String displayName) {
    List<String> split = displayName.split(" ");
    return split[0][0] + split[1][0];
  }
}
