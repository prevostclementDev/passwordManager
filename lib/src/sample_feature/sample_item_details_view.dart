import 'package:flutter/material.dart';
import 'package:password_administrator/src/sample_feature/sample_item.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {

  SampleItemDetailsView({super.key, required this.sampleItem});
  final SampleItem sampleItem;

  String getTextId() {
    return sampleItem.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details ${getTextId()}'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
