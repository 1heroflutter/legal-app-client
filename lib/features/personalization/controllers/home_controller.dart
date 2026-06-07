import 'package:get/get.dart';
import 'package:client/data/repositories/judgment/judgment_repository.dart';
import 'package:client/features/personalization/models/judgment_model.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final JudgmentRepository _judgmentRepository = JudgmentRepository();

  // Observable states
  final RxList<JudgmentModel> judgments = <JudgmentModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRandomJudgments();
  }

  /// Fetch a random list of judgments
  Future<void> fetchRandomJudgments() async {
    try {
      isLoading.value = true;
      final result = await _judgmentRepository.fetchRandomJudgments(limit: 5);
      judgments.assignAll(result);
    } catch (e) {
      // Typically we'd use a Snackbar here to show error
      print('Error fetching judgments: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
