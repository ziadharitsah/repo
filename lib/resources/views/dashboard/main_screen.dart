import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:app/resources/views/posts/story.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;

  static const List _pages = [
    Story(),
    Center(
      child: Text("About"),
    ),
    Center(
      child: Text("Products"),
    ),
    Center(
      child: Text("Contact"),
    ),
    Center(
      child: Text("Settings"),
    ),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(UserData());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserLoaded) {
          return Scaffold(
            body: _pages[_selectedTab],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 30.0,
              currentIndex: _selectedTab,
              onTap: (index) => _changeTab(index),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                    activeIcon: Icon(EvaIcons.home),
                    icon: Icon(EvaIcons.homeOutline),
                    label: "Home"),
                BottomNavigationBarItem(
                    activeIcon: Icon(EvaIcons.search),
                    icon: Icon(EvaIcons.searchOutline),
                    label: "About"),
                BottomNavigationBarItem(
                    activeIcon: Icon(EvaIcons.video),
                    icon: Icon(EvaIcons.videoOutline),
                    label: "Product"),
                BottomNavigationBarItem(
                    activeIcon: Icon(EvaIcons.shoppingBag),
                    icon: Icon(EvaIcons.shoppingBagOutline),
                    label: "Contact"),
                BottomNavigationBarItem(
                    activeIcon: Icon(EvaIcons.person),
                    icon: Icon(EvaIcons.personOutline),
                    label: "Settings"),
              ],
            ),
          );
        }

        return const Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
        ));
      },
    );
  }
}
