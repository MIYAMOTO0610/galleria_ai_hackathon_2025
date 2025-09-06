import 'package:flutter/material.dart';
import 'package:galleria_ai_hackathon_2025/common/common.dart';
import 'package:galleria_ai_hackathon_2025/common/extensions/context_extension.dart';
import 'package:galleria_ai_hackathon_2025/data/result/result_repository_impl.dart';
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

  // プレイヤーの回答
  String _answer = '';

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppScaffold(
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
                _AnswerField(
                  onChanged: (value) {
                    setState(() {
                      _answer = value;
                    });
                  },
                ),
                _AnswerButton(
                  answer: _answer,
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: _isLoading
              ? Container(
                  color: Colors.black.withValues(alpha: 0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox.shrink(),
        ),
      ],
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
        image: state.question().image,
        onTap: (index) {
          onTap(index);
        },
      ),
    );
  }
}

class _AnswerField extends StatelessWidget {
  const _AnswerField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 382,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: onChanged,
        style: context.text.bodyMedium?.copyWith(color: context.color.primary),
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
  const _AnswerButton({required this.answer, required this.onTap});

  final VoidCallback onTap;

  final String answer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (answer.isEmpty) return;
        onTap();
        final result = await ResultRepositoryImpl().judgeAnswer(
          answer: answer,
          correct: state.question().answer,
        );
        if (!context.mounted) return;
        // 結果ページに遷移する
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(result: result)),
        );
      },
      child: SizedBox(
        child: Assets.images.game.answerButton.image(fit: BoxFit.cover),
      ),
    );
  }
}
