import 'package:appy_app/widgets/theme.dart';
import 'package:appy_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  // 메세지 임시용
  final List<Map<String, String>> messages = [
    {"text": "드림아, 오늘 기분 어때?", "time": "2024-11-25 09:00:00", "type": "user"},
    {"text": "좋아! 너는?", "time": "2024-11-25 09:01:00", "type": "system"},
    {
      "text": "나도 괜찮아. 아침에 커피 마셨어?",
      "time": "2024-11-25 09:02:00",
      "type": "user"
    },
    {
      "text": "응! 오늘은 아메리카노로 시작했어.",
      "time": "2024-11-25 09:03:00",
      "type": "system"
    },
    {
      "text": "좋다~ 나도 아메리카노 마셔야겠다.",
      "time": "2024-11-25 09:04:00",
      "type": "user"
    },
    {
      "text": "좋아, 커피는 꼭 마셔야지! 계획은 뭐야?",
      "time": "2024-11-25 09:05:00",
      "type": "system"
    },
    {
      "text": "오늘은 프로젝트 마감 준비해야 해. 너는?",
      "time": "2024-11-25 09:06:00",
      "type": "user"
    },
    {
      "text": "나는 AI 학습 데이터 업데이트할 예정이야.",
      "time": "2024-11-25 09:07:00",
      "type": "system"
    },
    {"text": "좋다! 도움 필요하면 말해줘.", "time": "2024-11-25 09:08:00", "type": "user"},
    {
      "text": "고마워! 너도 필요하면 언제든 얘기해~",
      "time": "2024-11-25 09:09:00",
      "type": "system"
    },
    {
      "text": "내일 날씨 알아? 비 온다던데.",
      "time": "2024-11-25 09:10:00",
      "type": "user"
    },
    {
      "text": "맞아. 우산 챙겨야 할 것 같아.",
      "time": "2024-11-25 09:11:00",
      "type": "system"
    },
    {
      "text": "알려줘서 고마워! 잊지 않을게. 알려줘서 고마워! 잊지 않을게. 알려줘서 고마워! 잊지 않을게.",
      "time": "2024-11-25 09:12:00",
      "type": "user"
    },
    {
      "text": "천만에~ 오늘 하루도 파이팅! 천만에~ 오늘 하루도 파이팅! 천만에~ 오늘 하루도 파이팅!",
      "time": "2024-11-25 09:13:00",
      "type": "system"
    },
    {"text": "고마워, 너도 파이팅!", "time": "2024-11-25 09:14:00", "type": "user"},

    // 11월 26일 대화 추가
    {"text": "드림아, 어제 잘 잤어?", "time": "2024-11-26 08:30:00", "type": "user"},
    {
      "text": "응, 아주 푹 잤어. 너는?",
      "time": "2024-11-26 08:31:00",
      "type": "system"
    },
    {
      "text": "나도 잘 잤어! 아침에 운동 갔다 왔어.",
      "time": "2024-11-26 08:32:00",
      "type": "user"
    },
    {"text": "멋지다! 무슨 운동 했어?", "time": "2024-11-26 08:33:00", "type": "system"},
    {
      "text": "조깅 30분 정도 했어. 기분 좋더라.",
      "time": "2024-11-26 08:34:00",
      "type": "user"
    },
    {
      "text": "좋아 보인다. 나도 다음엔 해볼까?",
      "time": "2024-11-26 08:35:00",
      "type": "system"
    },
    {
      "text": "그래! 같이 하면 더 좋을 것 같아.",
      "time": "2024-11-26 08:36:00",
      "type": "user"
    },
    {"text": "내일 아침 같이 해볼래?", "time": "2024-11-26 08:37:00", "type": "system"},
    {"text": "좋아! 시간 맞춰볼게.", "time": "2024-11-26 08:38:00", "type": "user"},
    {
      "text": "알았어. 준비 잘 하고 파이팅!",
      "time": "2024-11-26 08:39:00",
      "type": "system"
    },
  ];

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // 각 메시지의 높이를 저장
  final Map<int, double> _messageHeights = {};
  final Map<int, double> _cumulativeOffsets = {};

  // 검색 상태 관리
  bool _isSearchMode = false;
  // 검색 키워드 관리 뿌이....
  String _searchQuery = "";
  int _currentHighlightedIndex = 0;
  List<int> _highlightedMessageIndices = [];

  void _measureMessageHeight(int index, double height) {
    setState(() {
      _messageHeights[index] = height;

      // 누적 오프셋 계산
      double offset = 0.0;
      for (int i = 0; i <= index; i++) {
        offset += _messageHeights[i] ?? 50.0; // 기본 높이 50
      }
      _cumulativeOffsets[index] = offset;
    });
  }

  void _searchMessages(String query) {
    setState(() {
      _searchQuery = query;
      _highlightedMessageIndices = [];
      _currentHighlightedIndex = 0;

      // 검색 키워드를 포함한 메시지 인덱스 수집
      for (int i = 0; i < messages.length; i++) {
        if (messages[i]["text"]!.toLowerCase().contains(query.toLowerCase())) {
          _highlightedMessageIndices.add(i);
        }
      }
    });

    // 검색된 메시지가 있다면 첫 번째로 이동
    if (_highlightedMessageIndices.isNotEmpty) {
      _scrollToMessage(_highlightedMessageIndices[_currentHighlightedIndex]);
    }
  }

  void _scrollToMessage(int index) {
    if (_scrollController.hasClients) {
      // 해당 메시지로 스크롤 이동
      _scrollController.animateTo(
        index * 70.0, // 메시지 하나의 예상 높이 (필요에 따라 조정)
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _moveToNextHighlight() {
    if (_highlightedMessageIndices.isNotEmpty) {
      setState(() {
        _currentHighlightedIndex =
            (_currentHighlightedIndex + 1) % _highlightedMessageIndices.length;
      });
      _scrollToMessage(_highlightedMessageIndices[_currentHighlightedIndex]);
    }
  }

  void _moveToPreviousHighlight() {
    if (_highlightedMessageIndices.isNotEmpty) {
      setState(() {
        _currentHighlightedIndex =
            (_currentHighlightedIndex - 1 + _highlightedMessageIndices.length) %
                _highlightedMessageIndices.length;
      });
      _scrollToMessage(_highlightedMessageIndices[_currentHighlightedIndex]);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko', null);

    // 키보드 이벤트 감지를 위해 Observer 등록
    WidgetsBinding.instance.addObserver(this);

    // 페이지가 처음 로드될 때 맨 아래로 스크롤
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Observer 해제
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    // 키보드 상태 변화 확인
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0.0) {
      // 키보드가 열릴 때 스크롤 하단으로 이동
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      resizeToAvoidBottomInset: true, // 키보드 열릴 때 레이아웃 조정
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _groupMessagesByDate(messages).length,
              itemBuilder: (context, index) {
                final date =
                    _groupMessagesByDate(messages).keys.toList()[index];
                final dayMessages = _groupMessagesByDate(messages)[date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateLabel(date),
                    ...dayMessages.map((message) {
                      return _buildChatBubble(message["text"]!,
                          message["time"]!, message["type"] == "user", index);
                    }).toList(),
                  ],
                );
              },
            ),
          ),
          _buildChatInput(), // 입력창 추가
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    if (_isSearchMode) {
      return AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 70,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.search, color: AppColors.icon),
          onPressed: () {
            setState(() {
              _isSearchMode = false;
              _searchQuery = "";
            });
          },
        ),
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: "메시지 검색",
            hintStyle: TextStyle(color: AppColors.textMedium),
            border: InputBorder.none,
          ),
          style: TextStyle(color: AppColors.textHigh),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_upward),
            onPressed: _moveToPreviousHighlight,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: _moveToNextHighlight,
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _isSearchMode = false;
                _searchQuery = "";
                _highlightedMessageIndices.clear();
              });
            },
          ),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: AppColors.primary,
        toolbarHeight: 70,
        elevation: 0,
        scrolledUnderElevation: 0, // 스크롤 시 추가 elevation 제거
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: IconSize.medium,
            color: AppColors.icon,
          ),
        ),
        title: Row(
          children: [
            BuildChatImage("assets/images/appy_levi.png", size: 46),
            const SizedBox(width: 19),
            Text(
              "레비",
              style: const TextStyle(
                fontFamily: 'SUITE',
                fontSize: TextSize.large,
                fontWeight: FontWeight.bold,
                color: AppColors.textHigh,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearchMode = true;
              });
            },
            icon: const Icon(
              Icons.search,
              color: AppColors.icon,
              size: IconSize.medium,
            ),
          ),
        ],
      );
    }
  }

  Map<String, List<Map<String, String>>> _groupMessagesByDate(
      List<Map<String, String>> messages) {
    final Map<String, List<Map<String, String>>> groupedMessages = {};
    for (var message in messages) {
      final date =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(message["time"]!));
      if (groupedMessages[date] == null) {
        groupedMessages[date] = [];
      }
      groupedMessages[date]!.add(message);
    }
    return groupedMessages;
  }

  Widget _buildDateLabel(String date) {
    final formattedDate =
        DateFormat.yMMMMEEEEd('ko').format(DateTime.parse(date));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Text(
          formattedDate,
          style: const TextStyle(
            fontFamily: 'SUITE',
            fontSize: TextSize.small,
            color: AppColors.textMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(String text, String time, bool isUser, int index) {
    final parsedTime = DateFormat('HH:mm').format(DateTime.parse(time));
    final isHighlighted = _highlightedMessageIndices.contains(index) &&
        _highlightedMessageIndices[_currentHighlightedIndex] == index;

    // 검색된 단어 하이라이트
    List<TextSpan> _highlightText(String text, String query) {
      if (query.isEmpty) return [TextSpan(text: text)];

      final matches = text.split(RegExp(query, caseSensitive: false));
      final spans = <TextSpan>[];

      for (var i = 0; i < matches.length; i++) {
        spans.add(TextSpan(text: matches[i]));
        if (i < matches.length - 1) {
          spans.add(TextSpan(
            text: query,
            style: TextStyle(
              backgroundColor: Colors.black,
              color: Colors.white,
            ),
          ));
        }
      }
      return spans;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Column(
              children: [
                BuildChatImage("assets/images/appy_levi.png"),
                const SizedBox(height: 4),
              ],
            ),
            const SizedBox(width: 10),
          ],
          Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: isUser ? AppColors.grey200 : AppColors.accent,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                    bottomLeft:
                        isUser ? const Radius.circular(10) : Radius.zero,
                    bottomRight:
                        isUser ? Radius.zero : const Radius.circular(10),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontFamily: 'SUITE',
                        fontSize: TextSize.small,
                        color: AppColors.textHigh),
                    children: _highlightText(text, _searchQuery),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                parsedTime,
                style: const TextStyle(
                  fontFamily: 'SUITE',
                  fontSize: TextSize.extraSmall,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatInput() {
    Color sendButtonColor = AppColors.grey200;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 107,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: 353,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.iconBackground,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(1, 1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _messageController,
                    onChanged: (text) {
                      setState(() {
                        sendButtonColor =
                            text.isEmpty ? AppColors.grey200 : AppColors.accent;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "메시지를 입력하세요",
                      hintStyle: TextStyle(
                        fontSize: TextSize.small,
                        color: Color(0xffB8B8B8),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (_messageController.text.isNotEmpty) {
                    _handleSendMessage();
                    setState(() {
                      sendButtonColor = AppColors.grey200;
                    });
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: sendButtonColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          "text": _messageController.text,
          "time": DateTime.now().toIso8601String(),
          "type": "user",
        });
      });
      _messageController.clear();
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollToBottom();
      });
    }
  }
}

Widget BuildChatImage(String imagePath, {double size = 46}) {
  return ClipRRect(
    // borderRadius: BorderRadius.circular(size / 2),
    child: Image.asset(
      imagePath,
      width: size,
      height: size,
      fit: BoxFit.cover,
    ),
  );
}
