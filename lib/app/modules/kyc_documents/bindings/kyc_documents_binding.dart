import 'package:get/get.dart';
import '../controllers/kyc_documents_controller.dart';

class KycDocumentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycDocumentsController>(() => KycDocumentsController());
  }
}
