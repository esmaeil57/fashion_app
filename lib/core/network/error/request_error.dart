class RequestError {
  RequestError({
    this.code,
    this.message,
    this.data,
  });
  String? code;
  String? message;
  Data? data;
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }

  RequestError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.status,
  });
  late final int status;

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    return _data;
  }
}
