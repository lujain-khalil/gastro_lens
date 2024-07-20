import 'dart:io';
import 'package:flutter/material.dart';
import '../models/upload.dart';
import '../size_config.dart';

class UploadCard extends StatefulWidget {
  final List<Upload> globalUploads;
  final int uploadIndex;
  final Animation<double>? animation;
  final AnimationController? animationController;
  final Upload upload;

  UploadCard({
    required this.globalUploads,
    required this.uploadIndex,
    required this.animation,
    required this.animationController,
    super.key}) : upload = globalUploads[uploadIndex];

  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (context, Widget? child) {
          return FadeTransition(
            opacity: widget.animation!,
            child: Transform(
              transform: Matrix4.translationValues(0.0, 50 * (1.0 - widget.animation!.value), 0.0),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 2,
                    vertical: SizeConfig.defaultSize * 0.5
                ),
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  elevation: 10,
                  child: Row(
                    children: <Widget>[
                      _buildImg(),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.defaultSize * 1.5,
                            right: SizeConfig.defaultSize,
                            top: SizeConfig.defaultSize * 1.5,
                            bottom: SizeConfig.defaultSize,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildTitle(),
                              const Spacer(),
                              _buildInfo(Icons.timelapse_rounded, "${widget.upload.inferenceTime} ms", false, null),
                              _buildInfo(Icons.model_training_rounded,
                                        "${(widget.upload.confidence*100).toStringAsFixed((widget.upload.confidence == 1) ? 0 : 1)}% Confidence", false, null),
                              _buildCheck(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _buildCheck() {
    late IconData iconData;
    late Color color;
    late String text;
    if (widget.upload.isCorrect) {
      iconData = Icons.check;
      color = Theme.of(context).colorScheme.tertiary;
      text = 'Correctly Classified';
    } else {
      iconData = Icons.error_outline_rounded;
      color = Theme.of(context).colorScheme.error;
      text = widget.upload.misclassTitle;
    }
    return _buildInfo(iconData, text, true, color);
  }

  Text _buildTitle() {
    return Text(
      widget.upload.title,
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildInfo(IconData icon, String text, bool isCheck, Color? color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize/10),
      child: Row(
        children: <Widget>[
          (isCheck) ? Icon(icon, size: SizeConfig.defaultSize * 2, color: color) : Icon(icon, size: SizeConfig.defaultSize * 2,),
          SizedBox(width: SizeConfig.defaultSize),
          (isCheck) ? Text(text, style: TextStyle(color: color, fontSize: SizeConfig.defaultSize * 1.4),)
                    : Text(text, style: TextStyle(fontSize: SizeConfig.defaultSize * 1.4),),
        ],
      ),
    );
  }

  Widget _buildImg() {
    return AspectRatio(
        aspectRatio: 0.6,
        child: Image.file(
          File(widget.upload.imgSrc),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        )
    );
  }
}
