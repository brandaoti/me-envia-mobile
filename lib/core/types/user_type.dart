enum UserType { user, admin }

extension UserTypeExtension on UserType {
  String get value {
    switch (this) {
      case UserType.user:
        return 'user';
      case UserType.admin:
        return 'admin';
      default:
        return 'user';
    }
  }
}

extension JsonUserTypeExtension on String {
  UserType get fromJson {
    if (this == UserType.user.value) {
      return UserType.user;
    } else if (this == UserType.admin.value) {
      return UserType.admin;
    } else {
      return UserType.user;
    }
  }
}
