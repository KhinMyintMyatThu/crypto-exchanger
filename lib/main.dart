import 'package:flutter/material.dart';
import 'package:flutter_app/logics/blocs/currency/currency_bloc.dart';
import 'package:flutter_app/presentation/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CurrencyBloc()..add(LoadCurrencies()),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
            onGenerateRoute: _appRouter.onGeneratedRoute,
          );
        }));
  }
}
