import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';

class ModuleMapPage extends StatelessWidget {
  const ModuleMapPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        appBar: _buildModuleMapAppBar(context),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                ),
                SizedBox(
                  height: 500,
                  child: SizedBox.expand(
                    child: Image.asset(
                      "assets/images/module_map_background.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 330),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/appy_levi.png",
                    width: 100,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

AppBar _buildModuleMapAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    toolbarHeight: 70,
    centerTitle: true,
    title: const Text(
      "모듈맵",
      style: TextStyle(
          fontSize: TextSize.medium, fontWeight: FontWeight.w700),
    ),
    leading: Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: IconSize.medium,
              color: AppColors.icon,
            )),
      ],
    ),
  );
}
