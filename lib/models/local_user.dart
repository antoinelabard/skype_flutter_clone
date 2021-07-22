class LocalUser {
  String? uid = "";
  String? name = "";
  String? email = "";
  String? username = "";
  String? status = "";
  int? state = -1;
  String? profilePhoto = "";

  LocalUser({
    this.uid,
    this.name,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data["status"] = this.status;
    data["state"] = this.state;
    data["profile_photo"] = this.profilePhoto;
    return data;
  }

  LocalUser.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.username = mapData['username'];
    this.status = mapData['status'];
    this.state = mapData['state'];
    this.profilePhoto = mapData['profile_photo'];
  }
}
