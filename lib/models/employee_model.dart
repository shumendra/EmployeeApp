class EmployeeModel {
  int? count;
  Null? next;
  Null? previous;
  List<Results>? results;

  EmployeeModel({this.count, this.next, this.previous, this.results});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? hireDate;
  String? address;
  String? city;
  String? zipCode;
  String? country;
  String? phone;
  String? photo;
  String? salary;
  String? designation;
  String? organizationName;
  String? status;

  Results(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.dob,
      this.hireDate,
      this.address,
      this.city,
      this.zipCode,
      this.country,
      this.phone,
      this.photo,
      this.salary,
      this.designation,
      this.organizationName,
      this.status});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dob = json['dob'];
    hireDate = json['hire_date'];
    address = json['address'];
    city = json['city'];
    zipCode = json['zip_code'];
    country = json['country'];
    phone = json['phone'];
    photo = json['photo'];
    salary = json['salary'];
    designation = json['designation'];
    organizationName = json['organization_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['hire_date'] = this.hireDate;
    data['address'] = this.address;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['photo'] = this.photo;
    data['salary'] = this.salary;
    data['designation'] = this.designation;
    data['organization_name'] = this.organizationName;
    data['status'] = this.status;
    return data;
  }
}
