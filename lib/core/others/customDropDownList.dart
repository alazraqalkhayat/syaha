
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../app_theme.dart';
import '../widgets/Texts/primaryText.dart';
import 'itemsModel.dart';

class CustomDropDown extends StatelessWidget {
  final String hint;
  final bool loading;
  final String dropDownValue;
  var onChange = (newValue) {};
  final List<ItemsModel> dropDownList;


  var dropDownItems;
  CustomDropDown({required this.dropDownValue,required this.onChange,required this.dropDownList,required this.hint, this.loading = false });

  @override
  Widget build(BuildContext context) {
    print('this is dropDownList $dropDownList');
    dropDownItems= dropDownList != null
        ? dropDownList.map<DropdownMenuItem<String>>((ItemsModel item) {
      return DropdownMenuItem<String>(
        value: item.name,
        child: PrimaryText(
          text: item.name ?? '',
          textStyle: AppTheme.textTheme.headline4?.copyWith(fontSize: 14),
          textAlign: TextAlign.start,
        ),
      );
    }).toList()
        :null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      margin: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: Colors.transparent,

          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.primarySwatch.shade500, width: 1)
      ),
      child: loading
          ? Shimmer.fromColors(
        baseColor: AppTheme.appContainersTextColor,
        highlightColor: AppTheme.scaffoldBackgroundColor.withOpacity(.1),
        enabled: true,
        child: Center(child: Text('جاري التحميل')),
      )
          : DropdownButton<String>(
        value: dropDownValue,
        underline: Container(),
        isExpanded: true,
        // try make radius
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 2,
        style: AppTheme.textTheme.headline2,
        hint: Text(hint ?? '', style: AppTheme.textTheme.headline2),
        onChanged: onChange,
        items: dropDownItems,
      ),
    );
  }
}
