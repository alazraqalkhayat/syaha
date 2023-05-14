class CustomerDropDownListModel {
  int id;
  String name;

  CustomerDropDownListModel({required this.id,
    required this.name,
  });

  factory CustomerDropDownListModel.fromJson(Map<String, dynamic> banks) {
    return CustomerDropDownListModel(
      id: banks['id'],
      name: banks['name'],
    );
  }

  CustomerDropDownListModel fromJson(Map<String, dynamic> json) {
    return CustomerDropDownListModel.fromJson(json);
  }

  factory CustomerDropDownListModel.init() {
    return CustomerDropDownListModel(
      id: 0,
      name: '',

    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<CustomerDropDownListModel> data = [];
    jsonList.forEach((post) {
      data.add(CustomerDropDownListModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,

      };
}
