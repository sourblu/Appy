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





Container buildButton(String buttonName, Color buttonColor) {
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
            style: const TextStyle(
              color: AppColors.textWhite,
              fontSize: TextSize.small,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
}



AppBar buildAppBar(BuildContext context) {
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
          )
      ),
    );
  }





AppBar buildSettingAppBar(BuildContext context, String title) {
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
          )
      ),
      title:
        Text(
          title,
          style: const TextStyle(
            fontSize: TextSize.medium,
            fontWeight: FontWeight.w700,
          ),
      ),
    );
  }
