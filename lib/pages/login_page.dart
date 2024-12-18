import 'package:appy_app/pages/add_appy_page.dart';
import 'package:appy_app/pages/add_module_page.dart';
import 'package:appy_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:appy_app/widgets/widget.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:appy_app/pages/signup_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart'; // Provider 추가
import 'package:appy_app/providers/user_provider.dart'; // UserProvider 추가

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonActive = false; // 버튼 활성화 상태

  @override
  void initState() {
    super.initState();
    // 입력 필드 변화 감지
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonActive = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    // 키보드 내리기
    FocusScope.of(context).unfocus();

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    final loginUrl = Uri.parse("http://192.168.0.97:8083/api/users/login");
    final moduleCheckUrl =
        Uri.parse("http://192.168.0.97:8083/api/modules/check/$email");
    final appyCheckUrl = Uri.parse(
        "http://192.168.0.97:8083/api/character/user-rfids?userId=$email");
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "USER_ID": email,
      "USER_PW": password,
    });

    try {
      // 로그인 요청
      final loginResponse =
          await http.post(loginUrl, headers: headers, body: body);

      if (loginResponse.statusCode == 200) {
        // 로그인 성공
        print("로그인 성공: ${loginResponse.body}");
        // UserProvider를 사용해 로그인된 사용자 ID 저장
        Provider.of<UserProvider>(context, listen: false).setUserId(email);

        // 모듈 정보 확인
        final moduleResponse = await http.get(moduleCheckUrl, headers: headers);

        if (moduleResponse.statusCode == 200) {
          final moduleData = jsonDecode(utf8.decode(moduleResponse.bodyBytes));
          final bool hasModule = moduleData['hasModule'] ?? false;

          if (!hasModule) {
            // 모듈이 없다면 모듈 등록 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddModulePage()),
            );
            return;
          }

          // Appy 정보 확인
          final appyResponse = await http.get(appyCheckUrl, headers: headers);

          if (appyResponse.statusCode == 200) {
            final appyData =
                jsonDecode(utf8.decode(appyResponse.bodyBytes)) as List;
            final bool hasAppy = appyData.isNotEmpty;

            if (!hasAppy) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAppyPage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          } else {
            showCustomErrorDialog(
              context: context,
              message:
                  "Appy 확인 요청 중 문제가 발생했습니다. 상태 코드: ${appyResponse.statusCode}",
              buttonText: "확인",
              onConfirm: () {
                Navigator.of(context).pop();
              },
            );
          }
        } else {
          // 모듈 확인 실패 처리
          showCustomErrorDialog(
            context: context,
            message: "모듈 확인 중 오류가 발생했습니다.",
            buttonText: "확인",
            onConfirm: () {
              Navigator.of(context).pop();
            },
          );
        }
      } else if (loginResponse.statusCode == 400) {
        // 로그인 실패 처리
        final String errorMessage = utf8.decode(loginResponse.bodyBytes);
        showCustomErrorDialog(
          context: context,
          message: errorMessage,
          buttonText: "확인",
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        // 기타 에러 처리
        showCustomErrorDialog(
          context: context,
          message: "로그인 중 문제가 발생했습니다.",
          buttonText: "확인",
          onConfirm: () {
            Navigator.of(context).pop();
          },
        );
      }
    } catch (e) {
      // 네트워크 에러 처리
      showCustomErrorDialog(
        context: context,
        message: "서버와 연결할 수 없습니다. 인터넷 연결을 확인해주세요.",
        buttonText: "확인",
        onConfirm: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // 화면 높이를 기준으로 키보드 상태를 반영
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: BuildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "로그인",
                      style: TextStyle(
                        fontSize: TextSize.huge,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      width: 5,
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  height: keyboardVisible ? 75 : 300,
                ),
                // 이메일 입력
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.accent.withOpacity(0.16),
                    hintText: '이메일을 입력하세요',
                    hintStyle: const TextStyle(color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.accent),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.accent, width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // 비밀번호 입력
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.accent.withOpacity(0.16),
                    hintText: '비밀번호를 입력하세요',
                    hintStyle: const TextStyle(color: Colors.black),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.accent),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.accent, width: 2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // 로그인 버튼
                OutlinedButton(
                  onPressed: _isButtonActive ? _handleLogin : null,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: const Size(380, 50),
                    side: BorderSide(
                      color: _isButtonActive
                          ? AppColors.accent
                          : AppColors.buttonDisabled,
                    ),
                    foregroundColor: _isButtonActive
                        ? AppColors.textWhite // 활성화된 텍스트 색상
                        : AppColors.textWhite, // 비활성화된 텍스트 색상
                    backgroundColor: _isButtonActive
                        ? AppColors.accent // 활성화된 배경 색상
                        : AppColors.buttonDisabled, // 비활성화된 배경 색상
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TextSize.small,
                      fontFamily: "SUITE",
                    ),
                  ),
                  child: const Text("로그인"),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    // 회원가입 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "계정이 없으신가요? ",
                        style: TextStyle(
                            color: AppColors.textMedium,
                            fontSize: TextSize.small,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "회원가입",
                        style: TextStyle(
                            color: AppColors.textHigh,
                            fontSize: TextSize.small,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
