import 'package:flutter/material.dart';
import '../components/report_upload.dart';
import '../components/report_summary.dart';
import '../components/title_row.dart';
import '../components/top_numbers.dart';
import '../models/upload.dart';
import '../size_config.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with AutomaticKeepAliveClientMixin<ReportScreen> {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: [
          SizedBox(height: SizeConfig.defaultSize * 2,),
          const TopNumbers(),
          SizedBox(height: SizeConfig.defaultSize * 2,),
          const TitleRow(title: 'MobileViT_V2_175'),
          SizedBox(height: SizeConfig.defaultSize * 2,),
          const ReportSummary(), // average classification across all classes
          SizedBox(height: SizeConfig.defaultSize * 2,),
          const TitleRow(title: 'Classes'),
          SizedBox(height: SizeConfig.defaultSize * 2,),
          _buildMeals(),
        ],
      ),
    );
  }

  Widget _buildMeals() {
    return Container(
      height: SizeConfig.defaultSize * 34,
      alignment: AlignmentDirectional.centerEnd,
      child: ListView.builder(
          itemCount: uploadClasses.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            return ReportUpload(upload: uploadClasses[index]);
          }
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
