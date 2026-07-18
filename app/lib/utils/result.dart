sealed class Result<T, E> {
  const Result();

  factory Result.ok(T value) = Ok<T, E>;
  factory Result.err(E error) = Err<T, E>;
}

class Ok<T, E> extends Result<T, E> {
  const Ok(this.value);
  final T value;
}

class Err<T, E> extends Result<T, E> {
  const Err(this.error);
  final E error;
}
