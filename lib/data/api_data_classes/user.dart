import 'package:frontendmobile/data/api_abstraction/data_class.dart';

/*class User implements ApiDataClass{
  bool? activated;
  //List<String>? authorities;
  String? createdBy;
  String? createdDate;
  String? email;
  String? firstName;
  int? id;
  String? imageUrl;
  String? langKey;
  String? lastModifiedBy;
  String? lastModifiedDate;
  String? lastName;
  String? login;

  User(
      {this.activated,
        //this.authorities,
        this.createdBy,
        this.createdDate,
        this.email,
        this.firstName,
        this.id,
        this.imageUrl,
        this.langKey,
        this.lastModifiedBy,
        this.lastModifiedDate,
        this.lastName,
        this.login});

  User.fromJson(Map<String, dynamic> json) {
    activated = json['activated'];
    //authorities = json['authorities'].cast<String>();
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    email = json['email'];
    firstName = json['firstName'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    langKey = json['langKey'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
    lastName = json['lastName'];
    login = json['login'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activated'] = activated;
    //data['authorities'] = authorities;
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate;
    data['email'] = email;
    data['firstName'] = firstName;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['langKey'] = langKey;
    data['lastModifiedBy'] = lastModifiedBy;
    data['lastModifiedDate'] = lastModifiedDate;
    data['lastName'] = lastName;
    data['login'] = login;
    return data;
  }
}*/

class User implements ApiDataClass {
  String? name;
  String? login;
  List<Roles>? roles;
  bool? activated;

  User({this.name, this.login, this.roles, this.activated});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    login = json['login'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    activated = json['activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['login'] = this.login;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['activated'] = this.activated;
    return data;
  }
}

class Roles {
  String? name;
  List<Permissions>? permissions;

  Roles({this.name, this.permissions});

  Roles.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  String? name;

  Permissions({this.name});

  Permissions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
