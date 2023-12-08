class StudentModel {
  String? name;
  String? imageUrl;
  int? age;

  StudentModel({this.name, this.imageUrl, this.age});

  StudentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['age'] = this.age;
    return data;
  }
}
