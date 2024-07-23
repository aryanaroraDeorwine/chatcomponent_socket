import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../model/chatHelper/chat_helper.dart';


CachedNetworkImage cachedNetworkImage({required String url,BoxFit fit = BoxFit.fill,Color ?color,required bool isProfile,double height = 190 ,double width = 220, String? userName,Color? textColor}){
  return CachedNetworkImage(
    cacheKey: url,
    imageUrl: url,
    fit: fit,
    color: color,
    memCacheHeight: height.toInt(),
    memCacheWidth: width.toInt(),
    placeholder: (context, url) => Padding(
      padding:EdgeInsets.all(isProfile?0:ChatHelpers.marginSizeExtraLarge),
      child: Image.asset(ChatHelpers.instance.loadingGIF,fit: BoxFit.cover,height: 50,width: 50,package: "chat_component",),
    ),
    errorWidget: (context, url, error) => isProfile ? Center(child: Text(userName??"",style:  ChatHelpers.instance.styleBold(ChatHelpers.fontSizeOverExtraLarge, textColor ?? ChatHelpers.white),)) : Padding(
      padding: const EdgeInsets.all(ChatHelpers.marginSizeSmall),
      child: Image.asset(ChatHelpers.instance.errorImage,fit: BoxFit.cover,package: "chat_component",),
    ),
  );
}