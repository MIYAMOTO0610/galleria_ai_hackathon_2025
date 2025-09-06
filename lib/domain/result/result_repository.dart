import 'package:galleria_ai_hackathon_2025/domain/result/result.dart';

/// 外部APIにリクエストを送り、解答が正解か不正解かを判定するための
/// ドメイン層リポジトリインターフェース。
///
/// インフラ詳細（HTTPクライアント、エンドポイント、認証等）は
/// 実装側（data/infra 層）に委譲します。
abstract class ResultRepository {
  /// ユーザーの回答と正解文字列を受け取り、正誤を返します。
  Future<Result> judgeAnswer({required String answer, required String correct});
}
