import 'package:chat_component/chat_components/model/chatHelper/chat_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final double? marginValue;
  final String? iconData;
  final bool? obscureText;
  final Widget? prefixIcon;
  final bool? readOnly;
  final bool? showShadow;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final Color? containerColor;
  final Color? cursorColor;
  final Color? outLineColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? borderColor;
  final int? maxLength;
  final int? maxLines;
  final double? height;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Function(String)? onValueChanged;
  final TextStyle? style;
  final TextStyle? hintStyle;
   RxInt textLength =0.obs;

   CommonTextField(
      {super.key,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization,
      this.onFieldSubmitted,
      this.initialValue,
      this.hintText,
      this.errorText,
      this.showShadow,
      this.iconData,
      this.obscureText,
      this.prefixIcon,
      this.inputFormatters,
      required this.controller,
      this.containerColor,
      this.cursorColor,
      this.outLineColor,
      this.autofocus,
      this.borderRadius,
      this.hintColor,
      this.errorColor,
      this.maxLength,
      this.suffixIcon,
      this.onValueChanged,
      this.style,
      this.hintStyle,
      this.borderColor,
      this.readOnly, this.marginValue, this.maxLines, this.height}){
    textLength.value = controller.text.length;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height??55,
          margin: EdgeInsets.all(marginValue ?? 0),
          decoration: showShadow == true
              ? BoxDecoration(
                  color: ChatHelpers.white,
                  borderRadius: BorderRadius.circular(borderRadius??6),
                  boxShadow: const [
                    BoxShadow(
                      color: ChatHelpers.mainColorLight,
                      blurRadius: 15.0,
                    ),
                  ],
                  border: Border.all(
                    width: 1.5,
                    color:borderColor?? ChatHelpers.black.withOpacity(.5),
                  ))
              : BoxDecoration(
                  color: ChatHelpers.white,
                  borderRadius: BorderRadius.circular(borderRadius??10),
                  border: Border.all(color: borderColor??ChatHelpers.black.withOpacity(.5), width: 1.5)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  maxLines: maxLines,
                  controller: controller,
                  readOnly: readOnly ?? false,
                  inputFormatters: inputFormatters,
                  autofocus:autofocus??false ,
                  textInputAction: textInputAction ?? TextInputAction.done,
                  keyboardType: keyboardType,
                  maxLength: maxLength,
                  onChanged: (value){
                    textLength.value =value.length;
                    try{
                      onValueChanged!(value);
                    }catch(_){}
                  },
                  cursorColor: ChatHelpers.mainColor,
                  style: style ?? ChatHelpers.instance.styleRegular(ChatHelpers.fontSizeLarge, ChatHelpers.black),
                  onFieldSubmitted: onFieldSubmitted,
                  decoration: InputDecoration(
                      prefixIcon: prefixIcon,
                      hintText: hintText,
                      counterText: "",
                      hintStyle: hintStyle ?? ChatHelpers.instance.styleRegular(ChatHelpers.fontSizeLarge, ChatHelpers.textColor_4),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        bottom: 0,
                        left: 15,
                        top: prefixIcon != null ? 12 : -2,
                        right: 15,
                      ),
                      errorText: "",
                      errorStyle: const TextStyle(
                        height: 0,
                      )),
                  validator: validator,
                ),
              ),
              suffixIcon ?? Obx(()=>textLength.value != 0? InkWell(
                onTap: (){
                  textLength.value=0;
                  controller.clear();
                  try{
                    onValueChanged!("");
                  }catch(_){}
                },
                child: Container(
                  margin:const EdgeInsets.only(right:ChatHelpers.marginSizeDefault,left: ChatHelpers.marginSizeDefault),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ChatHelpers.black,width: 1.5)
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: ChatHelpers.black,
                    size: 15,
                  ),
                ),
              ):const SizedBox()),
            ],
          ),
        ),
        errorText == null || errorText == ""
            ? const SizedBox()
            : Padding(padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 0),
                child: Text(
                  errorText??"",
                  style: ChatHelpers.instance.styleRegular(
                      ChatHelpers.fontSizeDefault,
                      ChatHelpers.red),
                  textAlign: TextAlign.start,
                ),
              ),
      ],
    );
  }
}
