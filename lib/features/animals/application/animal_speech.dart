import '../../../core/speech/speech_service.dart';

class AnimalSpeech {
  const AnimalSpeech._();

  static void playSound(
    String sound, {
    double volume = 1.0,
    String languageCode = 'en',
  }) {
    SpeechService.speak(
      sound,
      rate: 0.85,
      pitch: 1.25,
      volume: volume,
      languageCode: languageCode,
    );
  }

  static void sayName(
    String name, {
    double volume = 1.0,
    String languageCode = 'en',
  }) {
    SpeechService.speak(
      name,
      rate: 0.75,
      pitch: 1.1,
      volume: volume,
      languageCode: languageCode,
    );
  }
}
