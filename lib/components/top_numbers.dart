import 'package:flutter/material.dart';
import 'package:gastro_lens/models/statistics.dart';
import 'package:provider/provider.dart';
import '../models/providers.dart';
import '../size_config.dart';

class TopNumbers extends StatefulWidget {
  const TopNumbers({super.key});

  @override
  State<TopNumbers> createState() => _TopNumbersState();
}

class _TopNumbersState extends State<TopNumbers> {
  late int _uploadCount;
  late int _diseaseCount;

  @override
  Widget build(BuildContext context) {

    return Consumer<UploadsProvider>(
        builder: (context, uploadProvider, child) {
          if (uploadProvider.uploads.isEmpty) {
            _uploadCount = 0;
            _diseaseCount = 0;
          } else {
            _uploadCount = uploadProvider.uploads.length;
            _diseaseCount = uploadProvider.uploads.length - countByClass(uploadProvider.uploads, 5);
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfo('Total\nUploads', _uploadCount),
                _buildInfo('Diseases\nDetected', _diseaseCount),
              ],
            ),
          );
        }
    );
  }

  Column _buildInfo(String text, dynamic value) {
    return Column(
      children: [
        CircleAvatar(
          radius: SizeConfig.defaultSize * 2.5,
          child: Text(
            '$value',
            style: TextStyle(fontSize: SizeConfig.defaultSize * 1.8, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
