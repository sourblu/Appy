import 'package:appy_app/pages/add_appy_page.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:appy_app/widgets/widget.dart';

class AddModulePage extends StatefulWidget {
  const AddModulePage({
    super.key,
  });

  @override
  State<AddModulePage> createState() => _AddModulePageState();
}

class _AddModulePageState extends State<AddModulePage> {
  @override
  void initState() {
    super.initState();

    // 1초 후에 다음 페이지로 이동 (임시)
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddAppyPage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildSettingAppBar(context, "모듈 등록"),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.body,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
              ),
              const Text(
                "모듈의 QR코드를 인식해주세요",
                style: TextStyle(
                  color: AppColors.textHigh,
                  fontSize: TextSize.medium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                height: 50,
              ),
              // QR 코드 카메라 촬영 기능
              Container(
                color: AppColors.buttonDisabled,
                width: 230,
                height: 230,
              )
            ],
          ),
        ),
      ),
    );
  }
}
