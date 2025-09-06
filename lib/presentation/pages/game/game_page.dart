import 'package:flutter/material.dart';
import 'package:galleria_ai_hackathon_2025/common/extensions/context_extension.dart';
import 'package:galleria_ai_hackathon_2025/gen/assets.gen.dart';
import 'package:galleria_ai_hackathon_2025/presentation/widgets/app_scaffold.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      background: Assets.images.game.bg.image(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CountDown(),
          SizedBox(height: 8),
          _Question(),
          SizedBox(height: 24),
          _Image(),
          const SizedBox(height: 37),
          _AnswerField(),
          _AnswerButton(),
        ],
      ),
    );
  }
}

class _CountDown extends StatelessWidget {
  const _CountDown();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF001E65),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('残り'),
          const SizedBox(width: 4),
          Text(
            '3',
            style: context.text.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(width: 4),
          Text('タップ'),
        ],
      ),
    );
  }
}

class _Question extends StatelessWidget {
  const _Question();

  @override
  Widget build(BuildContext context) {
    return Assets.images.game.question.image(width: 238, height: 69);
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 359, height: 419, child: Placeholder());
  }
}

class _AnswerField extends StatelessWidget {
  const _AnswerField();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFC9CAD7),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: '答えを入力',
          hintStyle: context.text.bodyMedium?.copyWith(
            color: context.color.primary,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // TODO
      child: SizedBox(
        child: Assets.images.game.answerButton.image(fit: BoxFit.cover),
      ),
    );
  }
}
