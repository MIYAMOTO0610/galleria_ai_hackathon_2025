import 'package:flutter/material.dart';
import 'package:galleria_ai_hackathon_2025/common/extensions/context_extension.dart';
import 'package:galleria_ai_hackathon_2025/presentation/widgets/app_scaffold.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CountDown(),
          SizedBox(height: 32),
          _Question(),
          SizedBox(height: 16),
          _Image(),
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
    return Text(
      'これは何？',
      style: context.text.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 32,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image();

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 330, height: 440, child: Placeholder());
  }
}
