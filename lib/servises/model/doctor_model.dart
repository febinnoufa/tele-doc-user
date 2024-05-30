class DoctorModel {
  final String id;
  final String bio;
  final String email;
  final String experience;
  final String licensenumber;
  final String genter;
  final String name;
  final int phonenumber;
  final String place;
  final String profile;
  final String? experiencecirtificate;
  final String licenseimage;
  final String specialist;
  final String password;

  DoctorModel({
    required this.id,
    required this.bio,
    required this.email,
    required this.experience,
    required this.licensenumber,
    required this.genter,
    required this.name,
    required this.phonenumber,
    required this.place,
    required this.profile,
    this.experiencecirtificate,
    required this.licenseimage,
    required this.specialist,
    required this.password,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id:map['id'],
      bio: map['bio'],
      email: map['email'],
      experience: map['experience'],
      licensenumber: map['licensenumber'],
      genter: map['genter'],
      name: map['name'],
      phonenumber: map['phonenumber'],
      place: map['place'],
      profile: map['profile'],
      experiencecirtificate: map['experiencecirtificate'],
      licenseimage: map['licenseimage'],
      specialist: map['specialist'],
      password: map['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'bio': bio,
      'email': email,
      'experience': experience,
      'licensenumber': licensenumber,
      'genter': genter,
      'name': name,
      'phonenumber': phonenumber,
      'place': place,
      'profile': profile,
      'experiencecirtificate': experiencecirtificate,
      'licenseimage': licenseimage,
      'specialist': specialist,
      'password': password,
    };
  }
}
