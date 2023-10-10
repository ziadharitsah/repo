import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(UserData());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      state.models.user.profilePhotoUrl,
                      scale: 10.0),
                ),
              ),
              title: Text("Nama : ${state.models.user.name}"),
              actions: [
                IconButton(
                    icon: const Icon(EvaIcons.logOutOutline),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        LoggedOut(),
                      );
                    })
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.models.user.email),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      image: state.models.user.profilePhotoUrl != 'fasle'
                          ? DecorationImage(
                              image: NetworkImage(
                                  state.models.user.profilePhotoUrl),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              scale: 10.0,
                              image: NetworkImage(
                                'assets/images/photo_border.png',
                              ),
                            ),
                    ),
                  ),
                  ImageNetwork(
                    image: state.models.user.profilePhotoUrl,
                    height: 150,
                    width: 150,
                    duration: 1500,
                    curve: Curves.easeIn,
                    onPointer: true,
                    debugPrint: true,
                    fullScreen: false,
                    fitAndroidIos: BoxFit.cover,
                    fitWeb: BoxFitWeb.cover,
                    borderRadius: BorderRadius.circular(70),
                    onLoading: const CircularProgressIndicator(
                      color: Colors.indigoAccent,
                    ),
                    onError: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    onTap: () {
                      debugPrint("©gabriel_patrick_souza");
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(
            child: CircularProgressIndicator(
          color: Colors.amber,
        ));
      },
    );
  }
}
