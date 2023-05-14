class SignUpModel{
  String userName,phoneNumber,email,password;

  SignUpModel({required this.userName,required this.phoneNumber,required this.email,required this.password});

  Map<String,dynamic>toJson()=>{'userName':userName,'phone':phoneNumber,'email':email,'password':password};

}