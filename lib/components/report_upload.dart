import 'package:flutter/material.dart';
import '../models/upload.dart';
import '../models/statistics.dart';
import '../size_config.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../models/providers.dart';

class ReportUpload extends StatefulWidget {
  final Upload upload;
  const ReportUpload({required this.upload, super.key});

  @override
  State<ReportUpload> createState() => _ReportUploadState();
}

class _ReportUploadState extends State<ReportUpload> {
  late int _count;
  late String _avgConfidence;
  late String _avgAccuracy;
  late String _avgF1;
  late String _avgInferenceTime;

  @override
  Widget build(BuildContext context) {

    return Consumer<UploadsProvider>(
        builder: (context, uploadProvider, child) {
          _count = countByClass(uploadProvider.uploads, widget.upload.id);
          if (_count == 0) {
            _avgAccuracy = '0';
            _avgF1 = '0';
            _avgConfidence = '0';
            _avgInferenceTime = '0';
          } else {
            _avgAccuracy = avgAccuracyByClass(uploadProvider.uploads, widget.upload.id);
            _avgF1 = avgF1ScoreByClass(uploadProvider.uploads, widget.upload.id);
            _avgConfidence = avgConfidenceByClass(uploadProvider.uploads, widget.upload.id);
            _avgInferenceTime = avgInferenceTimeByClass(uploadProvider.uploads, widget.upload.id);
          }

          return Container(
            padding: EdgeInsets.only(bottom: SizeConfig.defaultSize,right: SizeConfig.defaultSize, left: SizeConfig.defaultSize),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.defaultSize * 2.5, top: SizeConfig.defaultSize * 2.5),
                  child: Container(
                    width: SizeConfig.defaultSize * 22,
                    decoration: BoxDecoration(
                      boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 5.0,),],
                      color: Theme.of(context).colorScheme.surfaceTint,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(54.0),
                      ),
                    ),
                    padding: EdgeInsets.only(
                        top: SizeConfig.defaultSize * 5,
                        left: SizeConfig.defaultSize * 1.5,
                        right: SizeConfig.defaultSize / 1.5,
                        bottom: SizeConfig.defaultSize / 1.5
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildTitle(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildIconInfo(Icons.upload, '$_count ${(_count == 1) ? 'Upload' : 'Uploads'}'),
                                _buildDivider(),
                                _buildIconInfo(Icons.timelapse_rounded, '$_avgInferenceTime ms'),
                                _buildIconInfo(Icons.model_training_rounded, '$_avgConfidence% Confidence'),
                                _buildIconInfo(Icons.done, '$_avgAccuracy% Accuracy'),
                              ],
                            ),
                          ),
                        ),
                        _buildF1(),
                      ],
                    ),
                  ),
                ),
                _buildImg(context)
              ],
            ),
          );
        }
    );
  }


  Widget _buildTitle() {
    return SizedBox(
      height: SizeConfig.defaultSize * 5,
      child: Text(
        widget.upload.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.defaultSize * 1.75,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.defaultSize/2),
      child: Row(
        children: [
          Icon(icon, size: SizeConfig.defaultSize * 1.5,),
          Text(' $text', style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(
          bottom: SizeConfig.defaultSize,
          top: SizeConfig.defaultSize/2,
          right: SizeConfig.defaultSize * 8,
      ),
      child: Container(
        height: SizeConfig.defaultSize / 8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildF1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          _avgF1,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.defaultSize * 2.5,
            letterSpacing: 0.2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.defaultSize/2, bottom: SizeConfig.defaultSize/1.5),
          child: Text(
            '% F1-Score',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.defaultSize,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImg(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(SizeConfig.defaultSize * 3.25),
                child: Image.asset(widget.upload.imgSrc, fit: BoxFit.cover),
              ),
            ),
            CircularPercentIndicator(
              percent: double.parse(_avgAccuracy)/100,
              radius: (SizeConfig.defaultSize * 3.25) + 2,
              animateFromLastPercent: true,
              animation: true,
              backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.2),
              progressColor: Theme.of(context).colorScheme.onSurfaceVariant,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ]
      ),
    );
  }

}
