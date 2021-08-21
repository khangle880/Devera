import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:asking/amplifyconfiguration.dart';
import 'package:asking/app_navigator.dart';
import 'package:asking/data_repository.dart';
import 'package:asking/loading_view.dart';
import 'package:asking/models/ModelProvider.dart';
import 'package:asking/screens/auth/auth_repository.dart';
import 'package:asking/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigure = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
          home: MultiRepositoryProvider(
              providers: [
            RepositoryProvider(
              create: (context) => AuthRepository(),
            ),
            RepositoryProvider(
              create: (context) => DataRepository(),
            ),
          ],
              child: _isAmplifyConfigure
                  ? BlocProvider(
                      create: (context) => SessionCubit(
                          authRepo: context.read<AuthRepository>(),
                          dataRepo: context.read<DataRepository>()),
                      child: AppNavigator())
                  : LoadingView())),
      designSize: Size(375, 812),
    );
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAPI()
      ]);

      await Amplify.configure(amplifyconfig);
      setState(() {
        _isAmplifyConfigure = true;
      });
    } catch (e) {}
  }
}
