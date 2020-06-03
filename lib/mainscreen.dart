import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:visitmalaysia/destination.dart';
import 'package:visitmalaysia/infopage.dart';
import 'package:progress_dialog/progress_dialog.dart';

void main() => runApp(Mainscreen());

class Mainscreen extends StatefulWidget {
  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  String curtype = "All Searching..";
  String cartquantity = "2";
  List destinations;
  double screenHeight, screenWidth;
  String titlecenter = "";
  bool _visible = true;

  String currentState = "Kedah";
  // String dropdown = "Search State";
  List places;

  var _statelist = [
    'Johor',
    'Kedah',
    'Kelantan',
    'Perak',
    'Selangor',
    'Melaka',
    'Negeri Sembilan',
    'Pahang',
    'Perlis',
    'Penang',
    'Sabah',
    'Sarawak',
    'Terengganu'
  ];

  @override
  void initState() {
    super.initState();
    
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    void _selectState(String state) {
      try {
        ProgressDialog pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal,
            isDismissible: true,
            showLogs: true);
        pr.style(message: "Searching...");
        pr.show();
        String urlLoadJobs =
            "http://slumberjer.com/visitmalaysia/load_destinations.php";
        http.post(urlLoadJobs, body: {
          "state": state,
        }).then((res) {
          setState(() {
            currentState = state;
            var extractdata = json.decode(res.body);
            places = extractdata["locations"];
            FocusScope.of(context).requestFocus(new FocusNode());
            pr.hide().then((isHidden) {
              print(isHidden);
            });
          });
        }).catchError((err) {
          print(err);
          pr.hide().then((isHidden) {
            print(isHidden);
          });
        });
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      } catch (e) {
        Toast.show("Error", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
      
    }

    

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'DESTINATION',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            DropdownButton<String>(
              icon: Icon(Icons.expand_more),
              iconSize: 50,
              underline: Container(
                color: Colors.white,
              ),
              items: _statelist.map((String states) {
                return DropdownMenuItem<String>(
                  value: states,
                  child: Text(
                    states,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                  ),
                );
              }).toList(),
              onChanged: (String currState) {
                _selectState(currState);

                
              },
            ),

            IconButton(
              icon: _visible
                  ? new Icon(Icons.expand_more)
                  : new Icon(Icons.expand_less),
              onPressed: () {
                setState(() {
                  if (_visible) {
                    _visible = false;
                  } else {
                    _visible = true;
                  }
                });
              },
            ),

            //
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(curtype,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              destinations == null
                  ? Flexible(
                      child: Container(
                          child: Center(
                              child: Text(
                      titlecenter,
                      style: TextStyle(
                          color: Color.fromRGBO(101, 255, 218, 50),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ))))
                  : Expanded(
                      child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (screenWidth / screenHeight) / 0.8,
                          children: List.generate(destinations.length, (index) {
                            return Container(
                                child: Card(
                                    elevation: 10,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () => _onImageDisplay(index),
                                            child: Container(
                                              height: screenHeight / 4.0,
                                              width: screenWidth / 3.0,
                                              child: ClipOval(
                                                  child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl:
                                                    "http://slumberjer.com/visitmalaysia/images/${destinations[index]['imagename']}",
                                                placeholder: (context, url) =>
                                                    new CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              )),
                                            ),
                                          ),
                                          Text(destinations[index]['imagename'],
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          Text(
                                            destinations[index]['loc_name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            destinations[index]['state'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )));
                          })))
            ],
          ),
        ),
      ),
    );
  }

  void _loadData() {
    String urlLoadJobs =
        "http://slumberjer.com/visitmalaysia/load_destinations.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        destinations = extractdata["locations"];
      });
    }).catchError((err) {
      print(err);
    });
  }

  _onImageDisplay(int index) async {
    print(destinations[index]['name']);
    Destination destination = new Destination(
        pid: destinations[index]['pid'],
        loc_name: destinations[index]['loc_name'],
        state: destinations[index]['state'],
        description: destinations[index]['description'],
        latitude: destinations[index]['latitude'],
        longitude: destinations[index]['longitude'],
        url: destinations[index]['url'],
        contact: destinations[index]['contact'],
        address: destinations[index]['address'],
        imagename: destinations[index]['imagename']);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Infopage(
                  destination: destination,
                )));
    _loadData();
  

    
  }
}
