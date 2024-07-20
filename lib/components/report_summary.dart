import 'package:flutter/material.dart';
import '../models/statistics.dart';
import '../size_config.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../models/providers.dart';

class ReportSummary extends StatefulWidget {
  const ReportSummary({super.key});

  @override
  State<ReportSummary> createState() => _ReportSummaryState();
}

class _ReportSummaryState extends State<ReportSummary> {
  late String _avgAccuracy;
  late String _avgConfidence;
  late String _avgInferenceTime;
  late String _avgF1;

  @override
  Widget build(BuildContext context) {

    return Consumer<UploadsProvider>(
        builder: (context, uploadProvider, child) {
          if (uploadProvider.uploads.isEmpty) {
            _avgAccuracy = '0';
            _avgConfidence = '0';
            _avgInferenceTime = '0';
            _avgF1 = '0';
          } else {
            _avgAccuracy = avgAccuracy(uploadProvider.uploads);
            _avgConfidence = avgConfidence(uploadProvider.uploads);
            _avgInferenceTime = avgInferenceTime(uploadProvider.uploads);
            _avgF1 = avgF1Score(uploadProvider.uploads);
          }
          return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize, horizontal: SizeConfig.defaultSize * 2.5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 24.0,
                          color: Theme.of(context).hintColor,
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topRight: Radius.circular(68.0)
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize / 2, vertical: SizeConfig.defaultSize * 1.5,),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildTopInfo('Quantization', Icons.numbers_rounded, 'Float-16'),
                                _buildTopInfo('Size', Icons.sd_storage, '27.4 MB'),
                                _buildTopInfo('Inference Time', Icons.timelapse_rounded, '$_avgInferenceTime ms'),
                              ],
                            ),
                            _buildBigCircle(),
                          ],
                        ),
                        _buildDivider(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            _buildSmallCircle('Overall\nConfidence', _avgConfidence),
                            _buildSmallCircle('Overall\nAccuracy', _avgAccuracy),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          );
        }
    );
  }

  Widget _buildTopInfo(String text, IconData icon, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: SizeConfig.defaultSize * 3.8,
          width: SizeConfig.defaultSize / 5,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(SizeConfig.defaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: SizeConfig.defaultSize/4),
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.defaultSize * 1.4,
                    letterSpacing: -0.1,
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(icon, size: SizeConfig.defaultSize * 1.7, color: Theme.of(context).colorScheme.onTertiaryContainer,),
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.defaultSize/1.5),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.defaultSize * 1.2,
                        color: Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBigCircle() {
    return Center(
      child: CircularPercentIndicator(
        animateFromLastPercent: true,
        animation: true,
        radius: SizeConfig.defaultSize * 7,
        lineWidth: SizeConfig.defaultSize / 1.65,
        percent: double.parse(_avgAccuracy)/100,
        center: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_avgF1%',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.5,
                  letterSpacing: 0.0,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize/2,),
              Text(
                'Overall\nF1-Score',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 1.35,
                  letterSpacing: 0.0,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
        ),
        progressColor: Theme.of(context).colorScheme.onTertiaryContainer,
        backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.2),
        circularStrokeCap: CircularStrokeCap.round,
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize, vertical: SizeConfig.defaultSize * 2),
      child: Container(
        height: SizeConfig.defaultSize / 8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onTertiaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildSmallCircle(String text, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          animateFromLastPercent: true,
          animation: true,
          radius: SizeConfig.defaultSize * 3.25,
          lineWidth: SizeConfig.defaultSize / 4,
          percent: double.parse(value)/100,
          center: Center(
            child: Text(
              '$value%',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SizeConfig.defaultSize * 1.6,
                letterSpacing: -0.2,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
          ),
          progressColor: Theme.of(context).colorScheme.onTertiaryContainer,
          backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.2),
          circularStrokeCap: CircularStrokeCap.round,
        ),
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.defaultSize),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SizeConfig.defaultSize * 1.3,
              letterSpacing: -0.2,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}