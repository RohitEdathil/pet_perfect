import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_perfect/posts/model/post_bloc.dart';
import 'package:pet_perfect/posts/model/posts_repo.dart';

import 'package:pet_perfect/woof/model/woof_bloc.dart';
import 'package:pet_perfect/woof/model/woof_repo.dart';
import 'package:pet_perfect/woof/woof_view.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const PetPerfectApp());
}

class PetPerfectApp extends StatelessWidget {
  const PetPerfectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Providers go here
        BlocProvider<WoofBloc>(create: (context) => WoofBloc()),
        BlocProvider<PostsBloc>(create: (context) => PostsBloc()),
      ],
      child: MultiRepositoryProvider(
        providers: [
          // Repositories go here
          RepositoryProvider<WoofRepo>(create: (context) => WoofRepo()),
          RepositoryProvider<PostsRepo>(create: (context) => PostsRepo()),
        ],
        child: const MaterialApp(
          home: WoofView(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
