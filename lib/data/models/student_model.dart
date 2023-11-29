class StudentModel {
  final String fio;
  final num studPassportNum;
  final String department;
  final num yearOfEntering;
  final num yearOfEnding;
  final String degree;
  final bool archiveIndicator;
  final String vkrName;
  final String vkrMark;
  final String faculty;
  final String departmentName;
  final String departmentHead;

  StudentModel(
      this.fio,
      this.studPassportNum,
      this.department,
      this.yearOfEntering,
      this.yearOfEnding,
      this.archiveIndicator,
      this.degree,
      this.vkrName,
      this.vkrMark,
      this.faculty,
      this.departmentName,
      this.departmentHead);
}
