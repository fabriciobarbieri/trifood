import 'package:flutter/material.dart';
import 'package:trifood/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {

    Widget _bluidDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 153, 204, 255),
                Color.fromARGB(255, 255,255,255)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _bluidDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 50.0,
                      child: Text("Tri Food App",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 60.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Olá,",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)
                          ),
                          ),
                          GestureDetector(
                            child: Text("Entre ou cadastre-se",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 51, 204, 51)
                            ),
                            ),
                            onTap: (){

                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController,3),
            ],
          )
        ],
      ),
    );
  }
}
