import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';
import '../bloc/word_bloc.dart';
import '../bloc/word_event.dart';
import '../bloc/word_state.dart'; 

class WordScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();          
  List<String> gridData = List.generate(16, (index) => String.fromCharCode(65 + (index % 26)));
  int gridSize = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Word Search App',textAlign: TextAlign.center,)),
        elevation: 2,
        shadowColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () {
              Navigator.pushNamed(context, '/editGridScreen');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Search Word',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10)
                      ),
                      onChanged: (text) {
                        BlocProvider.of<WordBloc>(context).add(SearchWordEvent(word: text));
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Cancel")),
                      onTap: () {
                        _controller.clear();
                        BlocProvider.of<WordBloc>(context).add(ResetSearchEvent()); 
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            BlocConsumer<WordBloc, WordState>(
              listener: (context,state){
                if (state is WordSearchSuccessState) {
                playSound(true);
              } else if (state is WordSearchFailureState) {
                playSound(false);
              }
              if (state is WordGridUpdatedState) {
                  gridData = state.updatedGridData;
                }
              },
              builder: (context, state) {
                gridSize = context.read<WordBloc>().gridSize;
                List<int> highlightedIndexes = [];
                if (state is WordSearchSuccessState) {
                  highlightedIndexes = state.foundWordIndexes;
                }
                if (state is WordGridUpdatedState) {
                  gridData = state.updatedGridData;
                } else if (state is WordInitialState || state is WordGridUpdatedState) {
                  gridData = BlocProvider.of<WordBloc>(context).gridData;
                }
            
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridSize,
                    ),
                    itemCount: gridData.length,
                    itemBuilder: (context, index) {
                      bool isHighlighted = highlightedIndexes.contains(index);
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: isHighlighted ? Colors.green : Colors.blue,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(
                          gridData[index],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void playSound(bool isSuccess) async {
    if (isSuccess) {
      _audioPlayer.play(AssetSource('sound/correct_sound.mp3'));
    } else {
      _audioPlayer.play(AssetSource('sound/incorrect_sound.mp3'));
    }
  }
}
