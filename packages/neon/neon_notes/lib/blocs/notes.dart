part of '../neon_notes.dart';

abstract class NotesBlocEvents {
  void createNote({
    final String title = '',
    final String category = '',
  });

  void updateNote(
    final int id,
    final String etag, {
    final String? title,
    final String? category,
    final String? content,
    final bool? favorite,
  });

  void deleteNote(final int id);
}

abstract class NotesBlocStates {
  BehaviorSubject<Result<List<NotesNote>>> get notes;
}

class NotesBloc extends InteractiveBloc implements NotesBlocEvents, NotesBlocStates {
  NotesBloc(
    this.options,
    this.requestManager,
    this.account,
  ) {
    unawaited(refresh());
  }

  final NotesAppSpecificOptions options;
  final RequestManager requestManager;
  final Account account;

  @override
  void dispose() {
    unawaited(notes.close());
    super.dispose();
  }

  @override
  BehaviorSubject<Result<List<NotesNote>>> notes = BehaviorSubject<Result<List<NotesNote>>>();

  @override
  Future refresh() async {
    await requestManager.wrapNextcloud<List<NotesNote>, BuiltList>(
      account.id,
      'notes-notes',
      notes,
      () async => account.client.notes.getNotes(),
      List<NotesNote>.from,
    );
  }

  @override
  void createNote({final String title = '', final String category = ''}) {
    wrapAction(
      () async => account.client.notes.createNote(
        title: title,
        category: category,
      ),
    );
  }

  @override
  void deleteNote(final int id) {
    wrapAction(() async => account.client.notes.deleteNote(id: id));
  }

  @override
  void updateNote(
    final int id,
    final String etag, {
    final String? title,
    final String? category,
    final String? content,
    final bool? favorite,
  }) {
    wrapAction(
      () async => account.client.notes.updateNote(
        id: id,
        title: title,
        category: category,
        content: content,
        favorite: favorite ?? false ? 1 : 0,
        ifMatch: '"$etag"',
      ),
    );
  }
}
