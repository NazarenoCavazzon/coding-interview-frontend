import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class DarkModeSwitch extends StatelessWidget {
  const DarkModeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeCubit = context.read<ThemeCubit>();

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: themeCubit.toggleTheme,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surface,
              border: Border.all(color: theme.colorScheme.primary, width: 1.5),
            ),
            child: Icon(
              theme.brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: theme.colorScheme.primary,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
