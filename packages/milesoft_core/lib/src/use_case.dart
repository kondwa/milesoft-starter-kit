import 'dart:async';

import 'result.dart';

/// An operation that accepts [I] and reports an outcome of type [O].
///
/// Synchronous operations return a [Result] directly. Asynchronous operations
/// return a future. Expected failures use [Failed]. Unexpected exceptions
/// remain observable as throws or future errors.
typedef UseCase<I, O> = FutureOr<Result<O>> Function(I input);
