import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:neon/src/settings/widgets/settings_tile.dart';
import 'package:neon/src/widgets/adaptive_widgets/list_tile.dart';

@internal
class CustomSettingsTile extends SettingsTile {
  const CustomSettingsTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final FutureOr<void> Function()? onTap;

  @override
  Widget build(final BuildContext context) => AdaptiveListTile(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
      );
}
