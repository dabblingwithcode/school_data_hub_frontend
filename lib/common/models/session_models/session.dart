class Session {
  Session({
    this.username,
    this.publicId,
    this.jwt,
    this.isAdmin,
    this.role,
    this.credit,
    this.timeUnits,
  });

  Session copyWith({
    String? username,
    String? publicId,
    String? jwt,
    bool? isAdmin,
    String? role,
    int? credit,
    int? timeUnits,
  }) =>
      Session(
        username: username ?? this.username,
        jwt: jwt ?? this.jwt,
        isAdmin: isAdmin ?? this.isAdmin,
        role: role ?? this.role,
        credit: credit ?? this.credit,
      );

  factory Session.fromJson(final Map<String, dynamic> json) => Session(
        username: json["username"],
        jwt: json["token"],
        isAdmin: json["admin"],
        role: json["role"],
        credit: json["credit"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "token": jwt,
        "admin": isAdmin,
        "role": role,
        "credit": credit,
      };

  final String? username;
  final String? publicId;
  final String? jwt;
  final bool? isAdmin;
  final String? role;
  final int? credit;
  final int? timeUnits;

  bool get isAuthenticated => username != null && jwt != null;
}
