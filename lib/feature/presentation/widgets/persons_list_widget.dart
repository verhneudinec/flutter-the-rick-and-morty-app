import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_morty_app/feature/domain/entities/person_entity.dart';
import 'package:flutter_rick_morty_app/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_rick_morty_app/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:flutter_rick_morty_app/feature/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatelessWidget {
  const PersonsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        List<PersonEntity> persons = [];

        if (state is PersonLoading && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        } else if (state is PersonError) {
          return Text(state.message);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return PersonCard(person: persons[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[400],
              );
            },
            itemCount: persons.length,
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
