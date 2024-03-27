class Session {
  Session({
    this.username,
    this.jwt,
    this.isAdmin,
    this.role,
    this.credit,
  });

  Session copyWith({
    String? username,
    String? jwt,
    bool? isAdmin,
    String? role,
    int? credit,
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
  final String? jwt;
  final bool? isAdmin;
  final String? role;
  final int? credit;

  bool get isAuthenticated => username != null && jwt != null;
}
