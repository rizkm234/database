class contactsModel {
   int? _id;
   String _fName = '';
   String _lName = '';
   String _phone= '';
   String _mail= '';

  contactsModel( this._fName, this._lName, this._mail, this._phone);

  contactsModel.map (dynamic obj){
    this._id = obj['id'];
    this._fName = obj['fName'];
    this._lName = obj['lName'];
    this._phone = obj['phone'];
    this._mail = obj['mail'];
  }

  int? get id => _id;
  String get fName => _fName;
  String get lName => _lName;
  String get phone => _phone;
  String get mail => _mail;

  Map<String , dynamic > toMap(){
    var map = <String , dynamic>{};
    map['id'] = _id;
    map['fName'] = _fName;
    map['lName'] = _lName;
    map['phone'] = _phone;
    map['mail'] = _mail;

    return map;
  }

  contactsModel.fromMap (Map <dynamic, dynamic> map){
    this._id = map['id'];
    this._fName = map['fName'];
    this._lName = map['lName'];
    this._phone = map['phone'];
    this._mail = map['mail'];
  }

}