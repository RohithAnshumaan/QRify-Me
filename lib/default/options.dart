import 'package:qrify_me/attendee/my_events.dart';
import 'package:flutter/material.dart';
import 'package:qrify_me/admin/host_event.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EVENT TRACKER'),
      ),
      body: Column(children: [
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const HostEvent();
              }));
            },
            child: const Text('Want to host an event?')),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const MyEvents();
              }));
            },
            child: const Text('Want to attend an event?')),
      ]),
    );
  }
}
