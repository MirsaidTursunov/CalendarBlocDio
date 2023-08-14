class GetColorsResponse {
  int? type;
  String? color;

  GetColorsResponse({this.type, this.color});

  factory GetColorsResponse.fromJson(Map<String, dynamic> json) {
    return GetColorsResponse(
      type: json['type'],
      color: json['color'],
    );
  }
}