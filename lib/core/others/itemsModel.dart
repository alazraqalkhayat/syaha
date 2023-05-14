class ItemsModel {
  int id;
  String name;

  ItemsModel({
    required this.id,
    required this.name,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> city) {
    return ItemsModel(
      id: city['id'],
      name: city['name'],
    );
  }

  ItemsModel fromJson(Map<String, dynamic> json) {
    return ItemsModel.fromJson(json);
  }

  factory ItemsModel.init() {
    return ItemsModel(
      id: 0,
      name: '',
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<ItemsModel> data = [];
    jsonList.forEach((post) {
      data.add(ItemsModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
