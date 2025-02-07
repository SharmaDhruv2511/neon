import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neon/models.dart';
import 'package:neon_files/l10n/localizations.dart';
import 'package:neon_files/src/blocs/files.dart';
import 'package:neon_files/src/options.dart';
import 'package:neon_files/src/pages/main.dart';
import 'package:neon_files/src/routes.dart';
import 'package:nextcloud/nextcloud.dart';

class FilesApp extends AppImplementation<FilesBloc, FilesAppSpecificOptions> {
  FilesApp();

  @override
  final String id = AppIDs.files;

  @override
  final LocalizationsDelegate<FilesLocalizations> localizationsDelegate = FilesLocalizations.delegate;

  @override
  final List<Locale> supportedLocales = FilesLocalizations.supportedLocales;

  @override
  late final FilesAppSpecificOptions options = FilesAppSpecificOptions(storage);

  @override
  FilesBloc buildBloc(final Account account) => FilesBloc(
        options,
        account,
      );

  @override
  final Widget page = const FilesMainPage();

  @override
  final RouteBase route = $filesAppRoute;
}
