import 'package:get/get.dart';
import '../../../data/config/app_config.dart';
import '../../../data/models/document_compliance_model.dart';

class KycDocumentsController extends GetxController {
  final documentsList = <DocumentComplianceItem>[].obs;
  final learningModulesList = <LearningModuleItem>[].obs;
  final isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadComplianceData();
  }

  void loadComplianceData() {
    documentsList.assignAll(DocumentComplianceItem.mockList());
    learningModulesList.assignAll(LearningModuleItem.mockList());
  }

  void simulateDocumentUpload(String docId) async {
    isUploading.value = true;
    AppConfig.showInfo(title: 'Uploading Document', message: 'Encrypting and transmitting capture...');
    await Future.delayed(const Duration(milliseconds: 900));
    isUploading.value = false;

    final index = documentsList.indexWhere((d) => d.id == docId);
    if (index != -1) {
      final doc = documentsList[index];
      documentsList[index] = DocumentComplianceItem(
        id: doc.id,
        title: doc.title,
        description: doc.description,
        documentNumber: doc.documentNumber,
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        status: DocumentStatus.underReview,
        requiredActionNotice: 'Uploaded on ${DateTime.now().day}/${DateTime.now().month}. Verification in progress.',
      );
      AppConfig.showSuccess(title: 'Document Submitted', message: '${doc.title} uploaded successfully. Review takes up to 2 hours.',
      );
    }
  }

  void completeLearningQuiz(String moduleId) {
    final index = learningModulesList.indexWhere((m) => m.id == moduleId);
    if (index != -1) {
      final module = learningModulesList[index];
      learningModulesList[index] = LearningModuleItem(
        id: module.id,
        title: module.title,
        summary: module.summary,
        durationMinutes: module.durationMinutes,
        isCompleted: true,
        quizScorePercent: 100,
      );
      AppConfig.showSuccess(title: 'Quiz Passed 100%', message: 'Module "${module.title}" certified and stored on Go Jatra Captain server.',
      );
    }
  }
}
