import 'package:database/dbhelper/database_helper.dart';
import 'package:database/screens/contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:database/model/contacts_model.dart';
import '../constants/contact_info.dart';

class  addContacts extends StatefulWidget {
  final contactsModel contacts_model ;
   addContacts (this.contacts_model);

  @override
  State<addContacts> createState() => _State();
}

class _State extends State<addContacts> {
  dataBaseHelper db = new dataBaseHelper();
   TextEditingController _fname = TextEditingController();
   TextEditingController _lname = TextEditingController();
   TextEditingController _phone = TextEditingController();
   TextEditingController _mail = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fname = TextEditingController(text: widget.contacts_model.fName);
    _lname = TextEditingController(text: widget.contacts_model.lName);
    _phone = TextEditingController(text: widget.contacts_model.phone);
    _mail = TextEditingController(text: widget.contacts_model.mail);

  }
  // TextEditingController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add a new contact',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>contacts()));
        },
          icon: const Icon(Icons.arrow_back_ios , color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container (
          margin: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column (
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                    CircleAvatar(
                      maxRadius: 80,
                      backgroundColor: Colors.black,
                    )
                  ],),
                  const SizedBox(height: 40,),
                  Row(
                    children: [
                      contactInfo(container_width: MediaQuery.of(context).size.width/3
                        , hint_text: 'First Name', textIcon: Icons.person,
                        dbController:_fname),
                      const SizedBox(width: 10,),
                      contactInfo(container_width: MediaQuery.of(context).size.width/3
                        , hint_text: 'Last Name', textIcon: Icons.person,
                        dbController: _lname),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  contactInfo(container_width: MediaQuery.of(context).size.width/2
                    , hint_text: 'Phone number', textIcon: Icons.phone,
                    dbController: _phone),
                  const SizedBox(height: 20,),
                  contactInfo(container_width: MediaQuery.of(context).size.width/2
                    , hint_text: 'E-mail', textIcon: Icons.mail,
                    dbController: _mail),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: () {
                    if(widget.contacts_model.id != null){
                      db.updateContact(contactsModel.fromMap({
                        'id' : widget.contacts_model.id,
                        'fName' : _fname.text,
                        'lName' : _lname.text,
                        'mail' : _mail.text,
                        'phone' :  _phone.text,


                      })).then((_){
                        Navigator.pop(context, 'update');
                      }) ;
                    }
                    else {
                      db.saveContacts(contactsModel(
                        _fname.text,
                        _lname.text,
                        _mail.text,
                        _phone.text,


                      )).then((_){
                        Navigator.pop(context, 'save');
                      }
                      );
                    }
                  },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.black,
                        minimumSize: const Size(200, 55)),
                    child:const Text('save',style: TextStyle(color: Colors.white),) ,

                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

