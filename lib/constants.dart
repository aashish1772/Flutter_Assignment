import 'package:flutter/material.dart';

const kBoxDecoratonContainer1 = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.vertical(top: Radius.circular(30)));
const kBoxDecorationContainer2 = BoxDecoration(
  color: Colors.white,
  boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(50),
  ),
);

const kBoxDecorationGradient = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFCDD2), Color(0xFFFFF9C4)]));

const kTextStyleHeading1 = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
const kTextStyleHeading2 = TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
const kTextStyleHeading3 = TextStyle(fontSize: 15);

const List<String> categories = [
  'All',
  'Popular',
  'Milk Based',
  'Parathas & Stuffed Rolls',
  'Cheelas',
  'Porridges, Vermicelli & Poha',
];

const kTextColor = Color(0xFFF98500);
const kTabBarColor = Color(0xFFFDDAB3);
