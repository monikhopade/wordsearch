abstract class WordState {}

class WordInitialState extends WordState {}

class WordSearchSuccessState extends WordState {
  final List<int> foundWordIndexes;
  WordSearchSuccessState({required this.foundWordIndexes});
}

class WordSearchFailureState extends WordState {}

class WordGridUpdatedState extends WordState {
  final List<String> updatedGridData;
  WordGridUpdatedState({required this.updatedGridData});
}