import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:neon/blocs.dart';
import 'package:neon/sort_box.dart';
import 'package:neon/theme.dart';
import 'package:neon/utils.dart';
import 'package:neon/widgets.dart';
import 'package:neon_notes/l10n/localizations.dart';
import 'package:neon_notes/src/blocs/note.dart';
import 'package:neon_notes/src/blocs/notes.dart';
import 'package:neon_notes/src/options.dart';
import 'package:neon_notes/src/pages/note.dart';
import 'package:neon_notes/src/sort/notes.dart';
import 'package:neon_notes/src/utils/category_color.dart';
import 'package:nextcloud/notes.dart' as notes;

class NotesView extends StatelessWidget {
  const NotesView({
    required this.bloc,
    this.category,
    super.key,
  });

  final NotesBloc bloc;
  final String? category;

  @override
  Widget build(final BuildContext context) => ResultBuilder<List<notes.Note>>.behaviorSubject(
        subject: bloc.notesList,
        builder: (final context, final notesList) => SortBoxBuilder<NotesSortProperty, notes.Note>(
          sortBox: notesSortBox,
          presort: const {
            (property: NotesSortProperty.favorite, order: SortBoxOrder.ascending),
          },
          sortProperty: bloc.options.notesSortPropertyOption,
          sortBoxOrder: bloc.options.notesSortBoxOrderOption,
          input: category != null
              ? notesList.data?.where((final note) => note.category == category).toList()
              : notesList.data,
          builder: (final context, final sorted) => NeonListView(
            scrollKey: 'notes-notes',
            isLoading: notesList.isLoading,
            error: notesList.error,
            onRefresh: bloc.refresh,
            itemCount: sorted.length,
            itemBuilder: (final context, final index) => _buildNote(context, sorted[index]),
          ),
        ),
      );

  Widget _buildNote(
    final BuildContext context,
    final notes.Note note,
  ) =>
      ListTile(
        title: Text(note.title),
        subtitle: Row(
          children: [
            RelativeTime(
              date: DateTime.fromMillisecondsSinceEpoch(note.modified * 1000),
            ),
            if (note.category.isNotEmpty) ...[
              const SizedBox(
                width: 8,
              ),
              Icon(
                MdiIcons.tag,
                size: smallIconSize,
                color: NotesCategoryColor.compute(note.category),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(note.category),
            ],
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            bloc.updateNote(
              note.id,
              note.etag,
              favorite: !note.favorite,
            );
          },
          tooltip: note.favorite ? NotesLocalizations.of(context).noteUnstar : NotesLocalizations.of(context).noteStar,
          icon: Icon(
            note.favorite ? Icons.star : Icons.star_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (final context) => NotesNotePage(
                bloc: NotesNoteBloc(
                  bloc,
                  note,
                ),
                notesBloc: bloc,
              ),
            ),
          );
        },
        onLongPress: () async {
          final result = await showConfirmationDialog(
            context,
            NotesLocalizations.of(context).noteDeleteConfirm(note.title),
          );
          if (result) {
            bloc.deleteNote(note.id);
          }
        },
      );
}
