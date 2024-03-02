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
  final _feedbackController = TextEditingController();
  final _feedbackRef = FireStoreFactory.feedbackRef();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('처음으로'),
                ),
                SizedBox(height: height / 80),
                Text(
                  '피드백을 남겨주세요!',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontSize: width / 24,
                      ),
                ),
                SizedBox(height: height / 80),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _feedbackController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width / 30,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: '피드백을 입력해주세요',
                      hintStyle:
                          Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.white,
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
                ),
                SizedBox(height: height / 80),
                ElevatedButton(
                  onPressed: () {
                    saveAndShowResult(context);
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
    );
  }

  void saveAndShowResult(BuildContext context) {
    final currentTimeText = DateTime.now().toString();
    _feedbackRef
        .add(TextFeedback(_feedbackController.text, currentTimeText))
        .then(
      (value) {
        Navigator.pop(context, true);
      },
    );
  }
}
