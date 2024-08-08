import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:mobile_shop_flutter/views/first/signIn.dart';
import 'package:mobile_shop_flutter/views/second/account_center.dart';
import 'package:mobile_shop_flutter/views/second/home.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomMenu extends StatefulWidget{

  final Widget child;

  const BottomMenu({super.key, required this.child});

  @override
  State<BottomMenu> createState() => _BottomMenu();
}

class _BottomMenu extends State<BottomMenu>{

  late PageController _pageController;
  int _selectedIndex = 0;
  int _initialPage = 0;

  // final List<String> _titles = ['Home', 'Products', 'Cart', 'Account'];

  List<IconData> iconLst = [
    Icons.home,
    Icons.list,
    Icons.shopping_bag,
    Icons.person,
  ];

  List<Widget> pageLst = [
    const HomePage(),
    const SignIn(),
    const HomePage(),
    const AccountCenter(),
  ];

  int _findInitialPage(Widget child) {
    for (int i = 0; i < pageLst.length; i++) {
      if (pageLst[i].runtimeType == child.runtimeType) {
        return i;
      }
    }
    return -1;
  }

  @override
  void initState() {
    super.initState();
    _initialPage = _findInitialPage(widget.child);

    if(_initialPage==-1){
      _selectedIndex = 0;
    }else {_selectedIndex = _initialPage;}

    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _onPageChanged(index);
  }

  void _onPageChanged(int index){
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: pageLst,
        ),

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey[200]!, blurRadius: 10,)
            ]
          ),

          child: SalomonBottomBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: (i) => setState(() { 
              _onItemTapped(i); 
            }),
            items: [
              //Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home), 
                title: Text('Home', style: itemMenu,),
                selectedColor: mainColor
              ),

              //Setting
              SalomonBottomBarItem(
                icon: const Icon(Icons.settings), 
                title: const Text('Settings'),
                selectedColor: mainColor
              ),

              //Cart
              SalomonBottomBarItem(
                icon: const Icon(Icons.shopping_bag), 
                title: const Text('Bag'),
                selectedColor: mainColor
              ),
              
              //Account
              SalomonBottomBarItem(
                icon: const Icon(Icons.person), 
                title: const Text('Account'),
                selectedColor: mainColor
              ),
            ]
          ),
        )
      ),
    );
  }

}