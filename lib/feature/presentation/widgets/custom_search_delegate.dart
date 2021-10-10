import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_morty_app/feature/domain/usecases/search_person.dart';
import 'package:flutter_rick_morty_app/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_rick_morty_app/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:flutter_rick_morty_app/feature/presentation/bloc/search_bloc/search_state.dart';
import 'package:flutter_rick_morty_app/feature/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Character search..');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_sharp),
      tooltip: 'Back',
      onPressed: () => close(context, []),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(context, listen: false)
      ..add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (context, state) {
        if (state is PersonSearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonSearchLoaded) {
          final List<PersonEntity> persons = state.persons;
          if (persons.isEmpty) {
            return Text('No characters with that name');
          }
          return Container(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: persons.isNotEmpty ? persons.length : 0,
              itemBuilder: (context, index) {
                PersonEntity result = persons[index];
                return SearchResult(personResult: result);
              },
            ),
          );
        } else if (state is PersonSearchError) {
          return Text(state.message);
        } else {
          return Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        return Text(
          _suggestions[index],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _suggestions.length,
    );
  }
}
