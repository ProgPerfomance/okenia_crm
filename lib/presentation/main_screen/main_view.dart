import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okenia_crm/presentation/blog/blog_list/blog_list_view.dart';
import 'package:okenia_crm/presentation/main_screen/main_viewmodel.dart';
import 'package:okenia_crm/presentation/recept/recept_view.dart';
import 'package:provider/provider.dart';

import '../product/products_list/products_list_view.dart';

List<Widget> screens = [Scaffold(),ProductsListView(),BlogListView(), ReceptView()];

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<MainViewmodel>(context);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 80.0),
            child: screens[viewmodel.pageIndex],
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,

              decoration: BoxDecoration(color: Color(0xff315363)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    NavBarButton(index: 0, icon: Icons.home,),
                    SizedBox(height: 24),
                    NavBarButton(index: 1, icon:  CupertinoIcons.cube_box,),
                    SizedBox(height: 24),
                    NavBarButton(index: 2, icon:  CupertinoIcons.arrow_up_doc,),
                    SizedBox(height: 24),
                    NavBarButton(index: 3, icon:  Icons.emoji_food_beverage,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class NavBarButton extends StatelessWidget {
  final int index;
  final IconData icon;
  const NavBarButton({super.key,required this.index,required this.icon});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<MainViewmodel>(context);
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            color: viewmodel.pageIndex == index ? Colors.black.withAlpha(30) : null,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: Colors.white, size: 38),
          )),
      onTap: () {
        viewmodel.selectPage(index);
      },
    );
  }
}
