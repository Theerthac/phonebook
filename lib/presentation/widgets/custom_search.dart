import 'package:flutter/material.dart';
import 'package:phonebook/core/constants/colors.dart';

class SearchField extends StatefulWidget {
  final String? boxname;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? leadingIcon;
  final IconData? suffixIcon;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final Function(String)? onChanged;

  final Color? fillColor;
  final Color? hintTextColor;
  final Color? borderColor;

  const SearchField({
    Key? key,
    this.boxname,
    this.hintText = '',
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.leadingIcon,
    this.suffixIcon,
    this.borderRadius,
    this.width,
    this.height,
    this.onChanged,
    this.fillColor,
    this.hintTextColor,
    this.borderColor,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    final Color greyShade = widget.hintTextColor ?? const Color(0xFFAAAAAA);
    final Color borderClr = widget.borderColor ?? const Color(0xFFDDDDDD);
    final Color bgClr = widget.fillColor ?? Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.boxname != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.boxname!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPassword ? _isObscured : false,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: greyShade,
                  fontWeight: FontWeight.w500,
                ),
                fillColor: bgClr,
                filled: true,
                prefixIcon: widget.leadingIcon != null
                    ? Icon(widget.leadingIcon, color: greyBorder)
                    : null,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      )
                    : (widget.suffixIcon != null
                          ? Icon(
                              widget.suffixIcon,
                              color: Colors.black,

                              size: 20,
                            )
                          : null),
                enabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderClr),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderClr, width: 1.2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
