import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/bloc/auth/app_auth_bloc.dart';
import 'package:gadgets_marketplace/bloc/explore/cubits/show_search_category_cubit.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/cubits/bottom_nav_cubit.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/cubits/search_header_cubit.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/cubits/update_index_cubit.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/product_filter_bloc.dart';
import 'package:gadgets_marketplace/views/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://hkvkogexqerbikcrjyka.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhrdmtvZ2V4cWVyYmlrY3JqeWthIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODUwMzkyMDMsImV4cCI6MjEwMDYxNTIwM30.AD23C5ZjGpWPGmvjHf2UrGtJD22G5QLcl-ue9EcNG90",
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppAuthBloc>(create: (context) => AppAuthBloc()),
        BlocProvider<ProductFilterBloc>(
          create: (context) => ProductFilterBloc(),
        ),
        BlocProvider<UpdateIndexCubit>(create: (context) => UpdateIndexCubit()),

        BlocProvider<SearchHeaderCubit>(
          create: ((context) => SearchHeaderCubit()),
        ),
        BlocProvider<BottomNavCubit>(create: ((context) => BottomNavCubit())),
        BlocProvider<ShowSearchCategoryCubit>(
          create: ((context) => ShowSearchCategoryCubit()),
        ),
      ],
      child: const GadgetMarketplaceApp(),
    ),
  );
}

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => CounterBloc()),
//         BlocProvider(create: ((context) => ChangeThemeBloc())),
//       ],
//       child: BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
//         builder: (context, state) {
//           return MaterialApp(
//             theme: state.isChangeTheme ? ThemeData.dark() : ThemeData.light(),
//             home: CounterApp(),
//           );
//         },
//       ),
//     ),
//   );
// }

// class CounterApp extends StatefulWidget {
//   const CounterApp({super.key});

//   @override
//   State<CounterApp> createState() => _CounterAppState();
// }

// class _CounterAppState extends State<CounterApp> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               onPressed: () {
//                 context.read<CounterBloc>().add(IncrementEvent());
//               },
//               icon: Icon(Icons.add),
//             ),
//             IconButton(
//               onPressed: () {
//                 context.read<CounterBloc>().add(DecrementEvent());
//               },
//               icon: Icon(Icons.minimize),
//             ),

//             Center(
//               child: BlocBuilder<CounterBloc, CounterState>(
//                 builder: (context, state) {
//                   return Text(
//                     state.count.toString(),
//                     style: TextStyle(fontSize: 24),
//                   );
//                 },
//               ),
//             ),

//             BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
//               builder: (context, state) {
//                 return Switch(
//                   value: state.isChangeTheme,
//                   onChanged: ((value) {
//                     context.read<ChangeThemeBloc>().add(ToggleThemeEvent());
//                   }),
//                 );
//               },
//             ),

//             BlocBuilder<ChangeThemeBloc, ChangeThemeState>(
//               builder: (context, state) {
//                 return IconButton(
//                   onPressed: () {
//                     context.read<ChangeThemeBloc>().add(ToggleThemeEvent());
//                   },
//                   icon: state.isChangeTheme
//                       ? Icon(Icons.visibility_off)
//                       : Icon(Icons.visibility),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CounterState {
//   int count;
//   CounterState({required this.count});
// }

// abstract class CounterEvent {}

// class IncrementEvent extends CounterEvent {}

// class DecrementEvent extends CounterEvent {}

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(CounterState(count: 0)) {
//     on<IncrementEvent>((event, emit) {
//       emit(CounterState(count: state.count + 1));
//     });
//     on<DecrementEvent>((event, emit) {
//       emit(CounterState(count: state.count - 1));
//     });
//   }
// }

// //// Light-Dark Theme Bloc Logic
// class ChangeThemeState {
//   bool isChangeTheme;
//   ChangeThemeState({required this.isChangeTheme});
// }

// abstract class ChangeThemeEvent {}

// class ToggleThemeEvent extends ChangeThemeEvent {}

// class ChangeThemeBloc extends Bloc<ChangeThemeEvent, ChangeThemeState> {
//   ChangeThemeBloc() : super(ChangeThemeState(isChangeTheme: false)) {
//     on<ToggleThemeEvent>((event, emit) {
//       emit(ChangeThemeState(isChangeTheme: !state.isChangeTheme));
//     });
//   }
// }
