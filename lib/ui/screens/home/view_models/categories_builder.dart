import 'package:flutter/material.dart';
import 'package:newsapp/ui/screens/home/components/category_chip/category_chip.dart';
import 'package:newsapp/utils/localization.dart';

class CategoriesListBuilder extends StatelessWidget {
  const CategoriesListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: categories["en"]?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return CategoryChip(index: index);
        },
      ),
    );
  }
}
