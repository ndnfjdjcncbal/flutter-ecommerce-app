import '../../../core/classes/crud.dart';
import '../../../linkapi.dart';

class Profile {
  final crud crud1;

  Profile(this.crud1);

  Future<dynamic> updateProfile({
    required String userId,
    required String userName,
    required String userEmail,
  }) async {
    var response = await crud1.postdata(Linkapi.updateprofiel, {
      "user_id": userId,
      "user_name": userName,
      "user_email": userEmail,
    });

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> updateProfileImage({
    required String userId,
    required String imagePath,
  }) async {
    var response = await crud1.postdataWithFile(
      Linkapi.updateImage,
      {"user_id": userId},
      "user_image",
      imagePath,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getProfile({required String userId}) async {
    var response = await crud1.postdata(Linkapi.getProfile, {
      "user_id": userId,
    });

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    var response = await crud1.postdata(Linkapi.changePassword, {
      "user_id": userId,
      "current_password": currentPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    });

    return response.fold((l) => l, (r) => r);
  }
}
