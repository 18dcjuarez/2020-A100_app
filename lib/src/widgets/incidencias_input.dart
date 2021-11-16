part of "incidencias_widgets.dart";

//ignore: must_be_immutable
class IncidenciasInput extends StatefulWidget {
  final String label;
  final String? error;
  final String? placeholder;
  final bool showMaskIcon;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final TextEditingController controller;
  final AutovalidateMode autoValidateMode;
  final List<TextInputFormatter> formatters;
  final void Function(String)? onChanged;
  final String? Function(String?) validator;
  final bool? enabled;
  final String? initialValue;
  bool obscure;

  IncidenciasInput.text(
      {required this.focusNode,
      required this.controller,
      this.error,
      this.onChanged,
      this.label = 'Label',
      this.obscure = false,
      this.placeholder = 'Hint',
      this.showMaskIcon = false,
      this.formatters = const [],
      this.textInputType = TextInputType.text,
      this.validator = Validators.notEmptyValidator,
      this.autoValidateMode = AutovalidateMode.onUserInteraction,
      this.enabled,
      this.initialValue}) {
    this.createState();
  }

  IncidenciasInput.email(
      {required this.focusNode,
      required this.controller,
      this.error,
      this.onChanged,
      this.label = 'Label',
      this.obscure = false,
      this.placeholder = 'Hint',
      this.showMaskIcon = false,
      this.formatters = const [],
      this.validator = Validators.emailValidator,
      this.textInputType = TextInputType.emailAddress,
      this.autoValidateMode = AutovalidateMode.onUserInteraction,
      this.enabled,
      this.initialValue}) {
    this.createState();
  }

  IncidenciasInput.password(
      {required this.focusNode,
      required this.controller,
      this.error,
      this.onChanged,
      this.placeholder,
      this.label = 'Label',
      this.obscure = true,
      this.showMaskIcon = true,
      this.formatters = const [],
      this.validator = Validators.passwordValidator,
      this.textInputType = TextInputType.visiblePassword,
      this.autoValidateMode = AutovalidateMode.onUserInteraction,
      this.enabled,
      this.initialValue}) {
    this.createState();
  }

  @override
  _IncidenciasInput createState() => _IncidenciasInput();
}

class _IncidenciasInput extends State<IncidenciasInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: incidenciasDarkBlue,
      focusNode: widget.focusNode,
      obscureText: widget.obscure,
      onChanged: widget.onChanged,
      controller: widget.controller,
      inputFormatters: widget.formatters,
      keyboardType: widget.textInputType,
      enabled: widget.enabled,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorText: widget.error,
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: incidenciasDarkGrey,
          fontWeight: FontWeight.w300,
        ),
        hintText: widget.placeholder,
        hintStyle: const TextStyle(
          color: incidenciasDarkGrey,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: const EdgeInsets.only(left: 10.0),
        enabledBorder: inputBorder(color: incidenciasDarkGrey),
        focusedBorder: inputBorder(),
        border: inputBorder(),
        errorBorder: inputBorder(color: incidenciasRed),
        disabledBorder: inputBorder(color: incidenciasLightGrey),
        suffixIcon: widget.showMaskIcon
            ? IconButton(
                icon: const Icon(Icons.remove_red_eye_outlined),
                onPressed: () =>
                    this.setState(() => widget.obscure = !widget.obscure),
              )
            : null,
      ),
      style: TextStyle(
        color: incidenciasBlack,
        fontWeight: FontWeight.w300,
        fontSize: 14.w,
      ),
      validator: widget.validator,
    );
  }

  InputBorder inputBorder({Color color = incidenciasDarkBlue}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(5.h),
    );
  }
}
