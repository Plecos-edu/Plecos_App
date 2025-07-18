class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String avatarUrl;
  final bool isOnline;
  final DateTime lastSeen;
  final List<String> qualifications;
  final List<String> education;
  final String resumeUrl;
  final List<String> subjectAreas;
  final Map<String, String> skillLevels; // subject: level
  final List<String> badgeIds;
  final String bio;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl = '',
    this.isOnline = true,
    required this.lastSeen,
    this.qualifications = const [],
    this.education = const [],
    this.resumeUrl = '',
    this.subjectAreas = const [],
    this.skillLevels = const {},
    this.badgeIds = const [],
    this.bio = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      avatarUrl: json['avatarUrl'] ?? '',
      isOnline: json['isOnline'] ?? true,
      lastSeen: DateTime.parse(json['lastSeen']),
      qualifications: List<String>.from(json['qualifications'] ?? []),
      education: List<String>.from(json['education'] ?? []),
      resumeUrl: json['resumeUrl'] ?? '',
      subjectAreas: List<String>.from(json['subjectAreas'] ?? []),
      skillLevels: Map<String, String>.from(json['skillLevels'] ?? {}),
      badgeIds: List<String>.from(json['badgeIds'] ?? []),
      bio: json['bio'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'avatarUrl': avatarUrl,
      'isOnline': isOnline,
      'lastSeen': lastSeen.toIso8601String(),
      'qualifications': qualifications,
      'education': education,
      'resumeUrl': resumeUrl,
      'subjectAreas': subjectAreas,
      'skillLevels': skillLevels,
      'badgeIds': badgeIds,
      'bio': bio,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? avatarUrl,
    bool? isOnline,
    DateTime? lastSeen,
    List<String>? qualifications,
    List<String>? education,
    String? resumeUrl,
    List<String>? subjectAreas,
    Map<String, String>? skillLevels,
    List<String>? badgeIds,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      qualifications: qualifications ?? this.qualifications,
      education: education ?? this.education,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      subjectAreas: subjectAreas ?? this.subjectAreas,
      skillLevels: skillLevels ?? this.skillLevels,
      badgeIds: badgeIds ?? this.badgeIds,
      bio: bio ?? this.bio,
    );
  }
} 