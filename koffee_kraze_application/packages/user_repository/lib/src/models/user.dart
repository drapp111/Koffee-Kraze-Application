class User {

  String avatarURL;
  String dob;
  String phoneNumber;
  String gender;
  String email;
  String firstName;
  String lastName;

  HaloUser(String email, {String firstName, String lastName, String gender, String dob, String phoneNumber, String avatarURL}) {
    this.email = email;
    this.firstName = firstName;
    this.lastName = lastName;
    this.gender = gender;
    this.dob = dob;
    this.phoneNumber = phoneNumber;
    this.avatarURL = avatarURL;
  }

  User.fromAuthUser(User user) {
    this.email = "";
    this.firstName = "";
    this.lastName = "";
    this.gender = "";
    this.dob = "";
    this.phoneNumber = "";
    this.avatarURL = "";
  }

  User.empty() {
    this.email = "-";
  }


}