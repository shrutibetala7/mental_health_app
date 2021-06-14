import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:well_being_app/resources/color_palette.dart';

final podcastUrl = [
  'https://radiopublic.com/SleepWithMe',
  'https://hellofromthemagictavern.com/episodes',
  'https://player.fm/series/the-calm-collective-podcast',
  'https://www.bbc.co.uk/programmes/b008mj7p/episodes/downloads',
  'https://www.stitcher.com/show/nothing-much-happens-bedtime-stories-for-grownups',
  'https://calmer-you.com/category/podcast/',
  'https://www.podbean.com/podcast-detail/sd3f7-3b85d/The-Mindful-Podcast',
  'https://www.bbc.co.uk/programmes/p05k5bq0/episodes/player',
  'https://www.ahwayisland.com/episodes/'
];
final colorList = [
  bg_dark1,
  Colors.indigo,
  bg_dark2,
  bg_light2,
  journal_bg_dark1,
  journal_bg_light1,
  journal_bg_light2,
  journal_bg_dark2,
  journal_bg_light3
];

class PodcastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bg_light1,
        ),
        body: StaggeredGridView.countBuilder(
          itemCount: podcastUrl.length,
          crossAxisCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PodcastTile(podcastUrl[index]))),
                child: Container(
                  color: colorList[index],
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.gift, size: 50),
                  ),
                ));
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ));
  }
}

class PodcastTile extends StatefulWidget {
  final String url;
  PodcastTile(this.url);

  @override
  _PodcastTileState createState() => _PodcastTileState();
}

class _PodcastTileState extends State<PodcastTile> {
  @override
  Widget build(BuildContext context) {
    debugPrint("The url is ${widget.url}");
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: bg_light1,
          ),
          body: WebView(
            initialUrl: widget.url,
          )),
    );
  }
}
