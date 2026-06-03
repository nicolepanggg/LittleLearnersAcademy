// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:js' as js;

void speakText(
  String text, {
  required double rate,
  required double pitch,
  required double volume,
  required String languageTag,
}) {
  final synthesis = js.context['speechSynthesis'];
  final utteranceFactory = js.context['SpeechSynthesisUtterance'];

  if (synthesis == null || utteranceFactory == null) {
    return;
  }

  final utterance = js.JsObject(utteranceFactory, [text])
    ..['lang'] = languageTag
    ..['rate'] = rate
    ..['pitch'] = pitch
    ..['volume'] = volume;

  final voices = synthesis.callMethod('getVoices');
  if (voices is js.JsArray) {
    for (var index = 0; index < voices.length; index++) {
      final voice = voices[index];
      final voiceLang = voice['lang']?.toString() ?? '';
      if (voiceLang.toLowerCase().startsWith(languageTag.toLowerCase())) {
        utterance['voice'] = voice;
        break;
      }
      if (voiceLang.toLowerCase().startsWith(
        languageTag.split('-').first.toLowerCase(),
      )) {
        utterance['voice'] = voice;
      }
    }
  }

  synthesis.callMethod('cancel');
  synthesis.callMethod('speak', [utterance]);
}
