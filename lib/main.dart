import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_morty_app/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:flutter_rick_morty_app/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_rick_morty_app/feature/presentation/pages/person_screen_dart.dart';
import 'locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
          create: (context) => di.sl<PersonListCubit>(),
        ),
        BlocProvider<PersonSearchBloc>(
          create: (context) => di.sl<PersonSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        theme: ThemeData.dark().copyWith(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey,
        ),
        home: HomePage(),
      ),
    );
  }
}
