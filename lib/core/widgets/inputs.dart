import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/utils/styles/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText && !showPassword,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(widget.prefixIcon, color: context.primaryColorDark),
        suffixIcon: widget.obscureText
            ? Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword
                          ? MdiIcons.eyeOffOutline
                          : MdiIcons.eyeOutline,
                      color: context.primaryColorDark,
                    ),
                  );
                },
              )
            : null,
        border: context.inputDecorationTheme.border,
      ),
    );
  }
}

class CustomTextFormFieldWithSuggestions extends StatefulWidget {
  const CustomTextFormFieldWithSuggestions({
    super.key,
    required this.label,
    required this.suggestions,
    required this.onSelected,
    required this.controller,
  });
  final List<String> suggestions;
  final String label;
  final Function(String) onSelected;
  final TextEditingController controller;
  @override
  State<CustomTextFormFieldWithSuggestions> createState() =>
      _CustomTextFormFieldWithSuggestionsState();
}

class _CustomTextFormFieldWithSuggestionsState
    extends State<CustomTextFormFieldWithSuggestions> {
  String selectedValue = '';
  @override
  void initState() {
    selectedValue = widget.controller.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.text = selectedValue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TypeAheadField<String>(
        controller: widget.controller,
        suggestionsCallback: (search) {
          final result = widget.suggestions
              .where(
                (String suggestion) => suggestion.toLowerCase().trim().contains(
                  search.trim().toLowerCase(),
                ),
              )
              .toList();
          return result;
        },
        builder: (context, controller, focusNode) {
          // controller.text = selectedValue;
          return TextField(
            controller: controller,
            focusNode: focusNode,
            // autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.label,
            ),
            // onChanged: ,
          );
        },
        itemBuilder: (context, option) {
          return ListTile(
            title: Text(option),
            // subtitle: Text(city.country),
          );
        },
        onSelected: (String option) {
          widget.onSelected(option);
          setState(() {
            selectedValue = option;
          });
        },
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });
  final String labelText;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText && !showPassword,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword
                          ? MdiIcons.eyeOffOutline
                          : MdiIcons.eyeOutline,
                      color: context.primaryColor,
                    ),
                  );
                },
              )
            : null,
        border: context.inputDecorationTheme.border,
      ),
    );
  }
}

class SearchableDropdownWidget extends StatefulWidget {
  const SearchableDropdownWidget({
    super.key,
    required this.options,
    required this.handleSelectOption,
    required this.label,
    required this.hintText,
    required this.isRequired,
  });
  final List<String> options;
  final Function handleSelectOption;
  final String label;
  final String hintText;
  final bool isRequired;
  @override
  State<SearchableDropdownWidget> createState() =>
      _SearchableDropdownWidgetState();
}

class _SearchableDropdownWidgetState extends State<SearchableDropdownWidget> {
  String? selectedOption;
  void _showSearchDialog() async {
    String? result = await showDialog(
      context: context,
      builder: (context) {
        return SearchDialog(
          options: widget.options,
          initialValue: selectedOption,
          hintText: widget.hintText,
          label: widget.label,
        );
      },
    );
    if (result != null) {
      setState(() {
        selectedOption = result;
      });
      widget.handleSelectOption(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onTap: _showSearchDialog,
      controller: TextEditingController(text: selectedOption),
      validator: (value) {
        if (!widget.isRequired) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return "Please select an option";
        }
        return null;
      },
    );
  }
}

class SearchDialog extends StatefulWidget {
  const SearchDialog({
    super.key,
    required this.options,
    this.initialValue,
    required this.label,
    required this.hintText,
  });
  final List<String> options;
  final String? initialValue;
  final String label;
  final String hintText;
  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  late List<String> filteredOptions;
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    filteredOptions = widget.options;
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterOptions(String query) {
    setState(() {
      filteredOptions = widget.options
          .where(
            (option) => option.trim().toLowerCase().contains(
              query.trim().toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: AlertDialog(
        title: txt('Search And Select ${widget.label}'),
        content: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFormField(
                  labelText: 'Search',
                  controller: searchController,
                  prefixIcon: const Icon(Icons.search),
                  onChanged: _filterOptions,
                ),
                const SizedBox(height: 10),
                ...List.generate(filteredOptions.length, (index) {
                  return ListTile(
                    title: txt(filteredOptions[index]),
                    onTap: () {
                      Navigator.of(context).pop(filteredOptions[index]);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({super.key, required this.text, this.label = ''});
  final String text;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      textAlign: TextAlign.right,
      maxLines: null,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      controller: TextEditingController(text: text),
    );
  }
}

class CustomDateField extends StatefulWidget {
  const CustomDateField({
    super.key,
    required this.onDateSubmit,
    required this.label,
    required this.initialDate,
    required this.textEditingController,
    this.validator,
  });
  final String label;
  final DateTime? initialDate;
  final Function(DateTime date) onDateSubmit;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  // final dateEditingController = TextEditingController();
  DateTime? selectedDate;
  @override
  void initState() {
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.initialDate != null
                  ? '${widget.initialDate?.year}-${widget.initialDate?.month.toString().padLeft(2, '0')}-${widget.initialDate?.day.toString().padLeft(2, '0')}'
                  : 'Select a date',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            // validator: (_) => widget.selectedDate == null ? '${widget.label} is required' : null,
            validator: widget.validator,
          ),
        ),
      ),
    );
  }

  // Method to pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        widget.onDateSubmit(pickedDate);
        widget.textEditingController.text =
            '${selectedDate?.year}-${selectedDate?.month.toString().padLeft(2, '0')}-${selectedDate?.day.toString().padLeft(2, '0')}';
      });
    }
  }
}

class CustomBiographyForm extends StatelessWidget {
  const CustomBiographyForm({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: 20,
        minLines: 2,
        decoration: InputDecoration(
          labelText: 'Biography',
          hintText: 'Write a brief biography',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.label,
    this.controller,
    this.hint, {
    super.key,
    this.inputType = TextInputType.text,
    this.validator,
    this.showMulitLine = false,
  });
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final bool showMulitLine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        validator: validator,
        maxLines: showMulitLine ? 20 : null,
        minLines: showMulitLine ? 2 : null,
      ),
    );
  }
}

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({
    super.key,
    required this.options,
    required this.label,
    required this.onSelect,
  });
  final List<String> options;
  final String label;
  final Function onSelect;
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: _decoration(widget.label),
      items: widget.options
          .map(
            (option) =>
                DropdownMenuItem<String>(value: option, child: txt(option)),
          )
          .toList(),
      onChanged: (String? value) {
        widget.onSelect(value);
        setState(() {
          selectedValue = value;
        });
      },
      validator: (value) => value == null ? 'Please Select A Value' : null,
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: context.inputDecorationTheme.labelStyle,
      hintStyle: context.inputDecorationTheme.hintStyle,
      border: context.inputDecorationTheme.border,
      enabledBorder: context.inputDecorationTheme.enabledBorder,
      focusedBorder: context.inputDecorationTheme.focusedBorder,
      contentPadding: context.inputDecorationTheme.contentPadding,
    );
  }
}
