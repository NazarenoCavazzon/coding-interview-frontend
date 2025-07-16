import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteCurrencySwitch extends StatefulWidget {
  const QuoteCurrencySwitch({super.key});

  @override
  State<QuoteCurrencySwitch> createState() => _QuoteCurrencySwitchState();
}

class _QuoteCurrencySwitchState extends State<QuoteCurrencySwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: MaterialButton(
        onPressed: () {
          if (_isFlipped) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
          _isFlipped = !_isFlipped;
          context.read<P2PQuoteCubit>().switchExchangeDirection();
        },
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
        height: 56,
        minWidth: 56,
        shape: const CircleBorder(),
        color: Theme.of(context).colorScheme.primary,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(_animation.value * 3.14159),
              child: Icon(
                Icons.compare_arrows_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 32,
              ),
            );
          },
        ),
      ),
    );
  }
}
