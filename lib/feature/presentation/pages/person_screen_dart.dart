import 'package:flutter/material.dart';
import 'package:flutter_rick_morty_app/common/app_colors.dart';
import 'package:flutter_rick_morty_app/feature/presentation/widgets/custom_search_delegate.dart';
import 'package:flutter_rick_morty_app/feature/presentation/widgets/persons_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          ),
        ],
      ),
      backgroundColor: AppColors.mainBackground,
      body: PersonsList(),
    );
  }
}
