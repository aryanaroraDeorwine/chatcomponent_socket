import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../chat_arguments/chat_arguments.dart';
import '../network_services/networking/client/rest_client.dart';
import '../network_services/networking/repo/api_repo.dart';

/// get values form user and add to Chat Arguments to use in whole app

class ChatServices extends GetxService {

  late ChatArguments chatArguments;

  Future<ChatServices> init({
    AttachmentArguments? imageArguments,
    ThemeArguments? themeArguments,
    bool? isVideoCallEnable,
    bool? isAudioCallEnable,
    bool? isAttachmentSendEnable,
    bool? isCameraImageSendEnable,
    bool? isVideoSendEnable,
    String? chatRoomId,
    required String imageBaseUrlFirebase,
    String? agoraAppId,
    String? agoraAppCertificate,
    List<String>? suggestionsMessages,
    List<String>? reactionsEmojisIcons,
    required String firebaseServerKey,
    required String apiBaseUrl,
    required String socketBaseUrl,
    required String userToken,
    required String appType,
  }) async {
    chatArguments = ChatArguments(
      userToken: userToken,
        appType: appType,
        isVideoCallEnable: isVideoCallEnable ?? false,
        isAudioCallEnable: isAudioCallEnable ?? false,
        isAttachmentSendEnable: isAttachmentSendEnable ?? false,
        isCameraImageSendEnable: isCameraImageSendEnable ?? false,
        imageBaseUrl: imageBaseUrlFirebase,
        imageArguments: imageArguments,
        agoraAppId: agoraAppId,
        suggestionsMessages: suggestionsMessages,
        reactionsEmojisIcons: reactionsEmojisIcons,
        agoraAppCertificate: agoraAppCertificate,
        firebaseServerKey: firebaseServerKey,
        isVideoSendEnable: isVideoSendEnable ?? false,
        themeArguments: themeArguments, apiBaseUrl: apiBaseUrl, socketBaseUrl: socketBaseUrl);

    _injectApis();
    return this;
  }

  _injectApis() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton(() => ApiRepo(client: getIt()));
    getIt.registerLazySingleton(() => ApiClient.create());

  }
}
