// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace, unused_import, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shoppingapp/api.dart';
import 'package:shoppingapp/categories.dart';
import 'package:shoppingapp/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(.9),
              Colors.white.withOpacity(.9),
              Colors.white.withOpacity(.9)
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 10,
                  top: 40,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // home button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.menu_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),

                    // search bar
                    Text(
                      "ShopIt",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w900),
                    ),
                    // profile icon
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 15, 0),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 7,
                      color: Colors.red.withOpacity(.3),
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.search_rounded,
                        size: 30,
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                    hintText: "Search your items here..",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 600,
              child: FutureBuilder(
                  future: API.getCategories(),
                  builder: (context, categoryShot) {
                    if (categoryShot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return !categoryShot.hasData
                        ? Text('No data')
                        : ListView.builder(
                            itemCount: categoryShot.data!.length,
                            itemBuilder: (context, value) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          DetailsPage()));
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Text(
                                                categoryShot
                                                        .data![value].name[0]
                                                        .toUpperCase() +
                                                    categoryShot
                                                        .data![value].name
                                                        .substring(1),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child: SizedBox(
                                        height: 400,
                                        child: FutureBuilder(
                                            future: API.getProducts(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              return !snapshot.hasData
                                                  ? Text('No Data')
                                                  : ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          snapshot.data!.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return snapshot
                                                                    .data![
                                                                        index]
                                                                    .category !=
                                                                categoryShot
                                                                    .data![
                                                                        value]
                                                                    .name
                                                            ? Text('')
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 10,
                                                                  bottom: 10,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  height: 380,
                                                                  width: 300,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            10,
                                                                        spreadRadius:
                                                                            2,
                                                                        offset: Offset(
                                                                            0,
                                                                            1),
                                                                        color: Colors
                                                                            .red
                                                                            .withOpacity(.2),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Stack(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            180,
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(12),
                                                                                topRight: Radius.circular(12),
                                                                              ),
                                                                              image: DecorationImage(
                                                                                fit: BoxFit.cover,
                                                                                image: NetworkImage(
                                                                                  snapshot.data![index].image,
                                                                                ),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        right:
                                                                            0,
                                                                        top: 0,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              80,
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.red,
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(0),
                                                                                bottomRight: Radius.circular(0),
                                                                                topRight: Radius.circular(12),
                                                                                bottomLeft: Radius.circular(12),
                                                                              )),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.star_rounded,
                                                                                color: Colors.white,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                              Text(
                                                                                snapshot.data![index].rating.rate.toString(),
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        left:
                                                                            10,
                                                                        top:
                                                                            200,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              80,
                                                                          width:
                                                                              280,
                                                                          child:
                                                                              Text(
                                                                            snapshot.data![index].title.length > 60
                                                                                ? snapshot.data![index].title.substring(0, 60) + '...'
                                                                                : snapshot.data![index].title,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                          left:
                                                                              10,
                                                                          top:
                                                                              258,
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                270,
                                                                            child: Text(snapshot.data![index].description.length > 130
                                                                                ? snapshot.data![index].description.substring(0, 130) + "..."
                                                                                : snapshot.data![index].description),
                                                                          )),
                                                                      Positioned(
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            10,
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              280,
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                '\$ ${snapshot.data![index].price.toString()}',
                                                                                style: TextStyle(
                                                                                  color: Colors.red,
                                                                                  fontWeight: FontWeight.w900,
                                                                                  fontSize: 20,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: 40,
                                                                                width: 40,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.red,
                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                  boxShadow: [
                                                                                    BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 3, spreadRadius: 1, offset: Offset(0, 3)),
                                                                                  ],
                                                                                ),
                                                                                child: Icon(
                                                                                  Icons.shopping_cart_rounded,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                height: 40,
                                                                                width: 130,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.red,
                                                                                  borderRadius: BorderRadius.circular(12),
                                                                                  boxShadow: [
                                                                                    BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 3, spreadRadius: 1, offset: Offset(0, 3)),
                                                                                  ],
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Buy Now",
                                                                                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                      },
                                                    );
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              );
                            });
                  }),
            ),
            Container(
              height: 62,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        "Categories",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_on_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        "Notification",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        "Account",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        "Cart",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
