import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/chatHelper/chat_helper.dart';
import '../../../../model/function_helper/date_time_convertor/date_time_convertor.dart';
import '../../../../view_model/controller/call_controller/agora_controllers/audio_call_controller.dart';
import '../../../widgets/icon_button/icon_button.dart';
import '../../../widgets/video_off_view/video_off_view.dart';


class AudioCallScreen extends StatelessWidget {
  const AudioCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AudioCallController controller = Get.put(AudioCallController());
    double statusBarPadding = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: ChatHelpers.transparent,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                controller.callArguments.themeArguments?.colorArguments?.mainColor ?? ChatHelpers.mainColor,
                controller.callArguments.themeArguments?.colorArguments?.mainColorLight ?? ChatHelpers.mainColorLight,
                controller.callArguments.themeArguments?.colorArguments?.mainColorLight ?? ChatHelpers.grey
              ],
            ),
          ),
          padding: EdgeInsets.only(top: statusBarPadding),
          child: Stack(
            children: [
              Obx(() => _remoteVideo(controller)),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: const EdgeInsets.only(
                          left: ChatHelpers.marginSizeDefault,
                          top: ChatHelpers.marginSizeDefault),
                      width: 130,
                      height: 180,
                      decoration: BoxDecoration(
                          color: controller.callArguments.themeArguments?.colorArguments?.mainColorLight ?? ChatHelpers.mainColorLight,
                          borderRadius: BorderRadius.circular(
                              ChatHelpers.cornerRadius)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              ChatHelpers.cornerRadius),
                          child: Obx(
                            () => Center(
                              child: VideoOffView(
                                backGroundColor: controller.callArguments.themeArguments?.colorArguments?.mainColorLight,
                                textColor: controller.callArguments.themeArguments?.colorArguments?.textColor,
                                imageBaseUrl: controller.callArguments.imageBaseUrl,
                                isRemote: false,
                                users: controller.currentUser.value,
                              ),
                            ),
                          )))),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin:
                      const EdgeInsets.all(ChatHelpers.marginSizeSmall),
                  padding:
                      const EdgeInsets.all(ChatHelpers.marginSizeSmall),
                  decoration: BoxDecoration(
                      color: controller.callArguments.themeArguments?.colorArguments?.mainColorLight ?? ChatHelpers.mainColorLight,
                      borderRadius: BorderRadius.circular(ChatHelpers.buttonRadius)),
                  child: Obx(() => Text(
                        DateTimeConvertor.formattedTime(
                            timeInSecond: controller.start.value),
                        style: ChatHelpers.instance.styleRegular(
                            ChatHelpers.fontSizeSmall,
                            controller.callArguments.themeArguments?.colorArguments?.textColor ?? ChatHelpers.white),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    bottom: ChatHelpers.marginSizeExtraLarge),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleIconButton(
                        shapeRec: false,
                        boxColor: ChatHelpers.red,
                        onTap: () => controller.endCall(false),
                        icons: Icons.call_end_rounded,
                        colors: controller.callArguments.themeArguments?.colorArguments?.iconColor ?? ChatHelpers.white,
                        height: 60,
                        width: 60,
                        isImage: false,
                      ),
                    ),
                    Obx(() => Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleIconButton(
                            shapeRec: false,
                            boxColor: ChatHelpers.black.withOpacity(.3),
                            isImage: false,
                            onTap: () => controller.onMicTap(),
                            icons: controller.isMicOn.isTrue
                                ? Icons.mic
                                : Icons.mic_off,
                            colors:controller.callArguments.themeArguments?.colorArguments?.iconColor ?? ChatHelpers.white,
                            splashColor: ChatHelpers.red,
                            height: 60,
                            width: 60,
                          ),
                        )),
                    Obx(() => Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleIconButton(
                            shapeRec: false,
                            boxColor: ChatHelpers.black.withOpacity(.3),
                            isImage: true,
                            onTap: () => controller.onSpeakerTap(),
                            image: controller.isSpeakerOn.isTrue
                                ? ChatHelpers.instance.speaker
                                : ChatHelpers.instance.speakerOff,
                            colors: controller.callArguments.themeArguments?.colorArguments?.iconColor ?? ChatHelpers.white,
                            height: 60,
                            width: 60,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

Widget _remoteVideo(AudioCallController controller) {
  if (controller.remoteUid.value != 0) {
    return Center(
        child: VideoOffView(
          backGroundColor: controller.callArguments.themeArguments?.colorArguments?.mainColorLight,
          textColor: controller.callArguments.themeArguments?.colorArguments?.textColor,
          imageBaseUrl: controller.callArguments.imageBaseUrl,
          height: 100,
          width: 100,
      fontSize: ChatHelpers.fontSizeDoubleExtraLarge,
      isRemote: true,
      users: controller.user.value,
    ));
  } else {
    return Center(
      child: Text(
        'User Connecting ...',
        style: ChatHelpers.instance.styleMedium(
            ChatHelpers.marginSizeDefault,controller.callArguments.themeArguments?.colorArguments?.textColor ?? ChatHelpers.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
