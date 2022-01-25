class User {
  bool? activated;
  List<String>? authorities;
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
        this.authorities,
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
    authorities = json['authorities'].cast<String>();
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activated'] = activated;
    data['authorities'] = authorities;
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
}