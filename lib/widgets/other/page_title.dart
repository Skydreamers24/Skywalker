import 'package:flutter/material.dart';
import 'package:gomate/misc/values.dart';
import 'package:gomate/widgets/other/page_start.dart';

class PageTitle extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final EdgeInsets? padding;
  const PageTitle(this.title, {this.padding, super.key}) : titleWidget = null;
  const PageTitle.withTitleWidget(this.titleWidget, {this.padding, super.key}) : title = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PageStart(),
        Padding(
          padding: padding ?? spacious,
          child: titleWidget ??
              (title != null
                  ? Text(
                      title!,
                      style: pageTitle(context),
                    )
                  : nothing),
        ),
      ],
    );
  }
}