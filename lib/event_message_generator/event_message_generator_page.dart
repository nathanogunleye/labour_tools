import 'dart:convert';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:labour_tools/event_message_generator/model/event.dart';
import 'package:labour_tools/main.dart';

class EventMessageGeneratorPage extends StatefulWidget {
  const EventMessageGeneratorPage({
    super.key,
  });

  @override
  State<EventMessageGeneratorPage> createState() =>
      _EventMessageGeneratorPageState();
}

class _EventMessageGeneratorPageState extends State<EventMessageGeneratorPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  String _uploadedFileName = 'Choose CSV file';
  String _csvString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: labourMaterialRed.shade50,
        title: const Text('Events Message Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: _uploadedFileName,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: [
                            "csv",
                          ],
                        );

                        if (result != null && result.files.isNotEmpty) {
                          final Uint8List fileBytes = result.files.first.bytes!;
                          final String fileName = result.files.first.name;

                          _csvString = utf8.decode(fileBytes);

                          setState(() {
                            _uploadedFileName = fileName;
                          });
                        }
                      },
                      child: const Text('Choose CSV File...'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _textEditingController.text =
                              convertToMessage(_csvString);
                        });
                      },
                      child: const Text('Generate Message!'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.multiline,
                  scrollController: _scrollController,
                  readOnly: true,
                  minLines: 20,
                  maxLines: 50,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Your message will appear here',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String convertToMessage(String csv) {
    List<Event> events = convertCsvToEvents(csv);

    StringBuffer sb = StringBuffer();

    sb.writeln('Hi all,');
    sb.writeln(
      'We have many canvassing sessions scheduled this week. Please join us 🌹',
    );
    sb.writeln('');

    for (var event in events) {
      sb.writeln('🗓️ Date/Time: ${event.startTime}');
      sb.writeln('📍 Meeting Point: ${event.location}');
      sb.writeln('🔗 Link: ${event.url}');
      sb.writeln('');
    }

    return sb.toString();
  }

  List<Event> convertCsvToEvents(String csv) {
    List<Event> events = [];

    List<List<String>> rowsAsListOfValues = const CsvToListConverter().convert(
      csv,
      shouldParseNumbers: false,
      eol: '\n',
    );

    for (List<String> row in rowsAsListOfValues) {
      if (row == rowsAsListOfValues.first) {
        continue;
      }

      events.add(Event(
        id: row[0],
        region: row[1],
        ward: row[2],
        onsCode: row[3],
        constituencyName: row[4],
        councilOns: row[5],
        councilName: row[6],
        eventTitle: row[7],
        description: row[8],
        validationStatus: row[9],
        rsvps: row[10],
        category: row[11],
        location: row[12],
        postcode: row[13],
        startTime: row[14],
        endTime: row[15],
        creator: row[16],
        url: row[17],
      ));
    }

    return events;
  }
}
