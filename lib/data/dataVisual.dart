import 'package:flutter/material.dart';

class DataVisual extends StatefulWidget {
  @override
  State<DataVisual> createState() => _DataVisualState();
}

class _DataVisualState extends State<DataVisual> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedIndex,
      child: Scaffold(

        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          elevation: 10,
          shadowColor: Colors.black,
          title: Text(
            "Data Visual Screen",
            style: TextStyle(color: Colors.white),
          ),

          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.bar_chart),
                text: 'Bar Chart',
              ),
              Tab(
                icon: Icon(Icons.show_chart),
                text: 'Line Chart',
              ),
            ],
          ),
        ),

        //  body: TabBarView(
        //    children: <Widget>[
        //      Container(child: Center(child: Text('Bar Chart Tab'))),
        //       Container(child: Center(child: Text('Line Chart Tab'))),
        //     ],
        //    ),

        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   backgroundColor: Colors.black,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.list),
        //       label: 'Data List',
        //     ),
        //
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.bar_chart),
        //       label: 'Data Visual',
        //     ),
        //
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.account_circle),
        //       label: 'Profiles',
        //     ),
        //   ],
        //
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.white,
        //   unselectedItemColor: Colors.grey.shade800,
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   if (index == 0) {
  //     Navigator.pushNamed(context, '/dataList');
  //   } else if (index == 2) {
  //     Navigator.pushNamed(context, '/profiles');
  //   }
  // }
}
