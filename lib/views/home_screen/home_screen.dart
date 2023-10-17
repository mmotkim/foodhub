import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodhub/auth/controllers/api_auth_controller.dart';
import 'package:foodhub/auth/controllers/auth_controller.dart';
import 'package:foodhub/models/user_entity.dart';
import 'package:foodhub/routes/app_router.gr.dart';
import 'package:foodhub/styles/custom_texts.dart';
import 'package:foodhub/system/system_controller.dart';
import 'package:foodhub/utils/app_state.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _useFirebaseAuth;
  late Future<String?> _provider;
  String provider = '';
  UserEntity? userData;

  @override
  void initState() {
    super.initState();

    _useFirebaseAuth = context.read<ApplicationState>().useFirebaseAuth;
    _useFirebaseAuth
        ? {_provider = Provider.of<AuthController>(context, listen: false).getProviderName()}
        : {
            _provider = getApiProvider(),
            userData = context.read<ApiAuthController>().getUserData(),
          };
  }

  Future<String> getApiProvider() async {
    return 'API anh thành';
  }

  @override
  Widget build(BuildContext context) {
    //await context.read<AuthController>().getProviderName()
    final systemController = Provider.of<SystemController>(context, listen: false);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                //Get user provider
                child: FutureBuilder<String?>(
                  future: _provider,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      systemController.showLoading();
                      return const SizedBox(height: 20);
                    } else if (snapshot.hasData) {
                      systemController.dismiss();
                      provider = snapshot.data!;
                      print(snapshot.data!);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: _homeContent(context),
                      );
                    } else if (snapshot.hasError) {
                      systemController.dismiss();
                      return Text(snapshot.error.toString());
                    } else {
                      systemController.showLoading();
                      return const SizedBox(height: 20);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _homeContent(BuildContext context) {
    return <Widget>[
      const SizedBox(height: 400),
      Text(
        'Logged in as $provider',
        style: CustomTextStyle.labellarge(context),
      ),
      _useFirebaseAuth ? const UserInfo() : ApiUserInfo(userEntity: userData!),
      const SizedBox(height: 30),
      if (provider == 'Email/Password') _resetPasswordButton(context),
      TextButton(
        onPressed: () {
          _signOut();
          context.router.replace(const WelcomeRoute());
        },
        child: Text('Sign the fuck out', style: CustomTextStyle.labellarge(context)),
      ),
      const SizedBox(height: 30),
      const TextField(),
    ];
  }

  Widget _resetPasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.router.push(const RetypePasswordRoute());
      },
      child: Text('Change password', style: CustomTextStyle.labellarge(context)),
    );
  }

  void _signOut() {
    _useFirebaseAuth ? context.read<AuthController>().signOut() : context.read<ApiAuthController>().signOut();
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      'name ${context.watch<AuthController>().getCurrentUser()?.displayName}\n'
      'email ${context.watch<AuthController>().getCurrentUser()?.email}\n'
      'phone ${context.watch<AuthController>().getCurrentUser()?.phoneNumber}\n'
      'mailVerified ${context.watch<AuthController>().getCurrentUser()?.emailVerified}\n'
      'uid ${context.watch<AuthController>().getCurrentUser()?.uid}\n',
      key: const Key('counterState'),
      style: CustomTextStyle.labellarge(context),
    );
  }
}

class ApiUserInfo extends StatelessWidget {
  const ApiUserInfo({super.key, required this.userEntity});
  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Text(
      /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
      'name ${userEntity.userName}\n'
      'email ${userEntity.email}\n'
      'phone ${userEntity.phoneNumber}\n'
      'mailVerified ${userEntity.isVerifiedEmail}\n'
      'uid ${userEntity.id}\n',
      style: CustomTextStyle.labellarge(context),
    );
  }
}
