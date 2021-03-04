import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController searchBarController = TextEditingController();
TextEditingController drawingNameInputController = TextEditingController();

class DrawingHomeScreen extends StatefulWidget {
  @override
  _DrawingHomeScreenState createState() => _DrawingHomeScreenState();
}

class _DrawingHomeScreenState extends State<DrawingHomeScreen> {

  List<TextButton> drawingList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Assignment'),
        centerTitle: true,
      ),
      body: Column(

        children: <Widget>[
          Container(
            height: 40,
            child: TextField(
              controller: searchBarController,
            )

          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: drawingList.length,
            itemBuilder: (context, int index){
              return new Dismissible(
                key: UniqueKey(),
                child: ListTile(
                  title: drawingList[index].child,
                  onTap: (){

                  },
                ),
                onDismissed: (direction){
                  drawingList.removeAt(index);
                },
              );
            },
          ),
        ],
      ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add",
          child: Icon(Icons.add),
          onPressed: (){
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter drawing name"),
                  content: TextField(
                    controller: drawingNameInputController,
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("OK"),
                      onPressed: (){
                        setState(() {
                          drawingList.add(
                              new TextButton(
                                child: Text(drawingNameInputController.text),
                              )
                          );
                        });
                        drawingNameInputController.text = "";
                        Navigator.of(context).pop();
                      }
                    ),
                    MaterialButton(
                      elevation: 5.0,
                      child: Text("Cancel"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      }
                    )
                  ]
                );
              }
            );
          }
    ),
    );
  }
}

