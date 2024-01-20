import 'package:get/get_navigation/src/root/internacionalization.dart';

class Langauges extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'world': 'World',
          "teacher_home": "Teacher Home",
          "home_text": "Home",
          'email_hint': "Email Hint"
        },
        'ne_NP': {
          'hello': 'नमस्ते',
          'world': 'दुनिया',
          "teacher_home": "शिक्षक घर",
          "home_text": "गृह",
        },
      };
}
