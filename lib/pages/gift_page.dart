import 'package:appy_app/pages/diary_page.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:appy_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class GiftPage extends StatefulWidget {
  final int characterId = 3; // 캐릭터 ID 전달
  final int characterLevel = 3; // 해당 캐릭터의 레벨
  const GiftPage({super.key});
  // const GiftPage({
  //   super.key
  //   // this.characterId = 1, // 기본값 레비
  //   // this.characterLevel = 5, // 테스트 레벨
  // });

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  String _getAppBarTitle(int characterId) {
    // 캐릭터 이름 반환
    switch (characterId) {
      case 1:
        return "래비의 선물함";
      case 2:
        return "누비의 선물함";
      case 3:
        return "밥이의 선물함";
      default:
        return "캐릭터의 선물함";
    }
  }

  String _getGiftImagePath(int characterId, int level) {
    // 이미지 경로 동적 생성
    return "assets/icons/gift/gift_${characterId}_${level}.png";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildBigAppBar(
        context,
        _getAppBarTitle(widget.characterId),
        "assets/icons/gift_box.png", // 아이콘은 동일
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Column(
            children: [
              const SizedBox(height: 41), // 앱바와 첫 줄 사이 거리
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 한 줄에 3개
                    crossAxisSpacing: 30, // 가로 간격
                    mainAxisSpacing: 42, // 세로 간격
                    childAspectRatio: 1, // 1:1 비율
                  ),
                  itemCount: 12, // 항상 12개의 아이템 슬롯을 렌더링
                  itemBuilder: (context, index) {
                    final level = index + 1; // 레벨 기준
                    if (level <= widget.characterLevel) {
                      // 잠금 해제된 아이템
                      return GestureDetector(
                        onTap: () {
                          _onUnlockedItemTap(level);
                        },
                        child: _buildUnlockedItem(
                          _getGiftImagePath(widget.characterId, level),
                        ),
                      );
                    } else {
                      // 잠금 상태 아이템
                      return _buildLockedItem();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 잠금 해제된 아이템 클릭 시 동작
  void _onUnlockedItemTap(int level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryPage(
          characterId: widget.characterId,
          itemLevel: level,
        ),
      ),
    );
  }

  // 잠금 해제된 아이템
  Widget _buildUnlockedItem(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.iconBackgroundRight,
        borderRadius: BorderRadius.circular(15), // 코너 15
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 2), // 그림자 위치
            blurRadius: 6, // 흐림 정도
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // 이미지에 추가적인 여백 설정
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // 잠금된 아이템
  Widget _buildLockedItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.iconBackgroundRight,
        borderRadius: BorderRadius.circular(15), // 코너 15
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 2), // 그림자 위치
            blurRadius: 6, // 흐림 정도
          ),
        ],
      ),
      child: const Center(
        child: Image(
          image: AssetImage("assets/icons/gift/gift_lock.png"), // 잠금 아이콘
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
