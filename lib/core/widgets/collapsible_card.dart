import 'package:flutter/material.dart';

class CollapsibleCard extends StatefulWidget {
  final Widget header;
  final Widget content;
  const CollapsibleCard({
    super.key,
    required this.header,
    required this.content,
  });

  @override
  CollapsibleCardState createState() => CollapsibleCardState();
}

class CollapsibleCardState extends State<CollapsibleCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: _toggleExpanded,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.header,
              AnimatedCrossFade(
                firstChild: SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: widget.content,
                ),
                crossFadeState:
                    _expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
