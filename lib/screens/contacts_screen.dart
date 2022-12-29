import 'package:database/dbhelper/database_helper.dart';
import 'package:database/model/contacts_model.dart';
import 'package:database/screens/add_contacts_screen.dart';
import 'package:flutter/material.dart';

class  contacts extends StatefulWidget {
  contacts ({Key? key}) : super(key: key);
  @override
  State<contacts> createState() => _State();
}

class _State extends State<contacts> {
  List<contactsModel> items = [];
  dataBaseHelper db = dataBaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    db.getAllContacts().then((contacts){
      setState(() {
        contacts.forEach((contact){
          items.add(contactsModel.fromMap(contact));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
        backgroundColor: Colors.white,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>_createNewContact(context),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white,),

      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15),
            itemBuilder: (context , position){
              return Column(
                children: <Widget> [
                  const Divider(height: 5.0,),
                  Row(
                    children: <Widget> [
                      Expanded(
                          child: ListTile(
                            title:  Text('${items[position].fName} ${items[position].lName} ',
                              style: const TextStyle(fontSize: 22.0,color: Colors.black
                              ),
                            ),
                            subtitle:  Text('${items[position].phone}\n${items[position].mail} ',
                              style: const TextStyle(fontSize: 14.0,fontStyle: FontStyle.italic,
                              color: Colors.black),
                            ),
                            leading: Column(
                              children:  <Widget>[
                                const Padding(padding: EdgeInsets.all(1.0)),
                                CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 22.0,
                                  child: Text('${items[position].id}',
                                    style: const TextStyle(fontSize: 22.0,color: Colors.red
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            onTap: () {},
                          )
                      ),

                      IconButton(icon: const Icon(Icons.edit,color: Colors.grey,),
                        onPressed: () => _navigateToContacts(context , items[position]),
                      ),

                      IconButton(icon: const Icon(Icons.delete,color: Colors.red,),
                          onPressed: () => _deleteContacts(context,items[position],position)
                      )
                    ],
                  )
                ],
              );
            }),
      )
        );

    }
  _deleteContacts(BuildContext context,contactsModel contacts,int position) async{
    db.deleteContacts(contacts.id!).then((_){
      setState(() {
        items.removeAt(position);
      });
    });

  }

  void  _navigateToContacts(BuildContext context ,contactsModel contacts)async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => addContacts(contacts)),);
    if (result == 'update') {
      db.getAllContacts().then((contacts) {
        setState(() {
          items.clear();
          contacts.forEach((contact) {
            items.add(contactsModel.fromMap(contact));
          });
        });
      });
    }
  }



  void _createNewContact(BuildContext context) async{
    String result =
    await Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => addContacts(
          contactsModel(  '', '', '', ''))),
    );

    if(result == 'save'){
      db.getAllContacts().then((contacts){
        setState(() {
          items.clear();
          contacts.forEach((contact){
            items.add(contactsModel.fromMap(contact));
          });
        });
      });
    }
  }


}




