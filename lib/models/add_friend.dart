class AddFriendVo {
  String? name;
  String? area;
  String? dob;
  String? photo;

  AddFriendVo({this.name, this.area, this.dob, this.photo});

  AddFriendVo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    area = json['area'];
    dob = json['dob'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['area'] = this.area;
    data['dob'] = this.dob;
    data['photo'] = this.photo;
    return data;
  }
}
