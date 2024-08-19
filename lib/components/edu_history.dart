import 'package:flutter/material.dart';
import 'package:frontend/components/date.dart';
import 'package:frontend/components/FormFields/formfield.dart';
import 'package:frontend/models/UserModel.dart';


class HigherStudiesFormWidget extends StatefulWidget {
  HigherStudiesFormWidget(
      {Key? key, required this.higherStudiesModel, required this.onRemove, required this.index})
      : super(key: key);

  final index;
  HigherStudy higherStudiesModel;
  final Function onRemove;
  final state = _HigherStudiesFormWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  bool isValidated() => state.validate();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _courseNameController = TextEditingController();
  DateCalController startDateController = DateCalController();
  DateCalController endDateController = DateCalController();
}

class _HigherStudiesFormWidgetState extends State<HigherStudiesFormWidget> {
  final formKey = GlobalKey<FormState>();

  bool validate() {
    // Validate Form Fields
    bool isValid = formKey.currentState?.validate() ?? false;
    if (isValid) {
      formKey.currentState?.save();
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.11053,
              color: Color(0xFF2F80ED),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, left: 15.0, right: 15.0, bottom: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Enter Study Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                //Clear All forms Data
                                widget.higherStudiesModel.institute = null;
                                widget.higherStudiesModel.course = null;
                                widget.higherStudiesModel.startDate = null;
                                widget.higherStudiesModel.endDate = null;
                                widget._nameController.clear();
                                widget._courseNameController.clear();
                                widget.startDateController.clear();
                                widget.endDateController.clear();
                              });
                            },
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.blue),
                            )),
                          TextButton(
                            onPressed: () => widget.onRemove(),
                            child: const Text(
                              "Remove",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
            
                MyTextField(
                  validator: (value) => value!.length > 3 ? null : "Enter Institute Name",
                  controller: widget._nameController,
                  onChanged: (value) => widget.higherStudiesModel.institute = value,
                  onSaved: (value) => widget.higherStudiesModel.institute = value,
                  hintText: "Institute name",
                ),
                MyTextField(
                  validator: (value) => value!.length > 3 ? null : "Enter Course Name",
                  controller: widget._courseNameController,
                  onChanged: (value) => widget.higherStudiesModel.course = value,
                  onSaved: (value) => widget.higherStudiesModel.course = value,
                  hintText: "Course Name",
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DateCal(
                        controller: widget.startDateController,
                        onChanged: (value) => widget.higherStudiesModel.startDate = value != '' ? DateTime.parse(value!) : null,
                        onSaved: (value) => widget.higherStudiesModel.startDate = DateTime.parse(value!),
                        initialText: "Start Date"
                      ),
                    ),
                    const SizedBox(width: 10.0), // Add some space between the fields
                    Expanded(
                      child: DateCal(
                        controller: widget.endDateController,
                        onChanged: (value) => widget.higherStudiesModel.endDate = value != '' ? DateTime.parse(value!) : null,
                        onSaved: (value) => widget.higherStudiesModel.endDate = DateTime.parse(value!),
                        initialText: "End Date"
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
