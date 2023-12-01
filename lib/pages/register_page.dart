import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/colors.gen.dart';
import 'package:jimanna/models/result.dart';
import 'package:jimanna/providers/event_switch_provider.dart';
import 'package:jimanna/providers/name_register_provider.dart';
import 'package:jimanna/providers/register_error_provider.dart';
import 'package:jimanna/ui/background_painter.dart';
import 'package:jimanna/ui/bottom_text.dart';
import 'package:jimanna/ui/frame_painter.dart';

part 'register/header_top.dart';
part 'register/header_middle.dart';
part 'register/header_bottom.dart';
part 'register/character_image_view.dart';
part 'register/name_input_view.dart';
part 'register/error_text_view.dart';
part 'register/input_button_view.dart';
part 'register/contact_text_view.dart';
part 'register/register_scaffold.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyboardUp = MediaQuery.of(context).viewInsets.bottom > 0;
    final width = getDefaultWidth(context);
    final height = MediaQuery.of(context).size.height;

    return _Scaffold(
      headerTop: _HeaderTop(width),
      headerMiddle: _HeaderMiddle(width),
      headerBottom: _HeaderBottom(width),
      characterImageView: _CharacterImageView(isKeyboardUp, width, height),
      nameInputView: _NameInputView(
        nameController: _nameController,
        onPressInputButton: onPressInputButton,
        width: width,
      ),
      errorTextView: _ErrorTextView(width, height),
      inputButtonView: _InputButtonView(
        width: width,
        onPressInputButton: onPressInputButton,
      ),
      contactTextView: _ContactTextView(width),
      bottomText: BottomText(width),
      onSetNotPossibleToRegister: setNotPossibleToRegister,
    );
  }

  double getDefaultWidth(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width > 740) width = 740;
    return width;
  }

  bool canRegister() {
    return ref.watch(eventSwitchProvider) is Success<bool> &&
        (ref.watch(eventSwitchProvider) as Success<bool>).data;
  }

  void onPressInputButton() {
    if (canRegister()) {
      registerNameToFireStore();
    } else {
      setNotPossibleToRegister();
    }
  }

  void setNotPossibleToRegister() {
    ref.read(registerErrorProvider.notifier).setError('지금은 등록할 수 없습니다.');
    ref.read(nameRegisterProvider.notifier).checkAdmin(_nameController.text);
  }

  void registerNameToFireStore() {
    ref
        .read(nameRegisterProvider.notifier)
        .registerNameToFirestore(_nameController.text);
  }
}
