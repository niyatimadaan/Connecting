import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tryfirestore/remote_config.dart';
import 'package:tryfirestore/updatePage.dart';
import 'inputPage.dart';
import 'studentModel.dart';

class fetchDB extends StatefulWidget {
  @override
  _fetchDBState createState() => _fetchDBState();
  CollectionReference collection = FirebaseFirestore.instance.collection('Student');
}

class _fetchDBState extends State<fetchDB> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Students Information"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () => Navigator.push(context,  MaterialPageRoute(builder: (context) =>  remoteConfig(),)),
            child: Icon(Icons.app_settings_alt_rounded,),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),]
      ),
      body: StreamBuilder(
          stream: fetchDB().collection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                Student stu;
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['firstName']),
                    subtitle: Text(documentSnapshot['collegeName'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => {
                                stu = Student(
                                firstName : documentSnapshot['firstName'],
                                lastName: documentSnapshot['lastName'],
                                id :documentSnapshot['id'],
                                cityName: documentSnapshot['cityName'],
                                collegeName: documentSnapshot['collegeName'],
                                address : documentSnapshot['address'],
                                character : documentSnapshot['gender'],
                                dob: documentSnapshot['dateOfBirth'].toDate(),
                                subjects: documentSnapshot['subjects'],),
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => updatePage( stu , documentSnapshot.id),
                                  )),
                            },),
                          // This icon button is used to delete a single product
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>{
                              deleteStudent(documentSnapshot)
                            }
                            //_deleteProduct(documentSnapshot.id)
                          )
                        ],
                      ),
                    ),
                  ),
                );
                },
              );
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
      }
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,  MaterialPageRoute(builder: (context) =>  inputPage(), )),
          child: const Icon(Icons.add),
        ),
    );
  }
  // void deleteStudent(int id) async {
  //   await fetchDB().collection.doc((id).toString()).delete();
  // }
  Future<void> deleteStudent(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(doc.id)
        .delete();
  }

}