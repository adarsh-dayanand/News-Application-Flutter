import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app/bloc/bottom_navbar_bloc.dart';
import 'package:news_app/screens/tabs/home_screen.dart';
import 'package:news_app/screens/tabs/search_screen.dart';
import 'package:news_app/screens/tabs/sources_screen.dart';
import 'package:news_app/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavBarBloc _bottomNavBarBloc;
  @override
  void initState() {
    _bottomNavBarBloc = BottomNavBarBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Style.Colors.mainColor,
          title: Text(
            "News Application",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          // ignore: missing_return
          builder: (BuildContext context,  AsyncSnapshot<NavBarItem> snapshot){
            switch(snapshot.data){
              case NavBarItem.HOME:
                return HomeScreen();
              case NavBarItem.SOURCES:
                return SourceScreen();
              case NavBarItem.SEARCH:
                return SearchScreen();
            }
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context,  AsyncSnapshot<NavBarItem> snapshot){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[100], spreadRadius: 0, blurRadius: 10.0
                ),
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: 20,
                unselectedItemColor: Style.Colors.grey,
                unselectedFontSize: 10.0,
                selectedFontSize: 10.0,
                type: BottomNavigationBarType.fixed,
                fixedColor: Style.Colors.mainColor,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Home"
                      ),
                    ),
                    icon: Icon(EvaIcons.homeOutline),
                    activeIcon: Icon(EvaIcons.home),
                  ),

                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Sources"
                      ),
                    ),
                    icon: Icon(EvaIcons.gridOutline),
                    activeIcon: Icon(EvaIcons.grid),
                  ),

                  BottomNavigationBarItem(
                    title: Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Search"
                      ),
                    ),
                    icon: Icon(EvaIcons.searchOutline),
                    activeIcon: Icon(EvaIcons.search),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget testScreen(){
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Test Screen")
        ],
      ),
    );
  }
}
