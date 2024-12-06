abstract class WordEvent {}

class SearchWordEvent extends WordEvent {
  final String word;
  SearchWordEvent({required this.word});
}

class ChangeGridSizeEvent extends WordEvent {
  final int gridSize;
  ChangeGridSizeEvent({required this.gridSize});
}

class ResetSearchEvent extends WordEvent {} 

class UpdateGridEvent extends WordEvent {
  final List<String> newGridData;
  UpdateGridEvent({required this.newGridData});
}