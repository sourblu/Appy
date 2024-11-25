import 'package:appy_app/widgets/theme.dart';
import 'package:appy_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class DiaryPage extends StatefulWidget {
  final int characterId; // 캐릭터 ID
  final int itemLevel; // 아이템 레벨

  const DiaryPage({
    super.key,
    required this.characterId,
    required this.itemLevel,
  });

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String _getDiaryTitle(int characterId) {
    // 캐릭터 ID에 따라 다이어리 제목 설정
    switch (characterId) {
      case 1:
        return "래비의 그림일기";
      case 2:
        return "누비의 그림일기";
      case 3:
        return "밥이의 그림일기";
      default:
        return "캐릭터의 그림일기";
    }
  }

  @override
  Widget build(BuildContext context) {
    // 선택된 캐릭터와 레벨에 따른 이미지 경로 생성
    final diaryImagePath =
        "assets/icons/diary/diary_${widget.characterId}_${widget.itemLevel}.png";

    return Scaffold(
      appBar: BuildBigAppBar(
        context,
        _getDiaryTitle(widget.characterId), // 동적 제목 설정
        "assets/icons/diary/diary.png",
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.body,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 가로 중앙 정렬
            children: [
              const SizedBox(height: 66), // 앱바와 이미지 간의 간격
              Align(
                alignment: Alignment.center, // 가로 방향 중앙 정렬
                child: _buildDiaryImage(diaryImagePath), // 이미지 위젯 생성
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 다이어리 이미지를 생성하는 메서드
  Widget _buildDiaryImage(String imagePath) {
    return FutureBuilder(
      future: _imageExists(imagePath), // 이미지 존재 여부 확인
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 로딩 표시
        } else if (snapshot.hasData && snapshot.data == true) {
          // 이미지가 존재할 경우
          return Image.asset(
            imagePath,
            fit: BoxFit.contain, // 이미지 크기 조정
          );
        } else {
          // 이미지가 없을 경우 텍스트 표시
          return Text(
            "캐릭터 ${widget.characterId} - 아이템 ${widget.itemLevel}\n이미지가 없습니다.",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: TextSize.medium,
              color: AppColors.textMedium,
            ),
          );
        }
      },
    );
  }

  // 이미지 존재 여부 확인 메서드
  Future<bool> _imageExists(String path) async {
    try {
      // Flutter의 asset manifest를 이용하여 이미지 존재 여부 확인
      final assetBundle = DefaultAssetBundle.of(context);
      final manifest = await assetBundle.loadString('AssetManifest.json');
      return manifest.contains(path);
    } catch (e) {
      return false; // 에러 발생 시 false 반환
    }
  }
}
