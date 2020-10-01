import 'dart:io';
import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  File _image;
  List _output;

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _output = output;
      loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  pickImage(ImageSource source) async {
    var image = await ImagePicker().getImage(
      source: source,
    );
    if (image == null) return null;

    setState(() => _image = File(image.path));

    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 85.0,
            ),
            Text(
              'TeachableMachine.com CNN',
              style: TextStyle(
                color: Color(0xFFEEDA28),
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              'Detect Dogs and Cats',
              style: TextStyle(
                color: Color(0xFFE99600),
                fontSize: 28.0,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: loading
                  ? Container(
                      width: 280.0,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/dog_cat.png',
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250.0,
                            child: Image.file(_image),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          _output != null
                              ? Text(
                                  '${_output[0]['label']}' +
                                      ' ${(_output[0]['confidence'] * 100).toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 30.0,
                          ),
                        ],
                      ),
                    ),
            ),
            CustomButton(
              text: 'Take a photo',
              onTap: pickImage,
              source: ImageSource.camera,
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomButton(
              text: 'Camera Roll',
              onTap: pickImage,
              source: ImageSource.gallery,
            ),
          ],
        ),
      ),
    );
  }
}
