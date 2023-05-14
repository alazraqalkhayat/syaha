class UserModel{
  int id;
  String userName,phone,email,image,token;

  UserModel({required this.id,required this.userName,required this.phone,required this.email,required this.image,required this.token});

    factory UserModel.fromJson(Map<String,dynamic> user){
      return UserModel(id:user['id'],token:user['token'],phone: user['phone'],email: user['email'],image:user['image'],userName:user['userName'],);
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  factory UserModel.init(){
    return UserModel(
      id: 0,
      token: '',
      phone: '',
      image: '',
      userName: '',
      email: ''
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<UserModel> data = [];
    jsonList.forEach((post) {
      data.add(UserModel.fromJson(post));
    });
    return data;
  }
  Map<String,dynamic>toJson()=>{'id':id,'token':token,'phone':phone,'email':email,'image':image,'userName':userName};

}