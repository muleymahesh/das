class Bookings {
  String? customerId;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? pincode;
  String? userId;


  Bookings(
      {this.customerId, this.name, this.mobile, this.email, this.address, this.pincode, this.userId});

  Bookings copyWith(
      {String? customerId, String? name, String? mobile, String? email, String? address, String? pincode, String? userId}) =>
      Bookings(customerId: customerId ?? this.customerId,
          name: name ?? this.name,
          mobile: mobile ?? this.mobile,
          email: email ?? this.email,
          address: address ?? this.address,
          pincode: pincode ?? this.pincode,
          userId: userId ?? this.userId);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["customer_id"] = customerId;
    map["name"] = name;
    map["mobile"] = mobile;
    map["email"] = email;
    map["address"] = address;
    map["pincode"] = pincode;
    map["user_id"] = userId;
    return map;
  }

  Bookings.fromJson(dynamic json){
    customerId = json["customer_id"];
    name = json["name"];
    mobile = json["mobile"];
    email = json["email"];
    address = json["address"];
    pincode = json["pincode"];
    userId = json["user_id"];
  }
}

class BookingResponse {
  List<Bookings>? bookingsList;
  String? error;
  BookingResponse({this.bookingsList, this.error});

  BookingResponse copyWith({List<Bookings>? bookingsList}) =>
      BookingResponse(bookingsList: bookingsList ?? this.bookingsList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bookingsList != null) {
      map["bookings"] = bookingsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  BookingResponse.fromJson(dynamic json){
    if (json["bookings"] != null) {
      bookingsList = [];
      json["bookings"].forEach((v) {
        bookingsList?.add(Bookings.fromJson(v));
      });
    }
  }
}