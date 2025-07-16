import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/src/helpers/layout.dart';

void main() {
  group('isPhone', () {
    testWidgets('returns true for width < 600px', (tester) async {
      const testWidth = 599.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(size: const Size(testWidth, 800)),
                child: Builder(
                  builder: (context) {
                    final result = isPhone(context);
                    expect(result, isTrue);
                    return const SizedBox();
                  },
                ),
              );
            },
          ),
        ),
      );
    });

    testWidgets('returns false for width >= 600px', (tester) async {
      const testWidth = 600.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(size: const Size(testWidth, 800)),
                child: Builder(
                  builder: (context) {
                    final result = isPhone(context);
                    expect(result, isFalse);
                    return const SizedBox();
                  },
                ),
              );
            },
          ),
        ),
      );
    });

    testWidgets('returns false for desktop width', (tester) async {
      const testWidth = 1200.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(size: const Size(testWidth, 800)),
                child: Builder(
                  builder: (context) {
                    final result = isPhone(context);
                    expect(result, isFalse);
                    return const SizedBox();
                  },
                ),
              );
            },
          ),
        ),
      );
    });

    testWidgets('returns true for typical phone width', (tester) async {
      const testWidth = 390.0; // iPhone 14 width

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(size: const Size(testWidth, 844)),
                child: Builder(
                  builder: (context) {
                    final result = isPhone(context);
                    expect(result, isTrue);
                    return const SizedBox();
                  },
                ),
              );
            },
          ),
        ),
      );
    });

    testWidgets('returns true for edge case at 599.9px', (tester) async {
      const testWidth = 599.9;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(size: const Size(testWidth, 800)),
                child: Builder(
                  builder: (context) {
                    final result = isPhone(context);
                    expect(result, isTrue);
                    return const SizedBox();
                  },
                ),
              );
            },
          ),
        ),
      );
    });
  });
}
