sealed class AsyncValue<T> {
  const AsyncValue();

  factory AsyncValue.loading() = AsyncLoading<T>;
  factory AsyncValue.success(T value) = AsyncSuccess<T>;
  factory AsyncValue.error(Object error) = AsyncError<T>;
}

class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading();
}

class AsyncSuccess<T> extends AsyncValue<T> {
  final T value;
  const AsyncSuccess(this.value);
}

class AsyncError<T> extends AsyncValue<T> {
  final Object error;
  const AsyncError(this.error);
}
