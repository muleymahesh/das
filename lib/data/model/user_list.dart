class UserItem {
  String? userId;
  String? name;
  String? username;
  String? password;
  String? mobile;
  String? roleId;
  String? regionId;
  String? supervisorId;
  String? collection;
  String? commission;

  UserItem(
      {this.userId, this.name, this.username, this.password, this.mobile, this.roleId, this.regionId, this.supervisorId, this.collection, this.commission});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["user_id"] = userId;
    map["name"] = name;
    map["username"] = username;
    map["password"] = password;
    map["mobile"] = mobile;
    map["role_id"] = roleId;
    map["region_id"] = regionId;
    map["supervisor_id"] = supervisorId;
    map["collection"] = collection;
    map["commission"] = commission;
    return map;
  }

  UserItem.fromJson(dynamic json){
    userId = json["user_id"];
    name = json["name"];
    username = json["username"];
    password = json["password"];
    mobile = json["mobile"];
    roleId = json["role_id"];
    regionId = json["region_id"];
    supervisorId = json["supervisor_id"];
    collection = json["collection"];
    commission = json["commission"];
  }
}

class UserList {
  List<UserItem>? dataListList;

  UserList({this.dataListList});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataListList != null) {
      map["dataList"] = dataListList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  UserList.fromJson(dynamic json){
    if (json != null) {
      dataListList = [];
      json.forEach((v) {
        dataListList?.add(UserItem.fromJson(v));
      });
    }
  }
}