import 'package:flutter/material.dart';

class HoverZoomImage extends StatelessWidget {
  final String imageUrl;
  final Widget? child;
  final double scale;

  const HoverZoomImage({
    required this.imageUrl,
    this.child,
    this.scale = 1.1, // Scale factor for zoom
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true, context),
      onExit: (_) => _onHover(false, context),
      child: AnimatedScale(
        scale: _isHovering(context) ? scale : 1.0,
        duration: const Duration(milliseconds: 200),
        child: child ??
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
      ),
    );
  }

  bool _isHovering(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_HoverNotifier>()?.isHovering ?? false;
  }

  void _onHover(bool isHovering, BuildContext context) {
    final hoverNotifier = context.dependOnInheritedWidgetOfExactType<_HoverNotifier>();
    hoverNotifier?.setHover(isHovering);
  }
}

class _HoverNotifier extends InheritedWidget {
  final bool isHovering;
  final void Function(bool) setHover;

  const _HoverNotifier({
    required this.isHovering,
    required this.setHover,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _HoverNotifier oldWidget) {
    return oldWidget.isHovering != isHovering;
  }
}