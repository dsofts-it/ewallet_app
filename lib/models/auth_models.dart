enum OtpFlow { signup, login }

class OtpPayload {
  final OtpFlow flow;
  final String mobile;
  final String name;
  final String? userId;

  const OtpPayload({
    required this.flow,
    required this.mobile,
    this.name = '',
    this.userId,
  });
}

class AuthInitResult {
  final String userId;
  final String mobile;

  const AuthInitResult({
    required this.userId,
    required this.mobile,
  });
}

class AuthVerifyResult {
  final String token;
  final Map<String, dynamic> user;
  final String mobile;

  const AuthVerifyResult({
    required this.token,
    required this.user,
    required this.mobile,
  });
}
