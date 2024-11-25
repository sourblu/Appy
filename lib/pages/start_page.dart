import 'package:appy_app/pages/login_page.dart';
import 'package:appy_app/pages/signup_page.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';

// 처음 시작했을때 로그인, 회원가입 버튼 뜨는 창
class StartPage extends StatelessWidget {
  const StartPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.accent,
        body: SafeArea(
            child: Padding(
                padding: AppPadding.body,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Appy",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        height: 300,
                      ),
                      GestureDetector(
                        onTap: () {
                          // 페이지 이동
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        child: _buildStartButton(
                            "로그인", AppColors.background, AppColors.textHigh),
                      ),
                      Container(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          // 페이지 이동
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: _buildStartButton(
                            "회원가입", AppColors.background, AppColors.textHigh),
                      ),
                    ]))));
  }
}

Container _buildStartButton(
    String buttonName, Color buttonColor, Color textColor) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.center,
    child: Text(
      buttonName,
      style: TextStyle(
        color: textColor,
        fontSize: TextSize.medium,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
