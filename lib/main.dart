import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/little_learners_app.dart';

void main() {
  runApp(const ProviderScope(child: LittleLearnersApp()));
}
