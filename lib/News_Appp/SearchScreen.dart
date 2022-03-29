import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Component.dart';
import 'package:news_app/News_Appp/NewsCubit.dart';
import 'package:news_app/News_Appp/NewsState.dart';
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var SearchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit
              .get(context)
              .search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controller: SearchController,
                      type: TextInputType.text,
                      onChange: (value) {
                        NewsCubit.get(context).getsearch(value);
                      },
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'title must not be empty';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search
                  ),
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: list.length > 0,
                    builder: (context) =>
                        ListView.separated(
                          itemBuilder: (context, index) =>
                              buildArticleItem(list[index], context),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: list.length,
                        ),
                    fallback: (context) =>
                        Center(child: (CircularProgressIndicator())),
                  ),
                )

              ],
            ),
          );
        }
    );
  }
}