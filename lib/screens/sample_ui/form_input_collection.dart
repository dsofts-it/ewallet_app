import 'package:ewallet_app/models/list_item.dart';
import 'package:ewallet_app/ui/themes/theme_spacing.dart';
import 'package:ewallet_app/utils/picker.dart';
import 'package:ewallet_app/widgets/app_input/app_textfield.dart';
import 'package:flutter/material.dart';

class FormInputCollection extends StatefulWidget {
  const FormInputCollection({super.key});

  @override
  State<FormInputCollection> createState() => _FormInputCollectionState();
}

class _FormInputCollectionState extends State<FormInputCollection> {
  final TextEditingController _dateFromRef = TextEditingController();
  final TextEditingController _dateToRef = TextEditingController();
  final TextEditingController _timePickerRef = TextEditingController();

  String? hobby;
  final TextEditingController _chooseRef = TextEditingController();

  List<ListItem> hobbyOptions = [
    ListItem(
      value: 'M',
      label: 'Music',
      text: 'Music description',
    ),
    ListItem(
      value: 'F',
      label: 'Film',
      text: 'Film description',
    ),
    ListItem(
      value: 'O',
      label: 'Other',
      text: 'Other description',
    ),
  ];

  void openPicker(BuildContext context) {
    openRadioPicker(
      context: context,
      options: hobbyOptions,
      title: 'Choose Hobby',
      onSelected: (value) {
        if (value != null) {
          String result = hobbyOptions.firstWhere((e) => e.value == value).label;
          _chooseRef.text = result;
        }
        setState(() {
          hobby = value;
        });
      },
      initialValue: hobby,
    );
  }

  Future<void> _selectTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 7, minute: 30),
      orientation: Orientation.portrait,
      initialEntryMode: TimePickerEntryMode.dial
    );
  
    if (time != null) {
      setState(() {
        _timePickerRef.text = time.format(context);
      });
    }
  }

  Future _selectDate2(TextEditingController targetRef) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2027),
    );

    if (picked != null) {
      setState(() {
        targetRef.text = picked.toString().split(" ")[0];
      });
    }
  } 

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(spacingUnit(2)), children: [
      AppTextField(
        label: 'Text Field',
        onChanged: (_) => {},
      ),
      const VSpace(),
      AppTextField(
        controller: _chooseRef,
        label: 'Select Bottomsheet',
        onChanged: (_) {},
        onTap: () {
          openPicker(context);
        },
        suffix: const Icon(Icons.arrow_drop_down),
      ),
      const VSpace(),
      Row(children: [
        Expanded(child: AppTextField(
          controller: _dateFromRef,
          readOnly: true,
          prefixIcon: Icons.date_range,
          label: 'Date from',
          onChanged: (_) {},
          onTap: () {
            _selectDate2(_dateFromRef);
          },
        )),
        const SizedBox(width: 4,),
        Expanded(child: AppTextField(
          controller: _dateToRef,
          readOnly: true,
          prefixIcon: Icons.date_range,
          label: 'Date to',
          onChanged: (_) {},
          onTap: () {
            _selectDate2(_dateToRef);
          },
        ))
      ]),
      const VSpace(),
      AppTextField(
        controller: _timePickerRef,
        readOnly: true,
        prefixIcon: Icons.access_time,
        label: 'Time Picker',
        onChanged: (_) {},
        onTap: _selectTime,
      ),
      const VSpace(),
      AppTextField(
        label: 'Text Area',
        maxLines: 8,
        onChanged: (_) => {},
      ),
      const VSpace(),
    ]);
  }
}