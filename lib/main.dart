import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icon/amplifyconfiguration.dart';
import 'package:icon/app_navigator.dart';
import 'package:icon/models/ModelProvider.dart';
import 'package:icon/repositories/auth_repository.dart';
import 'package:icon/repositories/data_repository.dart';
import 'package:icon/session/session_cubit.dart';

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
    _configureIconNetwork();
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
        child: Scaffold(
            body: _isAmplifyConfigure
                ? BlocProvider(
                    create: (context) => SessionCubit(
                        authRepo: context.read<AuthRepository>(),
                        dataRepo: context.read<DataRepository>()),
                    child: AppNavigator())
                : Center(child: CircularProgressIndicator())),
      )),
      designSize: Size(375, 812),
    );
  }

  Future<void> _configureIconNetwork() async {
    await FlutterIconNetwork.instance?.init(
        host: "https://bicon.net.solidwallet.io/api/v3", isTestNet: true);
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAPI(),
      ]);

      await Amplify.configure(amplifyconfig);
      setState(() {
        _isAmplifyConfigure = true;
      });
    } catch (e) {
      print(e);
    }
  }
}
