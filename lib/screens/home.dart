import 'dart:io';
import 'package:cat_dog/components/answer_text.dart';
import 'package:cat_dog/components/default_image.dart';
import 'package:cat_dog/components/headers.dart';
import 'package:cat_dog/components/home_frame.dart';
import 'package:cat_dog/styles/spacers.dart';
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
    loadModel();
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
    return HomeFrame(
      children: [
        SpaceH85(),
        HeaderFirst(),
        SpaceH6(),
        HeaderSecond(),
        SpaceH40(),
        Center(
          child: loading
              ? DefaultImage()
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: 250.0,
                        child: Image.file(_image),
                      ),
                      SpaceH20(),
                      _output.isNotEmpty
                          ? AnswerText(
                              '${_output[0]['label']}' +
                                  ' ${(_output[0]['confidence'] * 100).toStringAsFixed(2)}%',
                            )
                          : AnswerText(
                              'Unknown',
                            ),
                      SpaceH30(),
                    ],
                  ),
                ),
        ),
        CustomButton(
          text: 'Take a photo',
          onTap: pickImage,
          source: ImageSource.camera,
        ),
        SpaceH20(),
        CustomButton(
          text: 'Camera Roll',
          onTap: pickImage,
          source: ImageSource.gallery,
        ),
      ],
    );
  }
}
