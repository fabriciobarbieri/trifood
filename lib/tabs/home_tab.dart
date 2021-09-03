import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  int photoIndex = 0;

  List<String> photos = [
    'lib/images/banner01.jpg',
    'lib/images/banner02.jpg',
    'lib/images/banner03.jpg'
  ];

  void _previousImage(){
    setState() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    }
  }

  void _nextImage(){
    setState() {
      photoIndex = photoIndex < photos.length -1 ? photoIndex + 1 : photoIndex;
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Carousel'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: AssetImage(photos[photoIndex]),
                            fit: BoxFit.cover)),
                    height: 400.0,
                    width: 300.0,
                  ),
                  Positioned(
                    top: 375.0,
                    left: 25.0,
                    right: 25.0,
                    child: SelectedPhoto(numberOfDots: photos.length, photoIndex: photoIndex),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Next'),
                  onPressed: _nextImage,
                  elevation: 5.0,
                  color: Colors.green,
                ),
                SizedBox(width: 10.0),
                RaisedButton(
                  child: Text('Prev'),
                  onPressed: _previousImage,
                  elevation: 5.0,
                  color: Colors.blue,
                )
              ],
            )
          ],
        ));
  }
}

class SelectedPhoto extends StatelessWidget {

  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4.0)
            ),
          ),
        )
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.0,
                    blurRadius: 2.0
                )
              ]
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for(int i = 0; i< numberOfDots; ++i) {
      dots.add(
          i == photoIndex ? _activePhoto(): _inactivePhoto()
      );
    }

    return dots;
  }


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {

    Widget _bluidBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 51, 153, 255),
            Color.fromARGB(255, 255, 255, 255)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    return Stack(
      children: <Widget>[
        _bluidBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: Color.fromARGB(255, 51, 153, 255),
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Tri Food'),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("home").orderBy("pos")
                  .getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData)
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  );
                else
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 1,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    staggeredTiles: snapshot.data.documents.map(
                        (doc){
                          return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                        }
                    ).toList(),
                    children: snapshot.data.documents.map(
                        (doc){
                          return FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage, image: doc.data["image"],
                            fit: BoxFit.cover,
                          );
                        }
                    ).toList(),
                  );
              },
            )
          ],
        )
      ],
    );
  }
