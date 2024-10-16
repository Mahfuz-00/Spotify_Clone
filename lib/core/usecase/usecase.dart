/// An abstract class representing a generic use case in the application's domain layer.
///
/// This class defines the structure for all use cases, which typically represent
/// actions or business logic that can be executed. The use case is parameterized
/// by two types:
/// - [Type]: The type of the result that the use case returns.
/// - [Params]: The type of parameters that the use case requires to execute.
///
/// The call method is defined as an abstract method that will be implemented
/// by concrete use cases. The method takes [Params] as an optional parameter
/// and returns a [Future] of the specified [Type].
abstract class UseCase<Type, Params> {

  /// Executes the use case with the given parameters.
  ///
  /// The [params] parameter represents the input to the use case and can be 
  /// used to pass necessary data for executing business logic. It returns a
  /// [Future] that resolves to the result of type [Type].
  ///
  /// - [Type]: The result type returned after the execution.
  /// - [Params]: The input parameters required by the use case.
  ///
  /// This method needs to be implemented by the subclasses.
  Future<Type> call({Params? params});
}
