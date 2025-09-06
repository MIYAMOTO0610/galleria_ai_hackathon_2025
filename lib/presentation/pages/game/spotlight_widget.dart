import 'package:flutter/material.dart';

class SpotlightGuessGame extends StatefulWidget {
  const SpotlightGuessGame({
    super.key,
    required this.image,
    required this.onTap,
  });
  final ImageProvider image;
  final ValueChanged<int> onTap;

  @override
  State<SpotlightGuessGame> createState() => _SpotlightGuessGameState();
}

class _SpotlightGuessGameState extends State<SpotlightGuessGame> {
  // タップしたスポット位置（最大3）
  final List<Offset> _spots = [];
  // スポット半径（必要に応じて調整 or 画面サイズに応じてスケール）
  double radius = 40;

  void _onTapDown(TapDownDetails d, Size size) {
    if (_spots.length >= 3) return;
    widget.onTap(_spots.length);
    // ローカル座標を保存（Stack上の座標）
    _spots.add(d.localPosition);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final size = Size(c.maxWidth, c.maxHeight);
        return Stack(
          children: [
            // 1) 下に画像
            Positioned.fill(
              child: ClipRect(
                child: Image(
                  image: widget.image,
                  fit: BoxFit.cover, // これで全面フィット＆ClipRectで外側は切れる
                  alignment: Alignment.center,
                ),
              ),
            ),
            // 2) 上に「黒い覆い」をCustomPaintで描き、スポット位置に穴をあける
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (d) => _onTapDown(d, size),
                child: CustomPaint(
                  painter: _SpotlightMaskPainter(
                    spots: _spots,
                    radius: radius,
                    // 画像全体の暗さ（1.0で真っ黒、0.0で透明）
                    baseOpacity: 1.0,
                    // ぼかしの強さ(px)
                    feather: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SpotlightMaskPainter extends CustomPainter {
  _SpotlightMaskPainter({
    required this.spots,
    required this.radius, // 中心まで完全に抜ける半径
    this.feather = 16.0, // ← 縁のぼかし幅（px）
    this.baseOpacity = 1.0, // ← 背景を隠す濃さ（1で真っ黒）
  });

  final List<Offset> spots;
  final double radius; // 完全クリアとなる内側半径
  final double feather; // その外側に向けたフェザー幅
  final double baseOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;

    // 1) 合成レイヤ開始
    canvas.saveLayer(bounds, Paint());

    // 2) まず全面を黒で塗る（ここは“シャープな”外枠のまま）
    final overlay = Paint()..color = Colors.black.withOpacity(baseOpacity);
    canvas.drawRect(bounds, overlay);

    // 3) 各スポットを「ラディアルグラデ × dstOut」でくり抜く
    for (final o in spots) {
      final double inner = radius; // 完全に抜ける半径
      final double outer = radius + feather; // ぼかし終端

      // 中心(α=1) → innerまでは完全に削る
      // inner→outerで α=1→0 に滑らかに減衰（縁だけぼける）
      final shader = RadialGradient(
        colors: const [
          Color(0xFF000000), // α=1（完全削除）
          Color(0xFF000000), // α=1（ここまで完全削除）
          Color(0x00000000), // α=0（以降は削らない）
        ],
        stops: [0.0, (inner / outer).clamp(0.0, 1.0), 1.0],
      ).createShader(Rect.fromCircle(center: o, radius: outer));

      final eraser = Paint()
        ..blendMode = BlendMode
            .dstOut // 既に塗った黒のアルファを“外側に向けて”削る
        ..shader = shader;

      // outer半径で塗れば、内:完全クリア、外:なめらかにクリア→0 になる
      canvas.drawCircle(o, outer, eraser);
    }

    // 4) レイヤを合成
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SpotlightMaskPainter old) =>
      old.spots != spots ||
      old.radius != radius ||
      old.feather != feather ||
      old.baseOpacity != baseOpacity;
}
