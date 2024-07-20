import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/upload_card.dart';
import '../components/title_row.dart';
import '../models/upload.dart';
import '../models/providers.dart';
import '../size_config.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late List<Upload> _currentUploads;
  int categoryIndex = 0;
  AnimationController? animationController;
  late ScrollController _scrollController;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _scrollController = ScrollController();
    Provider.of<UploadsProvider>(context, listen: false).addListener(() {
      if (Provider.of<UploadsProvider>(context, listen: false).justAdded) {
        _scrollToEnd();
        Provider.of<UploadsProvider>(context, listen: false).clearJustAdded();  // Reset the flag
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadsProvider>(
        builder: (context, uploadProvider, child) {
          _currentUploads = uploadProvider.uploads;
          return CustomScrollView(
            controller: _scrollController,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            slivers: [
              const SliverToBoxAdapter(
                child: TitleRow(title: "Your uploads"),
              ),
              _currentUploads.isEmpty
                  ? SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (Provider.of<ThemeProvider>(context).isLightMode)
                          ? Image.asset('assets/images/logo-lightmode.png', height: SizeConfig.defaultSize * 20,)
                          : Image.asset('assets/images/logo-darkmode.png', height: SizeConfig.defaultSize * 20,),
                      SizedBox(height: SizeConfig.defaultSize * 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Click ', style: Theme.of(context).textTheme.titleMedium,),
                          const Icon(Icons.add),
                          Text(' to start uploading', style: Theme.of(context).textTheme.titleMedium,),
                        ],
                      ),
                    ],
                  )
              )
                  : SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController!,
                        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController?.forward();
                    return UploadCard(
                      globalUploads: _currentUploads,
                      uploadIndex: index,
                      animation: animation,
                      animationController: animationController!,
                    );
                  },
                  childCount: _currentUploads.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  mainAxisSpacing: SizeConfig.defaultSize,
                  crossAxisSpacing: SizeConfig.orientation == Orientation.landscape ? SizeConfig.defaultSize : 0,
                  childAspectRatio: 1.7,
                ),
              ),
            ],
          );
        }
    );
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
