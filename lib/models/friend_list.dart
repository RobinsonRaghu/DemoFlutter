class FrindListVo {
  int? id;
  String? name;
  String? area;
  String? dob;
  String? photo;

  FrindListVo({this.id, this.name, this.area, this.dob, this.photo});

  FrindListVo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    area = json['area'];
    dob = json['dob'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['area'] = this.area;
    data['dob'] = this.dob;
    data['photo'] = this.photo;
    return data;
  }
}
