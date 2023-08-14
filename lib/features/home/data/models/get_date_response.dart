class GetDateResponse {
  String? month;
  int? year;
  List<Days>? days;

  GetDateResponse({this.month, this.year, this.days});

  GetDateResponse.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['year'] = year;
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Days {
  int? day;
  int? type;

  Days({this.day, this.type});

  Days.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['type'] = type;
    return data;
  }
}