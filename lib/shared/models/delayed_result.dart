import 'package:equatable/equatable.dart';

class DelayedResult<T> extends Equatable {
  final bool isInProgress;
  final Exception? error;
  final T? value;

  const DelayedResult.idle() : isInProgress = false, error = null, value = null;

  const DelayedResult.inProgress()
    : isInProgress = true,
      error = null,
      value = null;

  const DelayedResult.fromError(Exception e)
    : isInProgress = false,
      error = e,
      value = null;

  const DelayedResult.fromValue(T result)
    : isInProgress = false,
      error = null,
      value = result;

  bool get isIdle => value == null && error == null && !isInProgress;

  bool get isError => error != null;

  bool get isSuccessful => value != null;

  @override
  List<Object?> get props => [value, error, isInProgress];
}
