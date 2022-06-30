import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'bottom_navigation.dart';
import 'fetchDB.dart';
import 'inputPage.dart';
import 'studentModel.dart';
import 'package:intl/intl.dart';




class updatePage extends StatefulWidget{
  String id;
  Student toShow;
  updatePage(this.toShow, this.id);
  @override
  State<StatefulWidget> createState() {
    return _updatePageState(this.toShow,this.id);
  }
}

class _updatePageState extends State<updatePage> {
  Student toShow;
  String id;
  _updatePageState(this.toShow, this.id);
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? cityNameController = TextEditingController();
  //TextEditingController? collegeNameController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  TextEditingController? idController = TextEditingController();

  String collegeName = 'a';
  gender? _character = gender.ratherNotSay;
  List<dynamic> subjects= [false,false,false,false];
  DateTime selectedDate= DateTime.now();

  final DateFormat format = DateFormat('yyyy-MM-dd');

  @override
  void initState(){
    firstNameController?.text = toShow.firstName ;
    lastNameController?.text = toShow.lastName;
    cityNameController?.text = toShow.cityName;
    addressController?.text = toShow.address;
    idController?.text = toShow.id.toString();
    collegeName =toShow.collegeName;
    //_character!.name = toShow.character;

    switch(toShow.character) {
      case 'male':
        _character= gender.male;
        break;
      case 'female':
        _character= gender.female;
        break;
      case 'ratherNotSay':
        _character= gender.ratherNotSay;
        break;
      case 'lgbtq':
        _character= gender.lgbtq;
        break;
    }

    subjects = toShow.subjects;
    selectedDate = toShow.dob;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Update Page'),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'id',
                        //hintText: 'Enter id',
                       // autofillHints()
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      //hintText: 'Enter name'
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                      //hintText: 'Enter last name'
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: cityNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                      //hintText: 'Enter city'
                    ),),
                ),
                //college name
                Padding(
                  padding: EdgeInsets.all(10),
                  child:  dropDown()
                ),
                //address
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      //hintText: 'Enter address'
                    ),),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Choose your gender:', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                        ),
                      ],
                    ),
                    ListTile(
                      title: const Text('Male'),
                      leading: Radio<gender>(
                        value: gender.male,
                        groupValue: _character,
                        onChanged: (gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio<gender>(
                        value: gender.female,
                        groupValue: _character,
                        onChanged: (gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('LGBTQ+'),
                      leading: Radio<gender>(
                        value: gender.lgbtq,
                        groupValue: _character,
                        onChanged: (gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Rather Not Say'),
                      leading: Radio<gender>(
                        value: gender.ratherNotSay,
                        groupValue: _character,
                        onChanged: (gender? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                //date
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    onPressed: () => _selectDate(context),
                    child: Wrap(
                      spacing: 60,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Date of Birth :${format.format(selectedDate)}', style: TextStyle(color: Colors.black45, fontSize: 19),
                          ),
                        ),
                        Icon(Icons.expand_more, size: 43, color: Colors.black45),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Choose your subjects:', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Math'),
                      value: subjects[0],
                      onChanged: (value) {
                        setState(() {
                          subjects[0] = !subjects[0];
                        });
                      },),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Physics'),
                      value: subjects[1],
                      onChanged: (value) {
                        setState(() {
                          subjects[1] = !subjects[1];
                        });
                      },),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Chemistry'),
                      value: subjects[2],
                      onChanged: (value) {
                        setState(() {
                          subjects[2] = !subjects[2];
                        });
                      },),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('English'),
                      value: subjects[3],
                      onChanged: (value) {
                        setState(() {
                          subjects[3] = !subjects[3];
                        });
                      },),
                  ],
                ),

                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: FloatingActionButton(
                    // onPressed: () {
                    //   Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) =>  sendToDatabase()), (route) => false);
                    // },
                    onPressed: () async {
                      if(firstNameController?.text == "" ) {
                        _showMyDialog("name can't be empty");
                      }
                      else if(lastNameController?.text == "" ) {
                        _showMyDialog("name can't be empty");
                      }
                      else {
                        Student rnd = Student(firstName: firstNameController!.text,
                          lastName: lastNameController!.text,
                          id : toShow.id,
                          cityName: cityNameController!.text,
                          collegeName: collegeName,
                          address: addressController!.text,
                          character :_character!.name,
                          dob: selectedDate,
                          subjects: subjects,
                        );

                        //await DBProvider.db.updateStudent(rnd);
                        editProduct(rnd, id);
                        setState(() {});
                        //await DBProvider.db.deleteStudent(toShow.id);
                        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) =>  navigationBar()), (route)=> false);
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),)
              ]
          ),
        )
    );
  }
  Widget dropDown() {
    try{
      return DropdownButton<String>(
        value: collegeName,
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        // elevation: 16,
        onChanged: (String? newValue) {
          setState(() {
            collegeName = newValue!;
          });
        },
        items: <String>[
          'Marywood University',
          'University of Charleston',
          'Hartnell College',
          'Santa Monica College',
          'Himeji Institute of Technology',
          'Changchun University of Technology'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    }
    catch(e, s){
      FirebaseCrashlytics.instance.setCustomKey('str_key', 'drop-down',);
      FirebaseCrashlytics.instance.log('non-fatal error college name not in list');
       FirebaseCrashlytics.instance.recordError(e, s,
          reason: 'non-fatal error college name not in list').then((value) {
            print("error logged");
       });
      return Text('College not in list');
    }
  }
  Future<void> editProduct(Student rnd ,String id) async {
    await FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .update(rnd.toJson());
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1916, 8),
        lastDate: DateTime(2005));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        //final String formatted = format.format(selectedDate);
        //var date = picked.toString();
      });
    }
  }
  Future<void> _showMyDialog(String validationMsg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(validationMsg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}