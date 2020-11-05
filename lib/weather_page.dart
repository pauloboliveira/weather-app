import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CityWeatherPage extends StatefulWidget {
  _CityWeatherPageState createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  TextEditingController cityController = TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(53, 71, 182, 300),
        child: Column(
          children: [
            _day(),
            Divider(
              color: Color.fromRGBO(182, 193, 215, 300),
              endIndent: 15,
              indent: 15,
              thickness: 0.8,
              height: 0.1,
            ),
            _scrollNextDays(),
            Container(
              height: 70,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(16),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                  hintText: 'Pesquise uma cidade',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _scrollNextDays() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color.fromRGBO(182, 193, 215, 300),
                border: Border.all(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: 250,
            height: 250,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seg.',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        '30º',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  endIndent: 25,
                  indent: 25,
                  thickness: 0.8,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '38',
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'max',
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.red,
                            size: 12,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '25',
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'min',
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.blue[700],
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color.fromRGBO(182, 193, 215, 300),
                border: Border.all(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: 250,
            height: 250,
          ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color.fromRGBO(182, 193, 215, 300),
                border: Border.all(color: Colors.transparent, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: 250,
            height: 250,
          ),
        ],
      ),
    );
  }

  _day() {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      height: 300,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Indaiatuba, BR',
                    style: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '30º',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 75,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.wb_sunny_rounded,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 30,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Sensação',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '43º',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Color.fromRGBO(182, 193, 215, 300),
            endIndent: 25,
            indent: 25,
            thickness: 0.8,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        '38',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'max',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_upward,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 17,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '25',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'min',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_downward,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 17,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '20',
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'umi',
                        style: GoogleFonts.notoSans(
                          color: Color.fromRGBO(182, 193, 215, 300),
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.cloud_queue_outlined,
                        color: Color.fromRGBO(182, 193, 215, 300),
                        size: 17,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
