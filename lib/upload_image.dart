
import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UploadImage extends StatefulWidget{
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage>{

  DocumentReference sightingRef = FirebaseFirestore.instance.collection('images').doc();
  //Reference ref = FirebaseFirestore.instance.collection('images').doc() as Reference;
  // Image Picker
  List<XFile>? _images = [];
  final StorageRef = FirebaseStorage.instance.ref();
  //Reference? imagesRef = StorageRef.child("images");


  //File _image; // Used only if you need a single picture

  //get images image picker
  Future getImage(bool gallery) async {
    final listResult = await StorageRef.child('images').listAll();
    print(listResult.items);
    ImagePicker picker = ImagePicker();
    //XFile? pickedFile;
    // Let user select photo from gallery
    if(gallery) {
      _images = await picker.pickMultiImage();
      //pickedFile = await picker.pickImage(source: ImageSource.gallery,);
    }
    // Otherwise open camera to get new photo
    else{
      // pickedFile = await picker.pickImage(
      //   source: ImageSource.camera,);
      _images = await picker.pickMultiImage();
    }
    setState(() {
      if (_images != null) {
        //_images.add(File((pickedFile.path).length, pickedFile.name));
        //_image = File(pickedFile.path); // Use if you only need a single picture
        print('image selected.');
      } else {
        print('No image selected.');
      }
    });}

  @override
  void initState(){
    populatedata();
    super.initState();
  }

  populatedata() async {
    plist = await showList();
    await getURL();
    setState((){

    });
  }

  //upload images
    Future<String?> uploadFile(XFile _image) async {
      final storageRef = FirebaseStorage.instance.ref().child('images/${_image.name}(2)');
      //final storageRef = FirebaseStorage.instance.ref().child('images/${(_image.path)}');
      File file = File(_image.path);
      try {
        await storageRef.putFile(file);
        String returnURL;
        await storageRef.getDownloadURL().then((fileURL) {
          returnURL =  fileURL;
        });
      }  catch (e, s) {
        FirebaseCrashlytics.instance.setCustomKey('str_key', 'upload-image',);
        FirebaseCrashlytics.instance.log('upload-image not uploaded');
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: 'upload-image not uploaded').then((value) {
          print("error logged");});
            }

      }
  //save images
  Future<void> saveImages(List<XFile> _images, DocumentReference ref) async {
    _images.forEach((image) async {
      String imageURL = (await uploadFile(image)) ?? "";
      ref.update({"images": FieldValue.arrayUnion([imageURL])});
    });
  }

  List<String> plist = [];

  showList() async{
    List<String> p = [];
    final listResult = await StorageRef.child('images').listAll();
    for ( var img in listResult.items){
       p.add(img.name.toString());
    }
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Images")),
      body:
          ListView.builder(
            // the number of items in the list
              itemCount: plist.length,
              // display each item of the product list
              itemBuilder: (context, index) {
                Reference deleteRef;
                return Card(
                  // In many cases, the key isn't mandatory
                  key: UniqueKey(),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(url[index], height: 150,),
                                //gs://database-2f3c5.appspot.com/images/image_picker7134099721233168864.jpg(1)
                              ),
                              Row(
                                children: [
                                  Text(plist[index]),
                                // IconButton(
                                //   icon: const Icon(Icons.edit),
                                //   onPressed: () =>{
                                //     // deleteRef = StorageRef.child("images/${plist[index]}");
                                //     // await desertRef.delete();
                                //   }),
                                  const Spacer(),
                                IconButton(
                                  alignment: Alignment.bottomRight,
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async =>{
                                    deleteRef = StorageRef.child("images/${plist[index]}"),
                                    await deleteRef.delete(),
                                    populatedata(),
                                  })
                                ],
                              ),
                            ],
                          )),
                  )
                );
              }),

      floatingActionButton: FloatingActionButton(
        //fillColor: Theme.of(context).accentColor,
        child: Icon(Icons.add_photo_alternate_rounded,
        color: Colors.white,),
        elevation: 8,
        onPressed: () async {
          getImage(true);
          await saveImages(_images!,sightingRef);
          populatedata();
        },
        //padding: EdgeInsets.all(15),
        shape: CircleBorder(),
      ),
    );
  }

  List<String> url=[];
  getURL() async {
    //url = (await child.getDownloadURL().toString());
    final listResult = await StorageRef.child('images').listAll();
    for ( var img in listResult.items){
     var fileUrl =   await img.getDownloadURL();

      url.add(fileUrl);
    }
    //print(url);
  }
}
