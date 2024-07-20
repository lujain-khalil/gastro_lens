import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/providers.dart';
import '../size_config.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          _buildInfo(
            context,
            Provider.of<ThemeProvider>(context).isLightMode
                ? "assets/images/logo-lightmode.png"
                : "assets/images/logo-darkmode.png",
            "John Doe",
            "john.doe@gmail.com",
          ),
          SizedBox(height: SizeConfig.defaultSize * 2),
          _buildTiles(context),
        ],
      ),
    );
  }
}

Widget _buildInfo (BuildContext context, String imgSrc, String name, String email) {
  return SizedBox(
    height: SizeConfig.defaultSize * 24,
    child: Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: SizeConfig.defaultSize * 15,
            color: Theme.of(context).colorScheme.surfaceTint,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: SizeConfig.defaultSize),
                height: SizeConfig.defaultSize * 14,
                width: SizeConfig.defaultSize * 14,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage(imgSrc),
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: SizeConfig.defaultSize * 2.2, // 22
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize / 2 ), //5
              Text(email,)
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTiles(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);

  return Expanded(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.bookmark_border_rounded),
              title: const Text('Saved Uploads'),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.workspace_premium_rounded, color: Theme.of(context).colorScheme.tertiary,),
              title: const Text('Premium Plan'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: const Text('Change Language'),
              onTap: () {},
            ),
            ListTile(
              leading: (themeProvider.isLightMode) ? const Icon(Icons.dark_mode_outlined) : const Icon(Icons.light_mode_outlined),
              title: (themeProvider.isLightMode) ? const Text('Toggle Dark Mode') : const Text('Toggle Light Mode'),
              onTap: () {
                themeProvider.toggleMode();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About GastroLens'),
              onTap: () {},
            ),
            const Spacer(),
            const Divider(
              height: 10,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      );
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({super.key});

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Center(
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          isSwitched = value;
          themeProvider.toggleMode();
        },
        // activeTrackColor: Theme.of(context).colorScheme.surfaceVariant,
        // activeColor: Colors.green,
        autofocus: false,
      ),
    );
  }
}