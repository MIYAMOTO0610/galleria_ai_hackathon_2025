import 'package:flutter/material.dart';
import 'package:galleria_ai_hackathon_2025/common/extensions/context_extension.dart';
import 'package:galleria_ai_hackathon_2025/domain/result/result.dart';
import 'package:galleria_ai_hackathon_2025/gen/assets.gen.dart';
import 'package:galleria_ai_hackathon_2025/presentation/widgets/app_scaffold.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.result});

  final Result result;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      background: Assets.images.result.bg.image(),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 結果テキスト
                  _ResultText(result: result),
                  const SizedBox(height: 40),
                  // 画像
                  _Image(),
                  // 答えは...
                  const SizedBox(height: 31),
                  _AnswerText(),
                  // 正解
                  const SizedBox(height: 16),
                  _CorrectAnswer(),
                ],
              ),
            ),

            // トップに戻るボタン
            _ToTopButton(),
          ],
        ),
      ),
    );
  }
}

class _ResultText extends StatelessWidget {
  const _ResultText({required this.result});

  final Result result;

  @override
  Widget build(BuildContext context) {
    return result == Result.correct
        ? Assets.images.result.success.image()
        : Assets.images.result.failure.image();
  }
}

class _AnswerText extends StatelessWidget {
  const _AnswerText();

  @override
  Widget build(BuildContext context) {
    return Text(
      '答えは・・・',
      style: context.text.bodyMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _CorrectAnswer extends StatelessWidget {
  const _CorrectAnswer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 326,
      height: 114,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xff001035),
        border: Border.all(color: const Color(0xff6291FF), width: 12),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Text(
        'あおりんご',
        style: context.text.bodyMedium?.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 260, height: 303, child: Placeholder());
  }
}

class _ToTopButton extends StatelessWidget {
  const _ToTopButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: SizedBox(
        child: Assets.images.result.toTopButton.image(fit: BoxFit.cover),
      ),
    );
  }
}
