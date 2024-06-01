abstract class BaseUseCase<Type, Params> {
  Future<Type> call({required Params params});
}
