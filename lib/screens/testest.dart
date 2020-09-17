import 'package:flutter/material.dart';
import 'package:get_active_prf/screens/jussst.dart';
import 'package:provider/provider.dart';
import 'package:get_active_prf/data/percentage_logic.dart';

class JustAtest extends StatefulWidget {
  @override
  _JustAtestState createState() => _JustAtestState();
}

class _JustAtestState extends State<JustAtest>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prcntgeProvider = Provider.of<PrcntgLogic>(context, listen: true);
    return Column(
      children: [
        RaisedButton(onPressed: () {
          prcntgeProvider.getPrsntg(1, 0.5, 4);
        }),
        Container(
          child: Text('${prcntgeProvider.progressprcntg}'),
        ),
        RaisedButton(onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Jusst()));
        })
      ],
    );
  }
}
