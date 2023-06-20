import 'package:flutter/material.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';

class LabelledWidget extends StatelessWidget {
  final String? label;
  final Widget child;
  final EdgeInsets labelPadding;
  final TextStyle style;
  final double separatorHeight;
  final Widget? trailing;
  const LabelledWidget({
    Key? key,
    this.label,
    required this.child,
    // this.type = LabelledWidgetType.body,
    this.labelPadding = EdgeInsets.zero,
    this.trailing,
    this.style = TextStyleConstants.textStyleHeadingH6XSmall,
    this.separatorHeight = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: labelPadding,
                child: Text(
                  '$label',
                  style: style,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          SizedBox(height: separatorHeight),
        ],
        Flexible(child: child)
      ],
    );
  }
}
