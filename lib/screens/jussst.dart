import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_active_prf/data/percentage_logic.dart';

class Jusst extends StatefulWidget {
  @override
  _JusstState createState() => _JusstState();
}

class _JusstState extends State<Jusst> {
  @override
  Widget build(BuildContext context) {
    final prcntgeProvider = Provider.of<PrcntgLogic>(context, listen: true);
    return Container(
      child: Text('${prcntgeProvider.progressprcntg}'),
    );
  }
}
