class JudgmentModel {
  final String id;
  final String soBanAn;
  final String ngayTuyen;
  final String toiDanh;
  final String hanhVi;
  final String hinhPhat;
  final String dieuLuat;
  final bool anTreo;

  JudgmentModel({
    required this.id,
    required this.soBanAn,
    required this.ngayTuyen,
    required this.toiDanh,
    required this.hanhVi,
    required this.hinhPhat,
    required this.dieuLuat,
    required this.anTreo,
  });

  factory JudgmentModel.fromJson(Map<String, dynamic> json) {
    return JudgmentModel(
      id: json['id'] as String? ?? '',
      soBanAn: json['so_ban_an'] as String? ?? '',
      ngayTuyen: json['ngay_tuyen'] as String? ?? '',
      toiDanh: json['toi_danh'] as String? ?? '',
      hanhVi: json['hanh_vi'] as String? ?? '',
      hinhPhat: json['hinh_phat'] as String? ?? '',
      dieuLuat: json['dieu_luat'] as String? ?? '',
      anTreo: json['an_treo'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'so_ban_an': soBanAn,
      'ngay_tuyen': ngayTuyen,
      'toi_danh': toiDanh,
      'hanh_vi': hanhVi,
      'hinh_phat': hinhPhat,
      'dieu_luat': dieuLuat,
      'an_treo': anTreo,
    };
  }
}
