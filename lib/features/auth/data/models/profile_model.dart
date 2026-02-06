/// Profile model matching the backend `GET /api/v1/profiles/me` response.
class ProfileModel {
  final String id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final String planType;
  final bool termsAccepted;
  final bool privacyAccepted;
  final bool marketingAccepted;
  final String? createdAt;

  const ProfileModel({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    this.planType = 'FREE',
    this.termsAccepted = false,
    this.privacyAccepted = false,
    this.marketingAccepted = false,
    this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      planType: json['planType'] as String? ?? 'FREE',
      termsAccepted: json['termsAccepted'] as bool? ?? false,
      privacyAccepted: json['privacyAccepted'] as bool? ?? false,
      marketingAccepted: json['marketingAccepted'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
    );
  }

  /// Returns the user's initials for avatar placeholder.
  String get initials {
    if (fullName != null && fullName!.isNotEmpty) {
      final parts = fullName!.trim().split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
      }
      return parts[0][0].toUpperCase();
    }
    if (email.isNotEmpty) {
      return email[0].toUpperCase();
    }
    return '?';
  }
}
