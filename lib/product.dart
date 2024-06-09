class Product{
  late int _id;
  late String _name;
  late bool _status;
  late String _update;
  late int _machineId;


  Product(this._id, this._name, this._status, this._update, this._machineId);

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


  String get update => _update;

  set update(String value) {
    _update = value;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _update = json['update'];
    _machineId = json['machineId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['name'] = _name;
    data['status'] = _status;
    data['update'] = _update;
    data['machineId'] = _machineId;
    return data;
  }

  int get machineId => _machineId;

  set machineId(int value) {
    _machineId = value;
  }
}