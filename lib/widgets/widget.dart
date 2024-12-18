import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';

// 일단 로그인 버튼에는 ElevatedButton 사용안함
// class buildElevatedButton extends StatelessWidget {
//   const buildElevatedButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         Navigator.push(context,
//           MaterialPageRoute(builder: (context) => const AddAppyPage()));
//       },
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8)
//         ),
//         fixedSize: const Size(330, 50),
//         // 텍스트 칼라
//         foregroundColor: AppColors.textWhite,
//         // 메인 칼라
//         backgroundColor: AppColors.accent,
//         elevation: 3,
//         textStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: TextSize.small,
//           fontFamily: "SUITE",
//         ),
//       ),
//       child: Text(
//             "로그인",
//             ),
//       );
//     }
// }

Container BuildButton(String buttonName, Color buttonColor, Color textColor) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(5),
    ),
    alignment: Alignment.center,
    child: Text(
      buttonName,
      style: TextStyle(
        color: textColor,
        fontSize: TextSize.small,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

AppBar BuildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    toolbarHeight: 70,
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context); //이전 페이지로 돌아가기
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: IconSize.medium,
          color: AppColors.icon,
        )),
  );
}




AppBar BuildSettingAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: AppColors.primary,
    toolbarHeight: 70,
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context); //이전 페이지로 돌아가기
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: IconSize.medium,
          color: AppColors.icon,
        )),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: TextSize.medium,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

AppBar BuildBigAppBar(BuildContext context, String title, String imagePath) {
  return AppBar(
    backgroundColor: AppColors.primary,
    toolbarHeight: 140,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: AppColors.primary, // AppBar 배경색
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10), // 하단 둥근 처리
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0C0C0D).withOpacity(0.03), // 그림자 색상
            offset: const Offset(0, 3), // 그림자 위치
            blurRadius: 4, // 흐림 정도
            spreadRadius: 0, // 확산 정도
          ),
        ],
      ),
    ),
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context); //이전 페이지로 돌아가기
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: IconSize.medium,
          color: AppColors.icon,
        )),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: TextSize.large,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}




void showCustomErrorDialog({
  required BuildContext context,
  required String message,
  required String buttonText,
  VoidCallback? onConfirm, // 확인 버튼 이벤트
  String? cancelButtonText, // 취소 버튼 텍스트
  VoidCallback? onCancel, // 취소 버튼 이벤트
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: AppColors.background,
        contentPadding: const EdgeInsets.all(10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 35),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: TextSize.small,
                fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
          ],
        ),
        actions: [
          // 취소 버튼 추가
          if (cancelButtonText != null)
            TextButton(
              onPressed: onCancel ??
                  () {
                    Navigator.of(context).pop(); // 기본 동작: 팝업 닫기
                  },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                textStyle: const TextStyle(
                  fontSize: TextSize.small,
                  fontWeight: FontWeight.w700
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                minimumSize: const Size(100, 30),
              ),
              child: Text(cancelButtonText),
            ),
          // 확인 버튼
          TextButton(
            onPressed: onConfirm ??
                () {
                  Navigator.of(context).pop(); // 기본 동작: 팝업 닫기
                },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.accent,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontFamily: "SUITE",
                fontSize: TextSize.small,
                fontWeight: FontWeight.w700
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              minimumSize: const Size(100, 30),
            ),
            child: Text(buttonText),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}

// Container BuildInteractionButton(String buttonName) {
//   return Container(
//           width: 100,
//           height: 120,
//           decoration: BoxDecoration(
//             color: AppColors.iconBackground,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             buttonName,
//             style: const TextStyle(
//               color: AppColors.textHigh,
//               fontSize: TextSize.tiny,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         );
// }


