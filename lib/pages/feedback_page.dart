import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/models/text_feedback.dart';
import 'package:jimanna/providers/firebase/firebase_factory.dart';
import 'package:jimanna/ui/background_painter.dart';

class FeedbackPage extends ConsumerStatefulWidget {
  const FeedbackPage({super.key});

  @override
  ConsumerState<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends ConsumerState<FeedbackPage> {
  final _secondTextController = TextEditingController();
  final _thirdTextController = TextEditingController();
  final _fourthTextController = TextEditingController();
  final _fifthTextController = TextEditingController();
  final _sixthTextController = TextEditingController();

  final _feedbackRef = FireStoreFactory.feedbackRef();
  final selected = [false, false];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('처음으로'),
                  ),
                  SizedBox(height: height / 20),
                  QuestionText(context, '1. 귀하의 소속을 알려주세요(파카드/아바드)'),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ToggleButtons(
                      isSelected: selected,
                      selectedBorderColor: Colors.white,
                      borderColor: Colors.black,
                      borderWidth: 4,
                      borderRadius: BorderRadius.circular(10),
                      onPressed: (index) {
                        setState(() {
                          if (index == 0) {
                            selected[0] = true;
                            selected[1] = false;
                          } else {
                            selected[0] = false;
                            selected[1] = true;
                          }
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 24,
                          ),
                          child: Text(
                            '파카드',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 24,
                          ),
                          child: Text(
                            '아바드',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QuestionText(context, '2. 평소에 청년부 내에서 연합의 중요성을 많이 느끼셨나요?'),
                  FeedbackInputField(context, _secondTextController),
                  QuestionText(
                    context,
                    '3. 연합지만나가 연합을 위해 큰 역할이 됐다고 생각되시나요? 아니라면 더 좋은 연합의 방법이 있을까요?',
                  ),
                  FeedbackInputField(context, _thirdTextController),
                  QuestionText(
                    context,
                    '4. 다음번에도 연합지만나가 열린다면 참여할 의향이 있으신가요? 만약 어려우시다면 이유를 말씀해 주실 수 있을까요?',
                  ),
                  FeedbackInputField(context, _fourthTextController),
                  QuestionText(
                    context,
                    '5. 청년부내에서 하시고 싶은 행사나 원하시는 방향성이 있으실까요?',
                  ),
                  FeedbackInputField(context, _fifthTextController),
                  QuestionText(context, '6. 마지막으로 전도사님께 한 말씀 부탁드리겠습니다.     '),
                  FeedbackInputField(context, _sixthTextController),
                  ElevatedButton(
                    onPressed: () {
                      if (isSelected()) {
                        saveAndShowResult(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Image.asset(
                      'assets/images/confirm_button.png',
                      width: width * (2 / 3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text QuestionText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
    );
  }

  Widget FeedbackInputField(
    BuildContext context,
    TextEditingController controller,
  ) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 80),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        style: TextStyle(
          color: Colors.black,
          fontSize: width / 30,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: '입력해주세요',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: width / 30,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  void saveAndShowResult(BuildContext context) {
    final currentTimeText = DateTime.now().toString();
    _feedbackRef
        .add(
      TextFeedback(
        answer1: getStringBySelected(),
        answer2: _secondTextController.text,
        answer3: _thirdTextController.text,
        answer4: _fourthTextController.text,
        answer5: _fifthTextController.text,
        answer6: _sixthTextController.text,
        timeText: currentTimeText,
      ),
    )
        .then(
      (_) {
        Navigator.pop(context, true);
      },
    );
  }

  String getStringBySelected() {
    if (selected[0]) {
      return '파카드';
    } else {
      return '아바드';
    }
  }

  bool isSelected() {
    return selected[0] || selected[1];
  }
}
