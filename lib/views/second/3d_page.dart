import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

class Page3D extends StatefulWidget{

  _Page3D createState() => _Page3D();
}

class _Page3D extends State<Page3D> with SingleTickerProviderStateMixin{

  Size _screen = Size(0, 0);
  double _extraHeight = 0.1;
  double _maxSlide = 0.75;
  late CurvedAnimation _animator, _objAnimator;
  late AnimationController _animationController;
  late double _startingPos;
  bool _drawnerVisible = false;


  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800)
    );

    _animator = CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInQuad,
      reverseCurve: Curves.easeInQuad
    );

    _objAnimator = CurvedAnimation(
      parent: _animationController, 
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeIn
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screen = MediaQuery.of(context).size;
    _extraHeight *= _screen.width;
    _maxSlide *= _screen.height;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,

        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(color: Color(0xFFaaa598)),
            _buildBackground(),
            _build3dObject(),
            _buildDrawer(),
            _buildHeader(),
            _buildOverlay(),
          ],
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details){
    _startingPos = details.globalPosition.dx;
  }

  void _onDragUpdate(DragUpdateDetails details){
    final globalDelta = details.globalPosition.dx - _startingPos;
    if(globalDelta>0){
      final pos = globalDelta/_screen.width;
      if(_drawnerVisible && pos<1.00) return;
      _animationController.value=pos;
    }
    else{
      final pos = 1-(globalDelta.abs()-_screen.width);
      if(!_drawnerVisible && pos>0.00) return;
      _animationController.value=pos;
    }
  }
  
  void _onDragEnd(DragEndDetails details){
    if(details.velocity.pixelsPerSecond.dx.abs()>500){
      if(details.velocity.pixelsPerSecond.dx>0){
        _animationController.forward(from: _animationController.value);
        _drawnerVisible = true;
      }
      else{
        _animationController.reverse(from: _animationController.value);
        _drawnerVisible = false;
      }
      return;
    }

    if(_animationController.value>0.5){
      _animationController.forward(from: _animationController.value);
      _drawnerVisible = true;
    }else{
      _animationController.reverse(from: _animationController.value);
      _drawnerVisible = false;
    }
  }

  void _toggleDrawner(){
    if(_animationController.value<0.5){
      _animationController.forward();
    }else{
      _animationController.reverse();
    }
  }

  Widget _buildMenuItem(String s, {bool active = false}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),

      child: InkWell(
        onTap: () {
          
        },

        child: Text(
          s.toUpperCase(),
          style: TextStyle(
            fontSize: 25,
            color: active ? Color(0xffbb0000) : null,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _buildFooterMenuItem(String s){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),

      child: InkWell(
        onTap: () {},
        child: Text(
          s.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  _buildBackground() => Positioned.fill(
      top: -_extraHeight,
      bottom: -_extraHeight,
      left: 0,
      right: _screen.width - _maxSlide,
      child: AnimatedBuilder(
        animation: _animator,
        builder: (context, widget) => Transform.translate(
            offset: Offset(_maxSlide*_animator.value, 0),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY((pi/2+0.3)* -_animator.value),
              alignment: Alignment.centerLeft,
              child: widget,
            ),
          ),
        child: Container(
          color: Color(0xffe8dfce),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              //
              Positioned(
                top: _extraHeight+0.1*_screen.height,
                left: 80,
                child: Transform.rotate(
                  angle: 90*(pi/180),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "FENDER",
                    style: TextStyle(
                      fontSize: 100,
                      color: Color(0xFFc7c0b2),
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2.0, 0.0),
                        ),
                      ],
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              //
              Positioned(
                top: _extraHeight + 0.13 * _screen.height,
                bottom: _extraHeight + 0.24 * _screen.height,
                left: _maxSlide - 0.41 * _screen.width,
                right: _screen.width * 1.06 - _maxSlide,
                child: Column(
                  children: [
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: 0.2,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 50,
                                color: Colors.black38
                              )
                            ],
                            borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                      )
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 50,
                              color: Colors.black26
                            )
                          ],
                          borderRadius: BorderRadius.circular(50)
                        ),
                      )
                    ),
                  ],
                )
              ),

              AnimatedBuilder(
                animation: _animationController, 
                builder: (_, __) => Container(
                    color: Colors.black.withAlpha(
                      (150*_animator.value).floor()
                    ),
                  ),
              ),
            ],
          ),
        ),
      )
    );

  _build3dObject() => Positioned(
    top: 0.1 * _screen.height,
    bottom: 0.22 * _screen.height,
    left: _maxSlide - _screen.width * 0.5,
    right: _screen.width * 0.85 - _maxSlide,

    child: AnimatedBuilder(
      animation: _objAnimator,

      builder: (_,__) => ImageSequenceAnimator(
        "assets/guitarSequence/",
        "", //fileName
        1, //suffixStart
        4, //suffixCount
        "png", //fileFormat
        120, //frameCount
        fps: 60,
        fullPaths: [],
        isOnline: true,
        isLooping: true,
        isBoomerang: true,
        isAutoPlay: false,
        // frame: (_objAnimator.value * 120).ceil(),
      ),
    )
  );

  _buildDrawer() => Positioned.fill(
        top: -_extraHeight,
        bottom: -_extraHeight,
        left: 0,
        right: _screen.width - _maxSlide,
        child: AnimatedBuilder(
          animation: _animator,
          builder: (context, widget) {
            return Transform.translate(
              offset: Offset(_maxSlide * (_animator.value - 1), 0),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(pi * (1 - _animator.value)/2),
                alignment: Alignment.centerRight,
                child: widget,
              ),
            );
          },
          child: Container(
            color: Color(0xffe8dfce),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.black12],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: _extraHeight,
                  bottom: _extraHeight,
                  child: SafeArea(
                    child: Container(
                      width: _maxSlide,
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 4,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Text(
                                    "STRING",
                                    style: TextStyle(
                                      fontSize: 12,
                                      backgroundColor: Color(0xffe8dfce),
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildMenuItem("Guitars", active: true),
                                _buildMenuItem("Basses"),
                                _buildMenuItem("Amps"),
                                _buildMenuItem("Pedals"),
                                _buildMenuItem("Others"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _buildFooterMenuItem("About"),
                                _buildFooterMenuItem("Support"),
                                _buildFooterMenuItem("Terms"),
                                _buildFooterMenuItem("Faqs"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _animator,
                  builder: (_, __) => Container(
                    width: _maxSlide,
                    color: Colors.black.withAlpha(
                      (150 * (1 - _animator.value)).floor(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  
  _buildHeader() => SafeArea(
        child: AnimatedBuilder(
            animation: _animator,
            builder: (_, __) {
              return Transform.translate(
                offset: Offset((_screen.width - 60) * _animator.value, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: InkWell(
                        onTap: _toggleDrawner,
                        child: Icon(Icons.menu),
                      ),
                    ),
                    Opacity(
                      opacity: 1 - _animator.value,
                      child: Text(
                        "PRODUCT DETAIL",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(width: 50, height: 50),
                  ],
                ),
              );
            }),
      );

  _buildOverlay() => Positioned(
    top: 0,
    bottom: 50,
    left: 0,
    right: 0,
    child: AnimatedBuilder(
      animation: _animator,

      builder: (_, widget) => Opacity(
        opacity: 1-_animator.value,
        child: Transform.translate(
          offset: Offset(_maxSlide*_animator.value, 0),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY((pi/2+0.1)* -_animator.value),
            alignment: Alignment.centerLeft,
            child: widget,
          ),
        ),
      ),

      child: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,

          children: [
            Text(
              "Fender\nAmerican\nElite Strat",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  "SPEC",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ],
        ),
      ),
    ),
  );

}