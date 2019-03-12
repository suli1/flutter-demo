import 'package:flutter/material.dart';

class LayoutTutorialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(title: Text('Layout tutorial')),
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: Colors.greenAccent),
                  Icon(Icons.favorite, color: Colors.redAccent),
                  Icon(Icons.favorite, color: Colors.blueAccent),
                  Icon(Icons.favorite, color: Colors.pinkAccent),
                ],
              ),
//            new Column(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Image(
//                  image: NetworkImage(
//                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551548525467&di=65af99fe9f46c4f104460ae319bc6ebc&imgtype=0&src=http%3A%2F%2Fwww.cad.zju.edu.cn%2Fhome%2Fgfzhang%2Ftraining%2FMatting%2Fpeacock.png"),
//                  fit: BoxFit.contain,
//                ),
//                Image(
//                  image: NetworkImage(
//                      "https://photo.16pic.com/00/07/66/16pic_766006_b.jpg"),
//                  fit: BoxFit.fill,
//                ),
//                Image(
//                  image: NetworkImage(
//                      "http://whocollect-auctions.b0.upaiyun.com/b/a/8/c/ba8c54f807fab2e62ed8035343b1c0fe.jpg"),
//                  fit: BoxFit.fill,
//                ),
//              ],
//            )
              _buildImageColumn(),
              Image.asset(
                'images/pic1.jpg',
                width: 100,
                height: 100,
              )
            ],
          )),
      onWillPop: () {
        print("layout on back pressed");
        return Future.value(true);
      },
    );
  }

// #docregion column
  Widget _buildImageColumn() => Container(
        decoration: BoxDecoration(
          color: Colors.black26,
        ),
        child: Column(
          children: [
            _buildImageRow(1),
            _buildImageRow(3),
          ],
        ),
      );

// #enddocregion column

// #docregion row
  Widget _buildDecoratedImage(int imageIndex) => Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.black38),
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
          ),
          margin: const EdgeInsets.all(4),
          child: Image.asset('images/pic$imageIndex.jpg'),
        ),
      );

  Widget _buildImageRow(int imageIndex) => Row(
        children: [
          _buildDecoratedImage(imageIndex),
          _buildDecoratedImage(imageIndex + 1),
        ],
      );
// #enddocregion row

}
