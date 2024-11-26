import 'package:appy_app/icon/custom_icon_icons.dart';
import 'package:appy_app/pages/add_appy_page.dart';
import 'package:appy_app/pages/add_module_page.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:appy_app/widgets/widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildSettingAppBar(context, "사용자 설정"),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.body,
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildSettingOptionWithDialog(
                context,
                icon: CustomIcon.fairy_wand,
                text: "Appy 등록",
                message: "Appy를 등록하시겠습니까?",
                confirmButtonText: "확인",
                onConfirm: () {
                  Navigator.of(context).pop(); // 팝업 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddAppyPage(), // AddModulePage로 이동
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildDivider(),
              const SizedBox(height: 20),
              _buildSettingOptionWithDialog(
                context,
                icon: Icons.add_home_outlined,
                text: "모듈 등록",
                message: "모듈을 등록하시겠습니까?",
                confirmButtonText: "확인",
                onConfirm: () {
                  Navigator.of(context).pop(); // 팝업 닫기
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddModulePage(), // AddModulePage로 이동
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildDivider(),
              const SizedBox(height: 20),
              _buildSettingOptionWithDialog(
                context,
                icon: Icons.logout_outlined,
                text: "로그아웃",
                message: "로그아웃 하시겠습니까?",
                confirmButtonText: "확인",
                onConfirm: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("로그아웃 완료.")),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildDivider(),
              const SizedBox(height: 20),
              _buildSettingOptionWithDialog(
                context,
                icon: Icons.waving_hand_sharp,
                text: "탈퇴하기",
                message: "정말 탈퇴하시겠습니까? \n 이 작업은 되돌릴 수 없습니다.",
                confirmButtonText: "탈퇴",
                onConfirm: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("탈퇴 완료.")),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  // 공통 옵션 위젯 + 다이얼로그 호출
  Widget _buildSettingOptionWithDialog(
    BuildContext context, {
    required IconData icon,
    required String text,
    required String message,
    required String confirmButtonText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    return GestureDetector(
      onTap: () {
        showCustomErrorDialog(
          context: context,
          message: message,
          buttonText: confirmButtonText,
          onConfirm: onConfirm,
          cancelButtonText: "취소",
          onCancel: onCancel ?? () => Navigator.of(context).pop(),
        );
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: IconSize.small,
            color: AppColors.icon,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.textMedium,
              fontSize: TextSize.medium,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: IconSize.medium,
            color: AppColors.icon,
          ),
        ],
      ),
    );
  }

  // 구분선 위젯
  Widget _buildDivider() {
    return Container(
      color: AppColors.buttonDisabled,
      height: 1,
    );
  }
}
