import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tryfirestore/studentModel.dart';
import 'bottom_navigation.dart';
import 'fetchDB.dart';
import 'package:intl/intl.dart';

class inputPage extends StatefulWidget {
  @override
  _inputPageState createState() => _inputPageState();
}

enum gender {male , female , lgbtq , ratherNotSay }

class _inputPageState extends State<inputPage> {
  TextEditingController? firstNameController = TextEditingController();
  TextEditingController? lastNameController = TextEditingController();
  TextEditingController? cityNameController = TextEditingController();
  //TextEditingController? collegeNameController = TextEditingController();
  TextEditingController? addressController = TextEditingController();
  int i=5;
  gender? _character = gender.ratherNotSay;
  DateTime selectedDate = DateTime.now();
  bool _math= false;
  bool _physics= false;
  bool _chem= false;
  bool _english= false;
  String collegeName = 'Marywood University';
  final DateFormat format = DateFormat('yyyy-MM-dd');

  @override
  void initState(){
    selectedDate = DateTime(selectedDate.year - 18, selectedDate.month, selectedDate.day);
  }
  //TextEditingController? idController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add Student'),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.all(10),
                //   child: TextFormField(
                //     controller: idController,
                //     decoration: const InputDecoration(
                //         border: OutlineInputBorder(),
                //         labelText: 'id',
                //         hintText: 'Enter id'
                //     ),),
                // ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        hintText: 'Enter name'
                    ),
                    onChanged: (value) {
                      var firstName = value;
                    },
                  ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        hintText: 'Enter last name'
                    ),
                    onChanged: (value) {
                      var lastName = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: cityNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'City',
                        hintText: 'Enter city'
                    ),
                    onChanged: (value) {
                      var cityName = value;
                    },
                  ),
                ),
                // College name here
                Padding(
                  padding: EdgeInsets.all(10),
                  child: DropdownButton<String>(
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: 'Enter address'
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
                      value: _math,
                      onChanged: (value) {
                        setState(() {
                          _math = !_math;
                        });
                      },),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Physics'),
                      value: _physics,
                      onChanged: (value) {
                        setState(() {
                          _physics = !_physics;
                        });
                      },),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Chemistry'),
                      value: _chem,
                      onChanged: (value) {
                        setState(() {
                          _chem = !_chem;
                        });
                      },),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('English'),
                      value: _english,
                      onChanged: (value) {
                        setState(() {
                          _english = !_english;
                        });
                      },),
                  ],
                ),

                //input ends here

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
                            id:i,
                            cityName: cityNameController!.text,
                            collegeName: collegeName,
                            address: addressController!.text,
                            character :_character!.name,
                            dob: selectedDate,
                            subjects: [_math,_physics,_chem,_english],
                        );
                        i++;
                        //await DBProvider.db.newStudent(rnd);
                        //final DataRepository repository = DataRepository();
                        uploadingData(rnd);
                        //await collection.addStudent(rnd);
                        setState(() {});
                        //print(await DBProvider.db.students());
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

  Future<void> uploadingData(Student rnd) async {
    await FirebaseFirestore.instance.collection("Student").add(rnd.toJson());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1916, 8),
        lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month, DateTime.now().day));//DateTime(2005));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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