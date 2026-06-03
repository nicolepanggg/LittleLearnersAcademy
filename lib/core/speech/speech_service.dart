import 'speech_service_stub.dart'
    if (dart.library.js) 'speech_service_web.dart';

class SpeechService {
  const SpeechService._();

  static const _defaultEnglishTag = 'en-US';
  static const _defaultTraditionalChineseTag = 'zh-TW';

  static void speak(
    String text, {
    double rate = 0.8,
    double pitch = 1.1,
    double volume = 1.0,
    String languageCode = 'en',
  }) {
    final languageTag = switch (languageCode) {
      'zh' => _defaultTraditionalChineseTag,
      _ => _defaultEnglishTag,
    };

    speakText(
      text,
      rate: rate,
      pitch: pitch,
      volume: volume,
      languageTag: languageTag,
    );
  }
}
