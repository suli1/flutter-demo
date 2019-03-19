import 'package:flutter/material.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class Photo {
  Photo(this.assetName, {this.title});

  final String assetName;
  final String title;
}

class GridDemo extends StatefulWidget {
  static const routeName = '/grid';

  @override
  State<StatefulWidget> createState() => GridDemoState();
}

class GridDemoState extends State<GridDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid View'),
      ),
      body: _buildGrid(),
    );
  }

  Widget _buildGrid() => GridView.count(
        padding: EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: 3,
        children: images.map<Widget>((Photo photo) {
          return Container(
            child: Image.asset(
              photo.assetName,
              package: _kGalleryAssetsPackage,
            ),
          );
        }).toList(),
      );

//  List<Container> _buildGridTileList(int count) => List.generate(
//      count,
//      (i) => Container(
//            child: Image.asset('images/pic$i.jpg'),
//          ));

  List<Photo> images = <Photo>[
    Photo('places/india_chennai_flower_market.png'),
    Photo('places/india_tanjore_bronze_works.png'),
    Photo('places/india_tanjore_market_merchant.png'),
    Photo('places/india_tanjore_thanjavur_temple.png'),
    Photo('places/india_tanjore_thanjavur_temple_carvings.png'),
    Photo('places/india_pondicherry_salt_farm.png')
  ];
}

class ListDemo extends StatefulWidget {
  static const routeName = '/list';

  @override
  State<StatefulWidget> createState() => ListDemoState();
}

class ListDemoState extends State<ListDemo> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('List View'),
        ),
        body: _buildStack(),
      );

  Widget _buildList() => ListView(
        children: <Widget>[
          _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
          _tile('The Castro Theater', '429 Castro St', Icons.theaters),
          _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
          _tile('Roxie Theater', '3117 16th St', Icons.theaters),
          _tile('United Artists Stonestown Twin', '501 Buckingham Way', Icons.theaters),
          _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
          Divider(),
          _tile('Kescaped_code#39;s Kitchen', '757 Monterey Blvd', Icons.restaurant),
          _tile('Emmyescaped_code#39;s Restaurant', '1923 Ocean Ave', Icons.restaurant),
          _tile('Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
          _tile('La Ciccia', '291 30th St', Icons.restaurant),
        ],
      );

  ListTile _tile(String title, String subTitle, IconData icon) => ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        subtitle: Text(subTitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

  Widget _buildStack() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.red,
                  minRadius: 80,
                  maxRadius: 110,
                  backgroundImage: AssetImage('images/pic1.jpg'),
                  child: Text('child'),
                ),
//              Container(
//                decoration: BoxDecoration(color: Colors.black12),
//                child: Text(
//                  'Dogger',
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 20,
//                    color: Colors.white,
//                  ),
//                ),
//              )
              ],
            )
          ]);

  Widget _buildCard() => SizedBox(
        child: Card(
          margin: EdgeInsets.all(16),
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('1625 Main Street', style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('My City, CA 99984'),
                leading: Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue[500],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('(408) 555-1212', style: TextStyle(fontWeight: FontWeight.w500)),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: Text('costa@example.com'),
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      );
}
