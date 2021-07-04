import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:well_being_app/resources/color_palette.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

final eBookUrl = [
  'http://www.moodcafe.co.uk/media/15343/ER_handout_Final_16_June_2016%20pdf.pdf',
  'http://www.moodcafe.co.uk/media/15343/ER_handout_Final_16_June_2016%20pdf.pdf'
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

class EbookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bg_light1,
        ),
        body: StaggeredGridView.countBuilder(
          itemCount: eBookUrl.length,
          crossAxisCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EbookTile(eBookUrl[index]))),
                child: Container(
                  color: colorList[index],
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.bookReader, size: 50),
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

class EbookTile extends StatefulWidget {
  final String url;
  EbookTile(this.url);

  @override
  _EbookTileState createState() => _EbookTileState();
}

class _EbookTileState extends State<EbookTile> {
  @override
  Widget build(BuildContext context) {
    debugPrint("The url is ${widget.url}");
    return SafeArea(
      child: Scaffold(body: SfPdfViewer.network(widget.url)),
    );
  }
}
