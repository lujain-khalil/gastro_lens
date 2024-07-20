import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/upload.dart';
import '../models/providers.dart';
import '../size_config.dart';
import '../views/trigger_dialogs.dart';

class BuildAppBar extends StatefulWidget implements PreferredSizeWidget {

  const BuildAppBar({super.key});

  @override
  State<BuildAppBar> createState() => _BuildAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BuildAppBarState extends State<BuildAppBar> {

  @override
  Widget build(BuildContext context) {

    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0,
      title: (Provider.of<ThemeProvider>(context).isLightMode)
          ? Image.asset('assets/images/logo-name-lightmode.png', height: SizeConfig.defaultSize * 10,)
          : Image.asset('assets/images/logo-name-darkmode.png',  height: SizeConfig.defaultSize * 10,),
      centerTitle: true,
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.add),
            offset: Offset(0, widget.preferredSize.height / 1.25),
            tooltip: 'Upload image',
            onSelected: (value) async {
              Upload? result;
              late String message;
              if (value == "gallery") {
                result = await showDialog<Upload?>(
                  context: context,
                  builder: (BuildContext context) => TriggerDialogs(),
                );
                if (result != null) {
                  Provider.of<UploadsProvider>(context, listen: false).addUpload(result);
                  message = "Image added successfully";
                } else {
                  message = "No image added";
                }
              } else if (value == "simulate") {
                Provider.of<UploadsProvider>(context, listen: false).simulateUploads();
                message = "Images simulated successfully";
              }
              else if (value == "delete") {
                Provider.of<UploadsProvider>(context, listen: false).clearUploads();
                message = "Uploads cleared";
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry> [
              const PopupMenuItem(
                value: "gallery",
                child: ListTile(
                  leading: Icon(Icons.upload_rounded),
                  title: Text("Upload"),
                ),
              ),const PopupMenuItem(
                value: "simulate",
                child: ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Simulate"),
                ),
              ),
              const PopupMenuItem(
                  value: "delete",
                  child: ListTile(
                    leading: Icon(Icons.delete_outline_rounded),
                    title: Text("Clear"),
                  )
              ),
            ]
        ),
      ],
    );
  }

}
