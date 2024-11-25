import 'dart:async';
import 'dart:math';

import 'package:appy_app/pages/chat_page.dart';
import 'package:appy_app/pages/gift_page.dart';
import 'package:appy_app/widgets/widget.dart';
import 'package:appy_app/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// home에서 에피 하나를 눌렀을때 에피와 상호작용할 수 있는 페이지
class AppyPage extends StatefulWidget {
  final String appyID; // Appy의 ID
  const AppyPage({
    required this.appyID, //이름 초기화
    super.key,
  });

  @override
  State<AppyPage> createState() => _AppyPageState();
}

class _AppyPageState extends State<AppyPage> {
  String appyName = "레비";

  // 말풍선 텍스트 리스트
  final List<String> texts = [
    "오늘은 무엇을 해볼까? 멋진 하루가 될 거야!",
    "힘들 땐 잠시 쉬어도 괜찮아. 넌 잘하고 있어!",
    "모든 순간을 즐겨봐. 넌 특별한 사람이야!",
    "오늘도 내 최고의 에피소드는 너랑 함께야!",
    "나랑 숨바꼭질 게임 해볼래? 시작한다!",
    "나도 가끔은 너랑 같이 출근하고 싶어!",
    "내가 항상 여기 있을게."
  ];

  final List<String> snackTexts = [
    "옴뇸뇸 맛있당",
    "고마워! 너도 하나 먹을래?",
    "내가 제일 좋아하는 맛이야!",
    "혹시 다른 맛은 없어...? 농담이야!",
    "사탕도 좋고 너도 좋아!"
  ];

  late String randomText;
  bool _isAnimating = true; // 애니메이션 상태 플래그
  bool _isNewChat = true;
  bool _isNewGift = false;
  String? lastText; // 랜덤 텍스트 선택 중복 방지용

  // 사탕 개수 초기화
  int currentCandyNum = 10;

  // 프로그레스 바 초기화
  int currentProgressNum = 5; // 현재 진행 상태
  final double maxSteps = 7; // 최대 단계 수

  @override
  void initState() {
    super.initState();
    _getRandomText(texts); // 초기화 시 랜덤 텍스트 설정
  }

  // 랜덤 텍스트 선택
  void _getRandomText(List<String> textList) {
    final random = Random();
    String newText;
    do {
      newText = textList[random.nextInt(textList.length)];
    } while (newText == lastText); // 이전 텍스트와 동일하면 다시 선택
    randomText = newText;
    lastText = newText;
  }

  // 프로그레스 바 단계별 증가
  void _feed() async {
    setState(() {
      currentCandyNum--;
      currentProgressNum += 1; // 단계별 증가

      // 말풍선 텍스트를 간식 텍스트 중 랜덤하게 선택
      _getRandomText(snackTexts);

      if (currentProgressNum >= maxSteps) {
        _showCompletionDialog(); // 최대값 도달 시 팝업 호출
        currentProgressNum = 0; // 진행 상태 초기화
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "축하합니다!",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: Text(
            "$appyName의 선물이 도착했습니다.\n선물함을 확인해주세요.",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: TextSize.small, fontWeight: FontWeight.w600),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
                setState(() {
                  _isNewGift = true;
                });
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.homeBackground,
        appBar: BuildAppBar(context),
        body: Stack(
          children: [
            //배경 색상 나누기
            Column(
              children: [
                Container(
                  height: 300,
                  color: Colors.transparent,
                ),
                Flexible(
                    child: Container(
                  color: AppColors.background,
                ))
              ],
            ),
            // 에피영역과 상호작용영역 나누기
            Column(
              children: [
                Stack(
                  children: [
                    //배경
                    Stack(
                      children: [
                        // 하단 그림자 영역
                        Positioned(
                          bottom: 0, // 하단에 위치
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 20, // 그림자가 적용될 영역 높이
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(30), // 왼쪽 하단 모서리 둥글게
                                bottomRight:
                                    Radius.circular(30), // 오른쪽 하단 모서리 둥글게
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5.0, // 그림자 흐림 정도
                                  spreadRadius: 1.0, // 그림자 확산 정도
                                  offset: const Offset(0, 2), // 그림자 방향
                                ),
                              ],
                            ),
                          ),
                        ),
                        // 이미지 하단 모서리 둥글게
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20), // 왼쪽 하단 모서리 둥글게
                            bottomRight: Radius.circular(20), // 오른쪽 하단 모서리 둥글게
                          ),
                          child: SizedBox(
                            height: 420,
                            child: Image.asset(
                              "assets/images/appy_background2.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 에피
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                        ),
                        //말풍선 영역
                        SizedBox(
                          height: 90,
                          child: SpeechBubble(
                              text: randomText,
                              onAnimationEnd: () {
                                setState(() {
                                  _isAnimating = false; //애니메이션 종료
                                });
                              }),
                        ),
                        Container(
                          height: 40,
                        ),
                        // 에피 영역
                        GestureDetector(
                          onTap: () {
                            if (!_isAnimating) {
                              setState(() {
                                _getRandomText(texts); //말풍선 클릭시 텍스트 변경
                                _isAnimating = true; // 애니메이션 시작
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 이전 에피로 이동 버튼
                              IconButton(
                                  onPressed: () {},
                                  icon: FaIcon(
                                    FontAwesomeIcons.caretLeft,
                                    size: IconSize.large,
                                    color:
                                        AppColors.background.withOpacity(0.8),
                                  )),
                              // 에피 이미지
                              Image.asset(
                                "assets/images/appy_levi.png",
                                height: 200,
                              ),
                              // 다음 에피로 이동 버튼
                              IconButton(
                                  onPressed: () {},
                                  icon: FaIcon(
                                    FontAwesomeIcons.caretRight,
                                    size: IconSize.large,
                                    color:
                                        AppColors.background.withOpacity(0.8),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  // 에피 이름 가져오기
                  child: Text(
                    appyName,
                    style: const TextStyle(
                      fontSize: TextSize.large,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //하단 상호작용 영역
                Stack(children: [
                  Stack(
                    clipBehavior: Clip.none, // Stack에서 그림자가 잘리지 않도록 설정
                    children: [
                      // 그림자 영역
                      Container(
                        height: 100, // 컨테이너 높이
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20), // 상단 왼쪽 둥글게
                            topRight: Radius.circular(20), // 상단 오른쪽 둥글게
                          ),
                          color: Colors.transparent, // 배경 투명
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 3.0, // 흐림 정도
                              spreadRadius: 1, // 확산 범위
                              offset: const Offset(0, -2), // 상단 방향으로 그림자 이동
                            ),
                          ],
                        ),
                      ),
                      // 메인 컨테이너 (하단 그림자 제거)
                      Container(
                        height: 200,
                        decoration: const BoxDecoration(
                          color: AppColors.background, // 하단 배경과 동일한 색상
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20), // 상단 왼쪽 둥글게
                            topRight: Radius.circular(20), // 상단 오른쪽 둥글게
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: AppPadding.body,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //프로그레스 바
                              LinearPercentIndicator(
                                backgroundColor: AppColors.iconBackground,
                                alignment: MainAxisAlignment.center,
                                width: 300.0,
                                animation: true,
                                animationDuration: 200,
                                animateFromLastPercent: true,
                                lineHeight: 30.0,
                                percent: currentProgressNum / maxSteps,
                                // center: Text('$currentProgressNum',
                                //     style: TextStyle(
                                //       color: AppColors.textWhite,
                                //     )),
                                barRadius: const Radius.circular(15.0),
                                progressColor: AppColors.accent,
                              ),
                              Image.asset(
                                "assets/icons/gift_box_question.png",
                                height: 45,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        if (currentCandyNum > 0) {
                                          _feed(); // 사탕 주기 로직 실행
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            duration: Duration(seconds: 1),
                                            backgroundColor: AppColors.primary,
                                            content: Center(
                                                child: Text("사탕이 없습니다!",
                                                    style: TextStyle(
                                                      color: AppColors.textHigh,
                                                      fontSize: TextSize.small,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ))),
                                          ));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(3.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        fixedSize: const Size(105, 130),
                                        // 텍스트 칼라
                                        foregroundColor: AppColors.textHigh,
                                        // 메인 칼라
                                        backgroundColor:
                                            AppColors.iconBackground,
                                        elevation: 7,
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: TextSize.small,
                                          fontFamily: "SUITE",
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icons/candy.png",
                                            width: 60,
                                          ),
                                          Container(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 105,
                                            child: const Center(
                                              child: Text(
                                                "사탕 주기",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //사탕 개수 표시
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Text(
                                        "$currentCandyNum개",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  width: 5,
                                ),
                                //대화하기 버튼
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isNewChat = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ChatPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(3.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    fixedSize: const Size(105, 130),
                                    // 텍스트 칼라
                                    foregroundColor: AppColors.textHigh,
                                    // 메인 칼라
                                    backgroundColor: AppColors.iconBackground,
                                    elevation: 7,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: TextSize.small,
                                      fontFamily: "SUITE",
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icons/chat.png",
                                            width: 60,
                                          ),
                                          Container(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 105,
                                            child: const Center(
                                              child: Text(
                                                "대화하기",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (_isNewChat)
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Image.asset(
                                            "assets/icons/exclamation.png",
                                            height: 30,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                Container(
                                  width: 5,
                                ),
                                //선물함 버튼

                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isNewGift = false;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const GiftPage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(3.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    fixedSize: const Size(105, 130),
                                    // 텍스트 칼라
                                    foregroundColor: AppColors.textHigh,
                                    // 메인 칼라
                                    backgroundColor: AppColors.iconBackground,
                                    elevation: 7,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: TextSize.small,
                                      fontFamily: "SUITE",
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icons/gift_box.png",
                                            width: 60,
                                          ),
                                          Container(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 105,
                                            child: const Center(
                                              child: Text(
                                                "선물함",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (_isNewGift)
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Image.asset(
                                            "assets/icons/exclamation.png",
                                            height: 30,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ]),
                        ],
                      )),
                ]),
              ],
            ),
          ],
        ));
  }
}

class SpeechBubble extends StatefulWidget {
  final String text;
  final Duration duration;
  final double maxWidth;
  final VoidCallback? onAnimationEnd;

  const SpeechBubble({
    required this.text,
    this.duration = const Duration(milliseconds: 70),
    this.maxWidth = 310,
    this.onAnimationEnd,
    super.key,
  });

  @override
  _SpeechBubbleState createState() => _SpeechBubbleState();
}

class _SpeechBubbleState extends State<SpeechBubble> {
  String displayedText = "";
  double bubbleWidth = 80;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(SpeechBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _resetTyping();
    }
  }

  void _startTyping() {
    _typingTimer?.cancel();
    setState(() {
      displayedText = "";
      bubbleWidth = 80;
    });

    int index = 0;
    _typingTimer = Timer.periodic(widget.duration, (timer) {
      if (index < widget.text.length) {
        setState(() {
          displayedText += widget.text[index++];
          bubbleWidth = (displayedText.length * 13.0 + 80)
              .clamp(80, widget.maxWidth); // 크기 조정
        });
      } else {
        timer.cancel();
        widget.onAnimationEnd?.call(); // 애니메이션 종료
      }
    });
  }

  void _resetTyping() {
    _startTyping();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      alignment: Alignment.center,
      width: bubbleWidth,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColors.iconShadow,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Text(
        displayedText,
        style: const TextStyle(
          color: AppColors.textHigh,
          fontSize: TextSize.small,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
