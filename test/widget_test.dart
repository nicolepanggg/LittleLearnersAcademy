import 'package:flutter_test/flutter_test.dart';
import 'package:little_learners_academy/app/little_learners_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('shows the Little Learner home screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: LittleLearnersApp()));

    expect(find.text('Little Learner'), findsOneWidget);
    expect(find.text('Hello Friend!'), findsOneWidget);
    expect(find.text('Animals'), findsWidgets);
  });
}
