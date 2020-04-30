import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Function fetch;

  VideoTile({this.id, this.title, this.imageUrl, this.fetch});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => fetch(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 300,
                    color: Colors.black38,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 50,
                    color: Colors.black54,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "33:55",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Autocar',
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.visibility,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text('1m views')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          '2 months ago',
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
