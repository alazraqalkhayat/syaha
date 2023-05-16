import 'package:equatable/equatable.dart';

class GroupsModel extends Equatable{
  int id,rate;
  String image,name;
  List<dynamic> stores;

  GroupsModel({
    required this.id,
    required this.rate,
    required this.image,
    required this.name,
    required this.stores,
  });

  factory GroupsModel.fromJson(Map<String, dynamic> car) {
    return GroupsModel(
      id: car['id'],
      rate: car['rate'],
      image: car['image'],
      name: car['name'],
      stores: car['stores'] as List<dynamic>,
    );
  }

  GroupsModel fromJson(Map<String, dynamic> json) {
    return GroupsModel.fromJson(json);
  }

  factory GroupsModel.init() {
    return GroupsModel(
      id: 0,
      rate: 0,
      image: '',
      name: '',
      stores: [],
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<GroupsModel> data = [];
    jsonList.forEach((post) {
      data.add(GroupsModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'stores': stores,
  };

  @override

  List<Object?> get props => [id,image,name,stores];
}
