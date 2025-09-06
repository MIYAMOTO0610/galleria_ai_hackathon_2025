import 'package:galleria_ai_hackathon_2025/domain/question/question.dart';
import 'package:galleria_ai_hackathon_2025/gen/assets.gen.dart';

enum GameState {
  q1,
  q2;

  Question question() {
    return switch (this) {
      GameState.q1 => Question(
        image: Assets.images.game.rainbow.provider(),
        answer: '虹',
      ),
      GameState.q2 => Question(
        image: Assets.images.game.sabaNoSushi.provider(),
        answer: '鯖の寿司',
      ),
    };
  }
}
