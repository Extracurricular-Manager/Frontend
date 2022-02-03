import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 5.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // radius of 10
            color: Colors.white,
          ),
          child: const TextField(
            //controller: searchController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                border: InputBorder.none),
          )),
    );
  }
}
