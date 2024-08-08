import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_flutter/data/api/storage.dart';
import 'package:mobile_shop_flutter/models/const.dart';
import 'package:http/http.dart' as http;

class SliderModel {
  //Singleton connection
  SliderModel._privateConstructor();

  // Static instance
  static final SliderModel _instance = SliderModel._privateConstructor();

  // Factory constructor to return the static instance
  factory SliderModel() {
    return _instance;
  }

  List<String> urlImg = [];
}

class SliderBanner extends StatefulWidget {
  const SliderBanner({super.key});

  @override
  State<SliderBanner> createState() => _SliderBanner();
}

class _SliderBanner extends State<SliderBanner> {
  final sliderModel = SliderModel();
  List<Image> carouselItems = [];
  int _currentIndex = 0;

  Future<void> _getSliderFromAPI() async {
    try {
      sliderModel.urlImg.clear(); // Clear previous URLs
      String? key = await read();
      String? url = await readUrl('bannerUrl');

      final res = await http
          .get(Uri.parse(url!), headers: {'Authorization': 'Bearer $key'});

      if (res.statusCode == 200) {
        var records = jsonDecode(res.body)["records"];
        for (var record in records) {
          var imageUrl = record["fields"]["Image"][0]["url"];
          sliderModel.urlImg.add(imageUrl);
        }
        _setListCarousel();
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      rethrow;
    }
  }

  _setListCarousel() async{
    if(sliderModel.urlImg.isEmpty){
      await _getSliderFromAPI();
    }

    carouselItems.clear(); // Clear previous items
    for (String url in sliderModel.urlImg) {
      carouselItems.add(
        Image.network(
          url,
          fit: BoxFit.fitWidth,
          width: 400,
        ),
      );
    }
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    _setListCarousel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: carouselItems.isNotEmpty?
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CarouselSlider(
            items: carouselItems,
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              height: 200,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          DotsIndicator(
            dotsCount: carouselItems.length,
            position: _currentIndex,
            decorator: DotsDecorator(
              activeColor: mainColor,
              activeSize: const Size(30.0, 10.0),
              size: const Size(10.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ):
      const Center(child: CircularProgressIndicator()),
    );
  }
}
