//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

TextEditingController searchBarController = TextEditingController();
TextEditingController drawingNameInputController = TextEditingController();
List<String> drawingList = [];

class DrawingHomeScreen extends StatefulWidget {
  @override
  _DrawingHomeScreenState createState() => _DrawingHomeScreenState();
}

// saveData() async{
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   preferences.
// }

class _DrawingHomeScreenState extends State<DrawingHomeScreen> {

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
                  title: Text(drawingList[index]),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrawingScreen()),
                    );
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
                            drawingNameInputController.text,
                              // new ElevatedButton(
                              //   child: Text(drawingNameInputController.text),
                              //   onPressed: (){
                              //     print("Pushed");
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(builder: (context) => DrawingScreen()),
                              //     );
                              //   },
                              //   onLongPress: (){
                              //     print("Long pressed");
                              //   },
                              // )
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
                        drawingNameInputController.text = "";
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

class DrawingScreen extends StatefulWidget {
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {

  List<Offset> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new GestureDetector(
          onPanUpdate: (DragUpdateDetails details){
            setState(() {
              RenderBox object = context.findRenderObject();
              Offset _localPosition = object.globalToLocal(details.globalPosition);
              _points = new List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details)=>_points.add(null),
          child: new CustomPaint(
            painter: new Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      )
    );
  }
}

class Signature extends CustomPainter {

  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.black;
    paint.strokeCap = StrokeCap.round;
    paint.strokeWidth = 5.0;
    for(int i=0;i<points.length-1;i++){
      if(points[i]!=null && points[i+1]!=null){
        canvas.drawLine(points[i],points[i+1],paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) {
    return oldDelegate.points!=points;
  }
}


