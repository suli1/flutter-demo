import 'package:flutter/material.dart';

class LayoutTutorialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text('Oeschinen Lake Campground',
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                      color: Colors.grey[500]
                  ),
                )
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );


    Color color = Theme
        .of(context)
        .primaryColor;

    Widget buttonSelection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSelection = Container(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    const String imageUrl = 'https://raw.githubusercontent.com/flutter/website/master/examples/layout/lakes/step5/images/lake.jpg';

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text('Layout tutorial')),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Image.network(imageUrl, height: 240, fit: BoxFit.fitWidth,),
                )
              ],
            ),
            titleSection,
            buttonSelection,
            textSelection,
            Container(
              margin: EdgeInsets.all(16),
              child: ParentWidget(),
            )
        ],
        ),
      ),
      onWillPop: () {
        print("layout on back pressed");
        return Future.value(true);
      },
    );
  }

  Widget _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color,),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
              icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleFavorite),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }

  void _toggleFavorite() =>
      setState(() {
        _isFavorited = !_isFavorited;
        if (_isFavorited) {
          _favoriteCount++;
        } else {
          _favoriteCount--;
        }
      });
}

class TabboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabboxAState();
}

class _TabboxAState extends State<TabboxA> {
  bool _active = false;

  void _handleTab() =>
      setState(() {
        _active = !_active;
      });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTab,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[500] : Colors.grey[500]
        ),
        child: Center(
            child: Text(
              _active ? 'Activie' : 'Inactive',
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
      ),

    );
  }

}


//-------------------------------- ParentWidget --------------------------//

class ParentWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ParentWidgetState();

}


class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTabboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabboxC(active: _active, onChanged: _handleTabboxChanged),
    );
  }
}

//-------------------------------- TabboxB --------------------------//

class TabboxB extends StatelessWidget {
  const TabboxB({Key key, this.active, this.onChanged}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: active ? Colors.lightGreen[700] : Colors.grey[700]
        ),
      ),
    );
  }

}


class TabboxC extends StatefulWidget {
  TabboxC({Key key, this.active, this.onChanged}) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() => _TabboxCState();
}

class _TabboxCState extends State<TabboxC> {
  bool _highlight = false;


  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[700],
            border: _highlight ? Border.all(color: Colors.teal[700], width: 10.0) : null
        ),
      ),
    );
  }

}
