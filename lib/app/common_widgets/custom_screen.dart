import 'package:flutter/material.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({
    Key? key,
    required this.child,
    this.onInit,
    this.onClose,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback? onInit;
  final VoidCallback? onClose;
  final Widget child;
  final bool isLoading;

  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.onInit != null) {
      widget.onInit!();
    }
  }

  @override
  void dispose() {
    if (widget.onClose != null) {
      widget.onClose!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.green[700],
            ),
          )
        : widget.child;
  }
}
