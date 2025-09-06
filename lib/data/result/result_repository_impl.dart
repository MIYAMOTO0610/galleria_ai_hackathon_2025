import 'dart:convert';
import 'dart:io';

import 'package:galleria_ai_hackathon_2025/domain/result/result.dart';
import 'package:galleria_ai_hackathon_2025/domain/result/result_repository.dart';

class ResultRepositoryImpl implements ResultRepository {
  static const String _endpoint =
      'https://6974c3f5fc70.ngrok-free.app/api/generate';

  @override
  Future<Result> judgeAnswer({
    required String answer,
    required String correct,
  }) async {
    final String prompt =
        '以下の回答が合っているのかtrueかfalseで教えてください　<正解>$correct<回答>$answer、trueかfalse以外は返さないでください';

    final Map<String, dynamic> body = <String, dynamic>{
      'model': 'gpt-oss:20b',
      'prompt': prompt,
      'stream': false,
    };

    final HttpClient client =
        HttpClient()..connectionTimeout = const Duration(seconds: 15);
    final HttpClientRequest request = await client.postUrl(
      Uri.parse(_endpoint),
    );
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.add(utf8.encode(jsonEncode(body)));
    final HttpClientResponse response = await request.close();
    final String resBody = await utf8.decoder.bind(response).join();
    client.close(force: true);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API request failed: ${response.statusCode}');
    }

    final dynamic decoded = jsonDecode(resBody);
    final dynamic responseValue =
        (decoded is Map<String, dynamic>) ? decoded['response'] : null;
    final String text = (responseValue ?? '').toString().trim().toLowerCase();

    if (text == 'true') {
      return Result.correct;
    } else if (text == 'false') {
      return Result.incorrect;
    }

    // 想定外の応答の場合は不正解扱いにフォールバック
    return Result.incorrect;
  }
}
