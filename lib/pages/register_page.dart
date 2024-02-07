import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimanna/gen/assets.gen.dart';
import 'package:jimanna/gen/colors.gen.dart';
import 'package:jimanna/pages/register/register_state.dart';
import 'package:jimanna/providers/name_register_provider.dart';
import 'package:jimanna/providers/register_state_provider.dart';
import 'package:jimanna/ui/background_painter.dart';
import 'package:jimanna/ui/bottom_text.dart';
import 'package:jimanna/ui/frame_painter.dart';
import 'package:jimanna/utils/context_utils.dart';

part 'register/character_image_view.dart';
part 'register/contact_text_view.dart';
part 'register/error_text_view.dart';
part 'register/header_bottom.dart';
part 'register/header_middle.dart';
part 'register/header_top.dart';
part 'register/input_button_view.dart';
part 'register/name_input_view.dart';
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
    final registerState = ref.watch(registerStateProvider);
    checkAdminInput(registerState);

    return _Scaffold(
      headerTop: const _HeaderTop(),
      headerMiddle: const _HeaderMiddle(),
      headerBottom: const _HeaderBottom(),
      characterImageView: const _CharacterImageView(),
      nameInputView: _NameInputView(
        nameController: _nameController,
        onPressInputButton: () =>
            registerState.check(ref, _nameController.text),
      ),
      errorTextView: _ErrorTextView(registerState),
      inputButtonView: _InputButtonView(
        onPressInputButton: () =>
            registerState.check(ref, _nameController.text),
      ),
      contactTextView: const _ContactTextView(),
      bottomText: const BottomText(),
    );
  }

  void checkAdminInput(RegisterState registerState) {
    if (registerState is CannotRegisterState) {
      registerState.check(ref, _nameController.text);
    }
  }
}
