import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/upload.dart';
import '../size_config.dart';

class TriggerDialogs extends StatefulWidget {

  @override
  TriggerDialogsState createState() => TriggerDialogsState();
}

class TriggerDialogsState extends State<TriggerDialogs> {
  late String pickedImagePath;
  bool onUpload = true;
  bool isLoading = true;
  Upload? prediction;
  Upload? finalUpload;
  final formKey = GlobalKey<FormState>();
  bool isPredictionCorrect = true;
  int? misclassID;

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: _titleState(),
      icon: _iconState(),
      content: _contentState(),
      actions: _actionsState(),
    );
  }

  Widget _titleState() {
    if (isLoading && onUpload) {
      return const Text("Accessing Gallery...");
    } else if (!isLoading && onUpload) {
      return const Text("Image uploaded successfully");
    } else if (isLoading && !onUpload) {
      return const Text("Getting prediction...");
    } else {
      return Text(prediction!.title);
    }
  }

  Widget _iconState() {
    if (isLoading) {
      return const CircleAvatar(backgroundColor: Colors.transparent, child: CircularProgressIndicator());
    } else if (onUpload) {
      return Image.file(File(pickedImagePath), height: SizeConfig.screenHeight / 3, fit: BoxFit.fitHeight);
    } else {
      return Image.file(File(prediction!.imgSrc), height: SizeConfig.screenHeight / 3, fit: BoxFit.fitHeight);
    }
  }

  List<Widget> _actionsState() {
    if (isLoading) {
      return [];
    } else if (onUpload) {
      return [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        TextButton(
          autofocus: true,
          child: const Text("Predict"),
          onPressed: () {
            setState(() {
              onUpload = false;
              isLoading = true;
            });
            _handlePrediction(pickedImagePath);
          },
        ),
      ];
    } else {
      return [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        TextButton(
          autofocus: true,
          child: const Text("Confirm"),
          onPressed: () {
            finalUpload = (isPredictionCorrect) ? prediction
                : Upload(
              id: misclassID!,
              title: uploadClasses[misclassID!].title,
              misclassTitle: prediction!.title,
              isCorrect: false,
              imgSrc: prediction!.imgSrc,
              confidence: prediction!.confidence,
              inferenceTime: prediction!.inferenceTime,
            );
            Navigator.of(context).pop(finalUpload);
          },
        ),
      ];
    }
  }

  Widget? _contentState() {
    if (!isLoading && !onUpload) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfo(const Icon(Icons.timelapse_rounded), "${prediction!.inferenceTime} ms"),
              _buildInfo(const Icon(Icons.model_training_rounded), "${(prediction!.confidence * 100).toStringAsFixed((prediction!.confidence == 1) ? 0 : 1)}%"),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.defaultSize * 2),
            child: const Text('Is the given prediction correct?',),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: isPredictionCorrect,
                    onChanged: (bool? value) {
                      setState(() {
                        isPredictionCorrect = value!;
                      });
                    },
                  ),
                  const Text("Yes"),
                ],
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: isPredictionCorrect,
                    onChanged: (bool? value) {
                      setState(() {
                        isPredictionCorrect = value!;
                      });
                    },
                  ),
                  const Text("No"),
                ],
              ),
            ],
          ),
          if (!isPredictionCorrect) ...[
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                hintText: "Correct class",
              ),
              elevation: 0,
              items: uploadClasses.where((upload) => upload.id != prediction!.id).toList().map<DropdownMenuItem<String>>((Upload upload) {
                return DropdownMenuItem<String>(
                  value: "${upload.id}",
                  child: Text(upload.title),
                );
              }).toList(),
              onChanged: (String? newValue) {
                misclassID = int.parse(newValue!);
              },
            ),
          ],
        ],
      );
    } else {
      return null;
    }
  }

  Widget _buildInfo(Icon icon, String text) {
    return Column(
      children: <Widget>[
        icon,
        SizedBox(width: SizeConfig.defaultSize),
        Text(text, textAlign: TextAlign.center,),
      ],
    );
  }

  Future<void> _fetchImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImagePath = image.path;
        isLoading = false;
      });
    } else {
      Navigator.of(context).pop(null);
    }
  }

  Future<void> _handlePrediction(String imagePath) async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      prediction = simulatedUploads[Random().nextInt(45)];
      prediction?.imgSrc = imagePath;
      isLoading = false;
    });
  }
}