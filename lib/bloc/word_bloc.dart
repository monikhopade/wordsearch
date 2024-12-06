import 'package:flutter_bloc/flutter_bloc.dart';
import 'word_event.dart';
import 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  int gridSize = 4; 
  List<String> gridData = List.generate(16, (index) => String.fromCharCode(65 + (index % 26)));
  List<int> foundIndexes = [];

  WordBloc() : super(WordInitialState()) {
    on<UpdateGridEvent>(_onUpdateGridEvent); 
    on<SearchWordEvent>(_onSearchWordEvent); 
    on<ChangeGridSizeEvent>(_onChangeGridSizeEvent); 
    on<ResetSearchEvent>(_onResetSearchEvent); 
  }

 
  void _onSearchWordEvent(SearchWordEvent event, Emitter<WordState> emit) {
    final word = event.word;
    
    foundIndexes = searchWordInGrid(word);

    if (foundIndexes.isNotEmpty) {
      emit(WordSearchSuccessState(foundWordIndexes: foundIndexes)); 
    } else {
      emit(WordSearchFailureState()); 
    }
  }

 
  void _onChangeGridSizeEvent(ChangeGridSizeEvent event, Emitter<WordState> emit) {
    gridSize = event.gridSize;
    gridData = List.generate(gridSize * gridSize, (index) => String.fromCharCode(65 + (index % 26)));
    emit(WordInitialState()); 
  }

 
  void _onResetSearchEvent(ResetSearchEvent event, Emitter<WordState> emit) {
    foundIndexes.clear(); 
    emit(WordInitialState()); 
  }

 
  void _onUpdateGridEvent(UpdateGridEvent event, Emitter<WordState> emit) {
    gridData = event.newGridData;
    emit(WordGridUpdatedState(updatedGridData: event.newGridData)); 
  }

 
  List<int> searchWordInGrid(String word) {
    List<int> foundIndexes = [];
    String upperCaseWord = word.toUpperCase();

   
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j <= gridSize - word.length; j++) {
        String horizontalWord = '';
        for (int k = 0; k < word.length; k++) {
          horizontalWord += gridData[i * gridSize + (j + k)];
        }
        if (horizontalWord.toUpperCase() == upperCaseWord) {
          foundIndexes.addAll(List.generate(word.length, (index) => i * gridSize + (j + index)));
        }
      }
    }

   
    for (int col = 0; col < gridSize; col++) {
      for (int row = 0; row <= gridSize - word.length; row++) {
        String verticalWord = '';
        for (int k = 0; k < word.length; k++) {
          verticalWord += gridData[(row + k) * gridSize + col];
        }
        if (verticalWord.toUpperCase() == upperCaseWord) {
          foundIndexes.addAll(List.generate(word.length, (index) => (row + index) * gridSize + col));
        }
      }
    }

   
    for (int i = 0; i <= gridSize - word.length; i++) {
      for (int j = 0; j <= gridSize - word.length; j++) {
        String diagonalWord = '';
        for (int k = 0; k < word.length; k++) {
          diagonalWord += gridData[(i + k) * gridSize + (j + k)];
        }
        if (diagonalWord.toUpperCase() == upperCaseWord) {
          foundIndexes.addAll(List.generate(word.length, (index) => (i + index) * gridSize + (j + index)));
        }
      }
    }

   
    for (int i = gridSize - 1; i >= word.length - 1; i--) {
      for (int j = 0; j <= gridSize - word.length; j++) {
        String diagonalWord = '';
        for (int k = 0; k < word.length; k++) {
          diagonalWord += gridData[(i - k) * gridSize + (j + k)];
        }
        if (diagonalWord.toUpperCase() == upperCaseWord) {
          foundIndexes.addAll(List.generate(word.length, (index) => (i - index) * gridSize + (j + index)));
        }
      }
    }

    return foundIndexes;
  }
}

