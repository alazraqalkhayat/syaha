class EditProfileModel {
  String name, phone, email, image, newPassword, token;

  EditProfileModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.image,
      required this.newPassword,
      required this.token});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'password': newPassword,
        'api_token':token
      };
}
