const _userId = 'id';
const _userFirstname = 'firstname';
const _userLastname = 'lastname';
const _userUsername = 'username';
const _userEmail = 'email';
const _userPhoneNumber = 'phoneNumber';
const _userSessionToken = 'sessionToken';

class User {
  int id = -1;
  String firstname = '',
      lastname = '',
      username = '',
      email = '',
      phoneNumber = '',
      sessionToken = '';

  User.anonymous() : this();

  User();

  Map<String, dynamic> toJson() {
    return {
      _userId: id,
      _userFirstname: firstname,
      _userLastname: lastname,
      _userUsername: username,
      _userEmail: email,
      _userPhoneNumber: phoneNumber,
      _userSessionToken: sessionToken,
    };
  }

  /// Factory From Json function
  factory User.fromJson(Map<String, dynamic> json) {
    User user = User();

    user.id = (json[_userId] != null &&
            int.tryParse(json[_userId].toString()) != null)
        ? json[_userId]
        : 0;

    user.firstname = (json[_userFirstname] != null) ? json[_userFirstname] : '';

    user.lastname = (json[_userLastname] != null) ? json[_userLastname] : '';

    user.username = (json[_userUsername] != null) ? json[_userUsername] : '';

    user.email = (json[_userEmail] != null) ? json[_userEmail] : '';

    user.phoneNumber =
        (json[_userPhoneNumber] != null) ? json[_userPhoneNumber] : '';

    user.sessionToken =
        (json[_userSessionToken] != null) ? json[_userSessionToken] : '';

    if (user.id == -1 || user.id == 0) {
      throw ('Could not parse User');
    }

    return user;
  }

  String get fullName => '$firstname $lastname';
}

class DtoUser {
  final String firstname, lastname, username, email, password, phoneNumber;

  DtoUser({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
}
