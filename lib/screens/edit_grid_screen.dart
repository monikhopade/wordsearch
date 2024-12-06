import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/word_bloc.dart';
import '../bloc/word_event.dart';
import '../bloc/word_state.dart';

class EditGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Grid')),
      body: BlocBuilder<WordBloc, WordState>(
        builder: (context, state) {
         
          int gridSize = context.read<WordBloc>().gridSize;
          List<String> gridData = context.read<WordBloc>().gridData;

          return Column(
            children: [
             
              Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Change Grid Size"),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: DropdownButton<int>(
                        value: gridSize,
                        items: const [
                          DropdownMenuItem<int>(
                            value: 4,
                            child: Text('4x4 Grid'),
                          ),
                          DropdownMenuItem<int>(
                            value: 5,
                            child: Text('4x5 Grid'),
                          ),
                        ],
                        onChanged: (newSize) {
                          if (newSize != null) {
                           
                            BlocProvider.of<WordBloc>(context).add(ChangeGridSizeEvent(gridSize: newSize));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Text("Note: To change grid value tap on grid cell and enter new value."),
              Flexible(
                fit: FlexFit.tight,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridSize,
                  ),
                  itemCount: gridData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: TextField(
                          controller: TextEditingController(
                              text: gridData[index]),
                          onChanged: (newValue) {
                            if (newValue.isNotEmpty) {
                              String updatedChar = newValue.substring(0, 1).toUpperCase();
                              List<String> updatedGridData = List.from(gridData);
                              updatedGridData[index] = updatedChar;
                              
                             
                              BlocProvider.of<WordBloc>(context).add(UpdateGridEvent(newGridData: updatedGridData));
                            }
                          },
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            counterText: ""
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
             
              ElevatedButton(
                onPressed: () {
                 
                  Navigator.pop(context);
                },
                child: const Text("Save and Return",style: TextStyle(color: Colors.black),),
              ),
            ],
          );
        },
      ),
    );
  }
}
