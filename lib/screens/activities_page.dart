import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:well_being_app/resources/color_palette.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1524901548305-08eeddc35080?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
  'https://images.unsplash.com/photo-1465966670031-e4ea86442ed5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80',
  'https://images.unsplash.com/photo-1541296434114-65d3360d5772?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
  'https://images.unsplash.com/photo-1517855695349-6129cbc80a0d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1504&q=80',
  'https://images.unsplash.com/photo-1570514865285-2de0d16e3efc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=926&q=80',
  'https://images.unsplash.com/photo-1480072723304-5021e468de85?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=752&q=80',
  'https://images.unsplash.com/photo-1525610396350-580c98513a9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80'
];

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(item, fit: BoxFit.cover)),
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.only(bottom: 20),
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.30,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
              ),
            ),
            Wrap(
              spacing: 30,
              runSpacing: 20,
              children: [
                homeTile(journal_bg_dark2, FontAwesomeIcons.userFriends,
                    'assets/icons/chatbot.svg', 'chatbotScreen'),
                homeTile(journal_bg_dark1, FontAwesomeIcons.dog,
                    'assets/icons/meditation.svg', ''),
                homeTile(journal_bg_light2, FontAwesomeIcons.solidSmileBeam,
                    'assets/icons/yoga.svg', ''),
                homeTile(journal_bg_light1, FontAwesomeIcons.clock,
                    'assets/icons/todo.svg', 'pomodoroScreen'),
                homeTile(
                    bg_light1, FontAwesomeIcons.podcast, null, 'PodcastScreen'),
                homeTile(bg_light2, FontAwesomeIcons.yinYang, null, ''),
                homeTile(bg_dark1, FontAwesomeIcons.book,
                    'assets/icons/book.svg', 'ebookScreen'),
                homeTile(bg_dark2, FontAwesomeIcons.map, null, 'nearbyWidget'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  homeTile(Color color, IconData icon, String path, String destination) {
    List<double> _stops = [0.0, 0.2, 1.6];
    return GestureDetector(
      child: Container(
        //margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: MediaQuery.of(context).size.width / 2.3,
        width: MediaQuery.of(context).size.width / 2.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [Colors.white, color, color.withBlue(5000)],
              //stops: _stops
            )),
        child: path == null
            ? Center(child: FaIcon(icon, size: 120, color: Colors.white))
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(path, color: Colors.white),
              ),
      ),
      onTap: () => Navigator.pushNamed(context, destination),
    );
  }
}
