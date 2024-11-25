import 'package:appy_app/pages/add_module_page.dart';
import 'package:appy_app/widgets/widget.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BuildAppBar(context),
        body: SafeArea(
            child: Padding(
                padding: AppPadding.body,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "회원가입",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: 5,
                          ),
                        ],
                      ),
                      Container(
                        height: 300,
                      ),
                      // 이메일 입력
                      //
                      // 비밀번호 입력
                      //
                      GestureDetector(
                        onTap: () {
                          // 로그인 처리 api
                          //

                          // 페이지 이동
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddModulePage()));
                        },
                        // 모두 입력했을 때만 회원가입 버튼 활성화하기
                        //
                        child: BuildButton(
                            "회원가입", AppColors.accent, AppColors.textWhite),
                      ),
                    ]))));
  }
}
