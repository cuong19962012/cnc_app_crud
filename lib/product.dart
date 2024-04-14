class Product{
  late int _id;
  late String _name;
  late bool _status;
  late String _updateTime;
  late int _machineId;


  Product(this._id, this._name, this._status, this._updateTime, this._machineId);

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


  String get updateTime => _updateTime;

  set updateTime(String value) {
    _updateTime = value;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _updateTime = json['updateTime'];
    _machineId = json['machineId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['name'] = _name;
    data['status'] = _status;
    data['updateTime'] = updateTime;
    data['machineId'] = machineId;
    return data;
  }

  int get machineId => _machineId;

  set machineId(int value) {
    _machineId = value;
  }
}