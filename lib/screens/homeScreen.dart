import 'package:curated/widgets/videoTile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return VideoTile(
              id: "1",
              title: "Skoda Octavia",
              imageUrl:
                  "https://i.ytimg.com/vi/bHDtxj5YDNs/hqdefault.jpg?sqp=-oaymwEYCKgBEF5IVfKriqkDCwgBFQAAiEIYAXAB&rs=AOn4CLCnVjhI-mMTOrZ5qvo_csv5ZRFwag");
        },
        itemCount: 5);
  }
}
