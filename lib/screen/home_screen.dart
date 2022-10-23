import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player_app/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: video == null ? renderEmpty() : renderVideo()),
    );
  }

  Widget renderVideo() {
    return CustomVideoPlayer(
      video: video!,
      onVideoPressed: onNewVideoPressed,
    );
  }

  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          SizedBox(height: 30.0),
          _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }
}

BoxDecoration getBoxDecoration() {
  return const BoxDecoration(
      gradient: LinearGradient(
    colors: [
      Color(0xff2a3a7c),
      Color(0xff000118),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ));
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('VIDEO', style: textStyle),
        Text('PLAYER',
            style: textStyle.copyWith(
              fontWeight: FontWeight.w700,
            ))
      ],
    );
  }
}
