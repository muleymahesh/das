import 'package:das_app/data/model/user.dart';

class Requests {
  String? id;
  String? raisedBy;
  String? pendingWith;
  String? amount;
  String? date;
  String? status;

  Requests(
      {this.id, this.raisedBy, this.pendingWith, this.amount, this.date, this.status});

  Requests copyWith(
      {String? id, String? raisedBy, String? pendingWith, String? amount, String? date, String? status}) =>
      Requests(id: id ?? this.id,
          raisedBy: raisedBy ?? this.raisedBy,
          pendingWith: pendingWith ?? this.pendingWith,
          amount: amount ?? this.amount,
          date: date ?? this.date,
          status: status ?? this.status);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["raised_by"] = raisedBy;
    map["pending_with"] = pendingWith;
    map["amount"] = amount;
    map["date"] = date;
    map["status"] = status;
    return map;
  }

  Requests.fromJson(dynamic json){
    id = json["id"];
    raisedBy = json["raised_by"];
    pendingWith = json["pending_with"];
    amount = json["amount"];
    date = json["date"];
    status = json["status"];
  }
}

class DepositionResponse {
  List<Requests>? requestsList;
  User? user;
  DepositionResponse({this.requestsList, this.user});

  DepositionResponse copyWith({List<Requests>? requestsList}) =>
      DepositionResponse(requestsList: requestsList ?? this.requestsList);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (requestsList != null) {
      map["requests"] = requestsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  DepositionResponse.fromJson(dynamic json){
    if (json["requests"] != null) {
      requestsList = [];
      json["requests"].forEach((v) {
        requestsList?.add(Requests.fromJson(v));
      });
    }
  }
}