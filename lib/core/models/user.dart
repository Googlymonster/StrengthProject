class User {
  // Properties
  String uid;
  String firstName;
  String lastName;
  String email;

  // Constructor
  User({this.uid, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email
      };

  /// Custom comparator logic below so that even if two objects
  /// are not the same insance they will return true when compared
  /// if there members are equal.
  @override
  int get hashCode => email.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is User && email == other.email;
}

class UserData extends User {
  // Properties
  final String uid;
  final List<double> userWeight;
  final double userHeight;

  // Named Constructor
  UserData({this.uid, this.userWeight, this.userHeight});
}
