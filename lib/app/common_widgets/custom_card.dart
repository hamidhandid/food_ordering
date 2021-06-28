import 'package:alo_self/app/common_widgets/custom_radius_container.dart';
import 'package:alo_self/app/common_widgets/custom_pair.dart';
import 'package:flutter/material.dart';

class CustomGridCard extends StatelessWidget {
  const CustomGridCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}

class NormalCard extends StatelessWidget {
  const NormalCard({
    required this.topStart,
    required this.additionItemsTitle,
    this.topEnd,
    this.bottomStart,
    this.bottomEnd,
    this.centerText,
    this.additionalRowPairs,
    this.padding,
    this.editCallback,
    this.deleteCallback,
    this.addCallback,
    this.iconAdd,
    this.additionalWidgets,
  });

  final String topStart;
  final String? topEnd;
  final String? bottomStart;
  final String? bottomEnd;
  final String? centerText;
  final List<CustomPair<VoidCallback?, CustomPair<String, String>>>? additionalRowPairs;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? editCallback;
  final VoidCallback? deleteCallback;
  final VoidCallback? addCallback;
  final IconData? iconAdd;
  final String additionItemsTitle;
  final List<Widget>? additionalWidgets;

  @override
  Widget build(BuildContext context) {
    return CustomGridCard(
      child: Container(
        child: CustomRaduisContainer(
          radius: 7,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                _buildRow(
                  children: [
                    _padding(
                      context,
                      _buildCustomText(
                        context,
                        text: topStart,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: padding,
                    ),
                    _padding(
                      context,
                      _buildRow(children: [
                        if (editCallback != null)
                          IconButton(
                            onPressed: editCallback,
                            icon: Icon(
                              Icons.edit,
                              size: 27,
                            ),
                          ),
                        SizedBox(width: 10),
                        if (deleteCallback != null)
                          IconButton(
                            onPressed: deleteCallback,
                            icon: Icon(
                              Icons.delete,
                              size: 27,
                            ),
                          ),
                        if (additionalRowPairs == null && addCallback != null)
                          IconButton(
                            onPressed: addCallback,
                            icon: Icon(
                              iconAdd ?? Icons.food_bank_outlined,
                              size: 27,
                            ),
                          ),
                      ]),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    )
                  ],
                ),
                if (centerText != null)
                  Center(
                    child: CustomRaduisContainer(
                      radius: 3,
                      child: _padding(
                        context,
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: _buildCustomText(context, text: centerText!, fontSize: 16),
                        ),
                        padding: padding,
                      ),
                    ),
                  ),
                if (bottomStart != null || bottomEnd != null)
                  _buildRow(
                    children: [
                      if (bottomStart != null)
                        _padding(
                          context,
                          _buildCustomText(context, text: bottomStart!, isSecondary: true),
                          padding: padding,
                        ),
                      if (bottomEnd != null)
                        _padding(
                          context,
                          _buildCustomText(context, text: bottomEnd!, isSecondary: true),
                          padding: padding,
                        ),
                    ],
                  ),
                if (additionalRowPairs != null) SizedBox(height: 30),
                if (additionalRowPairs != null)
                  _padding(
                    context,
                    _buildRow(
                      children: [
                        Text(
                          additionItemsTitle,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (addCallback != null)
                          IconButton(
                            onPressed: addCallback,
                            icon: Icon(
                              iconAdd ?? Icons.add_box_outlined,
                              size: 27,
                            ),
                          ),
                      ],
                    ),
                  ),
                if (additionalRowPairs != null)
                  for (final rowPair in additionalRowPairs!)
                    _buildRow(
                      children: [
                        _padding(
                          context,
                          _buildCustomText(
                            context,
                            text: rowPair.second.first,
                            isSecondary: true,
                          ),
                          padding: padding,
                        ),
                        _padding(
                          context,
                          _buildCustomText(
                            context,
                            text: rowPair.second.second,
                            isSecondary: true,
                          ),
                          padding: padding,
                        ),
                        if (rowPair.first != null)
                          _padding(
                            context,
                            IconButton(
                              onPressed: rowPair.first,
                              icon: Icon(Icons.edit_outlined),
                            ),
                          ),
                      ],
                    ),
                if (additionalWidgets != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final additionWidget in additionalWidgets!) additionWidget,
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomText(BuildContext context,
      {required String text, bool isSecondary = false, double? fontSize, FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w300,
      ),
    );
  }

  Widget _padding(BuildContext context, Widget child, {EdgeInsetsGeometry? padding}) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(top: 0),
      child: child,
    );
  }

  Widget _buildRow(
      {required List<Widget> children, MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );
  }
}
