import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visitmalaysia/destination.dart';


void main() => runApp(Infopage());

class Infopage extends StatefulWidget {
  final Destination destination;
  const Infopage({Key key, this.destination}) : super(key: key);

  @override
  _InfopageState createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('INFO PAGE'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(height: 70),
            Container(
              height: screenHeight / 3,
              width: screenWidth / 1.1,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    "http://slumberjer.com/visitmalaysia/images/${widget.destination.imagename}",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            SizedBox(height: 6),
            Container(
              width: screenWidth / 1.1,
              //height: screenHeight / 2,
              child: Card(
                elevation: 6,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    Table(defaultColumnWidth: FlexColumnWidth(1.0), children: [
                      TableRow(children: [
                        TableCell(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text("DESCRIPTION",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ))),
                        ),
                        TableCell(
                            child: Container(
                          height: 65,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text(
                                ":  " + widget.destination.description,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )),
                        )),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 25,
                              child: Text("URL",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ))),
                        ),
                        TableCell(
                            child: Container(
                          height: 50,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              child: Text(
                                ":  " + widget.destination.url,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )),
                        )),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text("ADDRESS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ))),
                        ),
                        TableCell(
                            child: Container(
                          height: 30,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text(
                                ":  " + widget.destination.address,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )),
                        )),
                      ]),
                      TableRow(children: [
                        TableCell(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Text("CONTACT",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ))),
                        ),
                        TableCell(
                          child: Container(
                              height: 30,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 30,
                                child: Text(":  " + widget.destination.contact,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              )),
                        ),
                      ]),
                    ]),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}