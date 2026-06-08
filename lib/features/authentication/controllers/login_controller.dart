import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/data/repositories/authentication/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Controllers
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // State
  final isLoading = false.obs;

  // Email Login
  Future<void> emailAndPasswordLogin() async {
    try {
      if (!loginFormKey.currentState!.validate()) return;

      isLoading.value = true;
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );
      isLoading.value = false;

      Get.back();
      Get.snackbar('Thành công', 'Chào mừng bạn quay trở lại!');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String errorMessage = 'Đã có lỗi xảy ra';

      if (e.code == 'user-not-found') {
        errorMessage = 'Email này chưa được đăng ký.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Mật khẩu không chính xác.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Thông tin đăng nhập không hợp lệ hoặc đã hết hạn.';
      }

      Get.snackbar(
        'Lỗi đăng nhập',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Lỗi',
        '',
        messageText: Text(
          'Lỗi hệ thống: $e',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87),
        ),
      );
    }
  }

  // Google Login
  Future<void> googleSignIn() async {
    try {
      isLoading.value = true;
      final userCredential = await AuthenticationRepository.instance.signInWithGoogle();
      isLoading.value = false;

      if (userCredential != null) {
        Get.back();
        Get.snackbar('Thành công', 'Đăng nhập Google thành công!');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Lỗi',
        '',
        messageText: Text(
          e.toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black87),
        ),
      );
    }
  }
}
