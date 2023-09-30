// Define the states
abstract class MainStates {}

class MainInitial extends MainStates {}

class MainLoading extends MainStates {}

class MainLoaded extends MainStates {
  final int count;

  MainLoaded(this.count);
}