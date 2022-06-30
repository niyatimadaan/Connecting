
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  String name = "Kapila Madaan";
  String subject = "Science";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Profile'),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, right: 20),
              child: Text("Teacher's Information", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Text('Name : $name'),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Text('Subject : $subject'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("Time-Table", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(10),
                child : Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: FixedColumnWidth(0),
                      2: FixedColumnWidth(64),
                      3: FixedColumnWidth(64),
                      4: FixedColumnWidth(64),
                      5: FixedColumnWidth(64),
                      6: FixedColumnWidth(20),
                      7: FixedColumnWidth(64),
                      8: FixedColumnWidth(64),
                      9: FixedColumnWidth(64),
                      10: FixedColumnWidth(64),
                    },
                    children: <TableRow>[
                      returnTableRow('MONDAY', 1,2,4,8),
                      returnTableRow('TUESDAY',1,3,4,7),
                      returnTableRow('WEDNESDAY',1,3,6,9),
                      returnTableRow('THURSDAY',1,2,7,9),
                      returnTableRow('FRIDAY',1,6,7,8),

                    ]
                )
              ),
            ),

          ],
        ),
    );
  }
  returnTableRow(String day, int b, int c, int d,int f){
    List<Widget> tableRowWidget = [];
    tableRowWidget = loop(day,b,c,d,f);
    return TableRow(
        children: tableRowWidget
    );
  }
  loop(String day,int b, int c, int d, int f){
    List<Widget> tableRowWidget = [];
    for(int i =0; i<10; i++){
      if(i ==0){
        tableRowWidget.add(returnClass(a:day));
      }
      if(i == b || i == c ||  i == d ||  i == f) {
        if(i% 3 ==0) {
          tableRowWidget.add(returnClass(a: 'VI-A')) ;
        }
        if(i% 3 ==1) {
          tableRowWidget.add(returnClass(a: 'VII-A'));
        }
        if(i% 3 ==2) {
          tableRowWidget.add(returnClass(a: 'VIII-D'));
        }
      }
      else if(i == 5){
        tableRowWidget.add(Container(
          height: 64,
          width: 64,
          color: Colors.purple,
        ));
      }
      else{
        tableRowWidget.add(returnClass());
      }
    }
    return tableRowWidget;
  }
  returnClass({String? a}){
    if(a != null){
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(a, textAlign: TextAlign.center),
        ),
      );
    }
    return Container();
  }
}