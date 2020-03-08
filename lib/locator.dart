import 'package:get_it/get_it.dart';
import 'package:strength_project/core/viewmodels/workoutDate_viewmodel.dart';
import 'core/services/api.dart';
import 'core/services/auth.dart';
import 'core/viewmodels/exercise_viewmodel.dart';
import 'core/viewmodels/workout_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<CreateExerciseViewModel>(
      () => CreateExerciseViewModel());
  locator.registerFactory<Api>(() => Api(path: "exercises"),
      instanceName: "exercises");
  locator.registerFactory<Api>(() => Api(path: "workouts"),
      instanceName: "workouts");
  locator.registerFactory<Api>(() => Api(path: "dates"), instanceName: "dates");
  locator.registerLazySingleton(() => CreateWorkoutViewModel());
  locator.registerLazySingleton<CreateWorkoutDateViewModel>(
      () => CreateWorkoutDateViewModel());
  // locator.registerFactory(() => Api(path: 'users'));
}
