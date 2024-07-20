import 'package:flutter/material.dart';
import '../size_config.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final String? content;

  const TitleRow({required this.title, this.content, super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.defaultSize * 2,
          right: SizeConfig.defaultSize * 1.25,
          bottom: SizeConfig.defaultSize/2,
          top: SizeConfig.defaultSize/2),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.defaultSize * 2,
                  letterSpacing: 0.5,
                ),
              ),
              // Text(
              //   content ?? '',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //     fontSize: SizeConfig.defaultSize,
              //     letterSpacing: 0.5,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
