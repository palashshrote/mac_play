class Borewell {
  final String borewellKey;
  final String borewellName;

  Borewell({required this.borewellKey, required this.borewellName});

  // Factory method to create a Borewell object from Firestore data
  factory Borewell.fromFirestore(Map<String, dynamic> data) {
    return Borewell(
      borewellKey: data['BorewellKey'],
      borewellName: data['BorewellName'],
    );
  }
}
