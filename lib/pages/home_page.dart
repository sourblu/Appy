import 'package:appy_app/pages/appy_page.dart';
import 'package:appy_app/pages/module_map_page.dart';
import 'package:appy_app/pages/setting_page.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';

//에피 모여있는 페이지
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        appBar: _buildHomeAppBar(context),
        body: Stack(
          children: [
            SizedBox(
              height: 812, //아이폰 미니 높이
              child: SizedBox.expand(
                child: Image.asset(
                  "assets/images/background.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(height: 300),
                //등록된 에피 불러와서 이미지로 모두 표시하기
                //각 이미지에 해당하는 에피 아이디 연결
                GestureDetector(
                  onTap: () {
                    // 페이지 이동
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AppyPage(appyID: "001")));
                  },
                  child: Image.asset(
                    "assets/images/appy_levi.png",
                    width: 100,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // 페이지 이동
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppyPage(
                                  appyID: "002",
                                )));
                  },
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

AppBar _buildHomeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    toolbarHeight: 70,
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ModuleMapPage()));
        },
        icon: const Icon(
          Icons.map,
          size: IconSize.medium,
          color: AppColors.icon,
        )),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingPage()));
          },
          icon: const Icon(
            Icons.settings,
            size: IconSize.medium,
            color: AppColors.icon,
          ))
    ],
  );
}
