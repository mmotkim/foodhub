class VerificationCode {
  final String code;
  final DateTime created;

  VerificationCode({
    required this.code,
    required this.created,
  });

  factory VerificationCode.fromJson(Map<String, dynamic> json) {
    return VerificationCode(
      code: json['code'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      code: created.toIso8601String(),
    };
  }
}
