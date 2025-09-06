import 'package:flutter/material.dart';
import 'package:galleria_ai_hackathon_2025/common/extensions/context_extension.dart';
import 'package:galleria_ai_hackathon_2025/domain/result/result.dart';
import 'package:galleria_ai_hackathon_2025/gen/assets.gen.dart';
import 'package:galleria_ai_hackathon_2025/presentation/pages/game/spotlight_widget.dart';
import 'package:galleria_ai_hackathon_2025/presentation/pages/result/result_page.dart';
import 'package:galleria_ai_hackathon_2025/presentation/widgets/app_scaffold.dart';

const limitSpotCount = 3;

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // 残りのスポット数
  int _spotCount = limitSpotCount;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      background: Assets.images.game.bg.image(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 47),
            _CountDown(spotCount: _spotCount),
            SizedBox(height: 8),
            _Question(),
            SizedBox(height: 24),
            _Image(
              onTap: (index) {
                setState(() {
                  _spotCount = limitSpotCount - index - 1;
                });
              },
            ),
            const SizedBox(height: 37),
            _AnswerField(),
            _AnswerButton(),
          ],
        ),
      ),
    );
  }
}

class _CountDown extends StatelessWidget {
  const _CountDown({required this.spotCount});

  final int spotCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xff001035),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('残り'),
          const SizedBox(width: 4),
          Text(
            '$spotCount',
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
  const _Image({required this.onTap});

  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 359,
      height: 419,
      child: SpotlightGuessGame(
        image: Assets.images.game.fruitRingo.image().image,
        onTap: (index) {
          onTap(index);
        },
      ),
    );
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
      onTap: () async {
        // TODO: 答えを送信する
        // TODO: 結果を取得する
        final result = Result.correct;
        // 結果ページに遷移する
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(result: result)),
        );
      }, // TODO
      child: SizedBox(
        child: Assets.images.game.answerButton.image(fit: BoxFit.cover),
      ),
    );
  }
}
