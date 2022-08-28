import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/webview/webview_screen.dart';

import '../screens/webview/webview_screen.dart';

Widget builderArticalItem(articale, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen(articale['url'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage('${articale['urlToImage']}'),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
                child: SizedBox(
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      articale['title'].toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(articale['publishedAt'].toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ))
                ],
              ),
            )),
          ],
        ),
      ),
    );

Widget articaleBuilder(list, context, {bool isSearch = false}) =>
    ConditionalBuilder(
        condition: list.isNotEmpty,
        builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                builderArticalItem(list[index], context),
            separatorBuilder: (context, index) => Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                ),
            itemCount: 10),
        fallback: (context) => isSearch
            ? Container()
            : const Center(
                child: CircularProgressIndicator(),
              ));
