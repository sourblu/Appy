import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:appy_app/widgets/widget.dart';

// 처음 시작했을때 로그인, 회원가입 버튼 뜨는 창
class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildSettingAppBar(context, "사용자 설정"),
      body: SafeArea(
          child: Padding(
              padding: AppPadding.body,
              child: Column(children: [
                Container(
                  height: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.add_home_outlined,
                      size: IconSize.small,
                      color: AppColors.icon,
                    ),
                    Container(
                      width: 10,
                    ),
                    const Text(
                      "기기 등록",
                      style: TextStyle(
                        color: AppColors.textMedium,
                        fontSize: TextSize.medium,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Container(
                  color: AppColors.buttonDisabled,
                  height: 1,
                ),
              ]))),
    );
  }
}
