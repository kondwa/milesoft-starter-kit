import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'tokens.dart';

/// Arranges two panes using the width available from their parent.
///
/// Below [wideMinWidth], or with unbounded width, the panes stack. At the
/// breakpoint and above they share the available width. The wide layout
/// follows [Directionality], and keyboard traversal starts in [primary].
/// Wrap the layout in a scroll view when its content can exceed the height.
final class MileSoftResponsiveLayout extends StatelessWidget {
  const MileSoftResponsiveLayout({
    super.key,
    required this.wideMinWidth,
    required this.primary,
    required this.secondary,
  }) : assert(wideMinWidth > 0 && wideMinWidth < double.infinity);

  /// The first width in logical pixels at which both panes fit side by side.
  final double wideMinWidth;
  final Widget primary;
  final Widget secondary;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final wide =
          constraints.hasBoundedWidth && constraints.maxWidth >= wideMinWidth;
      final gap = MileSoftTokens.spacing.medium;
      final horizontalGap = math.min(gap, constraints.maxWidth);
      final flex = wide ? 1 : 0;

      // Keep the children in the same element slots when the axis changes.
      return FocusTraversalGroup(
        policy: WidgetOrderTraversalPolicy(),
        child: Flex(
          direction: wide ? Axis.horizontal : Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: flex, fit: FlexFit.tight, child: primary),
            if (wide) SizedBox(width: horizontalGap) else SizedBox(height: gap),
            Flexible(flex: flex, fit: FlexFit.tight, child: secondary),
          ],
        ),
      );
    },
  );
}
