enum DocumentStatus {
  verified,
  underReview,
  expiringSoon,
  actionRequired,
}

extension DocumentStatusExt on DocumentStatus {
  String get label {
    switch (this) {
      case DocumentStatus.verified:
        return 'Verified';
      case DocumentStatus.underReview:
        return 'Under Review';
      case DocumentStatus.expiringSoon:
        return 'Expiring Soon';
      case DocumentStatus.actionRequired:
        return 'Action Required';
    }
  }
}

class DocumentComplianceItem {
  final String id;
  final String title;
  final String description;
  final String documentNumber;
  final DateTime? expiryDate;
  final DocumentStatus status;
  final String requiredActionNotice;

  const DocumentComplianceItem({
    required this.id,
    required this.title,
    required this.description,
    required this.documentNumber,
    this.expiryDate,
    required this.status,
    this.requiredActionNotice = '',
  });

  int get daysUntilExpiry {
    if (expiryDate == null) return 999;
    return expiryDate!.difference(DateTime.now()).inDays;
  }

  static List<DocumentComplianceItem> mockList() {
    return [
      DocumentComplianceItem(
        id: 'dl',
        title: 'Driving Licence',
        description: 'Commercial 2-wheeler / LM vehicle endorsement',
        documentNumber: 'DL-WB-2018-0094821',
        expiryDate: DateTime.now().add(const Duration(days: 820)),
        status: DocumentStatus.verified,
      ),
      DocumentComplianceItem(
        id: 'rc',
        title: 'Vehicle Registration (RC)',
        description: 'Valid certificate of registration for WB 02 AJ 4492',
        documentNumber: 'RC-WB02AJ4492',
        expiryDate: DateTime.now().add(const Duration(days: 410)),
        status: DocumentStatus.verified,
      ),
      DocumentComplianceItem(
        id: 'insurance',
        title: 'Commercial Insurance Policy',
        description: 'Comprehensive commercial passenger liability policy',
        documentNumber: 'POL-ICICI-8839210',
        expiryDate: DateTime.now().add(const Duration(days: 12)),
        status: DocumentStatus.expiringSoon,
        requiredActionNotice: 'Renew policy within 12 days to prevent duty interruptions.',
      ),
      const DocumentComplianceItem(
        id: 'aadhaar',
        title: 'Identity Verification (Aadhaar/PAN)',
        description: 'Government approved identity and tax credential',
        documentNumber: 'XXXX-XXXX-8921',
        status: DocumentStatus.verified,
      ),
    ];
  }
}

class LearningModuleItem {
  final String id;
  final String title;
  final String summary;
  final int durationMinutes;
  final bool isCompleted;
  final int quizScorePercent;

  const LearningModuleItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.durationMinutes,
    required this.isCompleted,
    this.quizScorePercent = 0,
  });

  static List<LearningModuleItem> mockList() {
    return const [
      LearningModuleItem(
        id: 'safety_1',
        title: 'Defensive Driving & Urban Safety',
        summary: 'Safe braking distances, mirror checks, and high-speed intersections.',
        durationMinutes: 8,
        isCompleted: true,
        quizScorePercent: 100,
      ),
      LearningModuleItem(
        id: 'conduct_2',
        title: 'Customer Conduct & Cleanliness',
        summary: 'Professional communication, luggage care, and dispute mitigation.',
        durationMinutes: 6,
        isCompleted: true,
        quizScorePercent: 95,
      ),
      LearningModuleItem(
        id: 'emergency_3',
        title: 'Emergency SOS & Incident Protocol',
        summary: 'Quick trigger sequence, passenger safety, and 24/7 hotline handoff.',
        durationMinutes: 7,
        isCompleted: true,
        quizScorePercent: 100,
      ),
      LearningModuleItem(
        id: 'parcel_4',
        title: 'Go Parcel Handover & OTP Proof',
        summary: 'Package damage checks, seal integrity, and recipient verification.',
        durationMinutes: 5,
        isCompleted: false,
        quizScorePercent: 0,
      ),
    ];
  }
}
