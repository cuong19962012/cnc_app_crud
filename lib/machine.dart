class Machine {
  late int _id;
  late String _name;
  late bool _status;

  Machine(this._id, this._name, this._status);

  bool get status => _status;

  set status(bool value) {
    _status = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Machine.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['name'] = _name;
    data['status'] = _status;
    return data;
  }
}
