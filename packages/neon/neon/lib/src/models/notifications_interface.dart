import 'package:meta/meta.dart';
import 'package:neon/src/bloc/bloc.dart';
import 'package:neon/src/models/app_implementation.dart';
import 'package:neon/src/settings/models/options_collection.dart';

/// The interface of the notifications client implementation.
///
/// Use this to access the notifications client from other Neon clients.
abstract interface class NotificationsAppInterface<T extends NotificationsBlocInterface,
    R extends NotificationsOptionsInterface> extends AppImplementation<T, R> {
  /// Creates a new notifications client.
  NotificationsAppInterface();

  @override
  @mustBeOverridden
  R get options => throw UnimplementedError();
}

/// The interface of the bloc used by the notifications client.
abstract interface class NotificationsBlocInterface extends InteractiveBloc {
  /// Creates a new notifications bloc.
  NotificationsBlocInterface(this.options);

  /// The options for the notifications client.
  final NotificationsOptionsInterface options;

  /// Deletes the notification with the given [id].
  void deleteNotification(final int id);
}

/// The interface of the app options used by the notifications client.
abstract interface class NotificationsOptionsInterface extends NextcloudAppOptions {
  /// Creates the nextcloud app options for the notifications client.
  NotificationsOptionsInterface(super.storage);
}
