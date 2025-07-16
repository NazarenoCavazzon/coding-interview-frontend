import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/src/helpers/formatters.dart';
import 'package:ui/src/theme/app_theme.dart';

class CurrencyInput extends StatefulWidget {
  const CurrencyInput({
    required this.onChanged,
    super.key,
    this.value,
    this.currencySymbol,
    this.hintText,
    this.borderColor,
    this.focusedBorderColor,
    this.textStyle,
    this.cursorColor,
    this.borderRadius,
    this.contentPadding,
    this.controller,
  });

  final ValueChanged<num> onChanged;
  final num? value;
  final String? currencySymbol;
  final String? hintText;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  late final TextEditingController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller =
        widget.controller ??
        TextEditingController(text: widget.value?.toDouble().toString());
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.isEmpty) return;
        widget.onChanged(num.parse(value));
      },
      cursorColor:
          widget.cursorColor ?? Theme.of(context).textTheme.bodyLarge?.color,
      cursorHeight: 16,
      decoration: AppTheme.inputDecoration(
        context,
        hintText: widget.hintText,
        borderColor: widget.borderColor,
        focusedBorderColor: widget.focusedBorderColor,
        borderRadius: widget.borderRadius,
        contentPadding: widget.contentPadding,
        prefixIcon: widget.currencySymbol != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  widget.currencySymbol!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color:
                        widget.focusedBorderColor ??
                        Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
            : null,
      ),
      style: widget.textStyle ?? Theme.of(context).textTheme.bodyLarge,
      controller: _controller,
      inputFormatters: [
        CommaToDecimalFormatter(),
        FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d{0,3}')),
      ],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
