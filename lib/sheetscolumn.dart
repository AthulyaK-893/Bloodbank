class SheetsColumn {
  static final String name = "name";
  static final String lastname = "lastname";
  static final String dateofbirth = "dateofbirth";
  static final String gender = "gender";
  static final String phone = "phone";
  static final String department = "department";
  static final String selectedValue="bloodGroup";

  static List<String> getColumns() => [
        name,
        lastname,
        dateofbirth,
        gender,
        phone,
        department,
        selectedValue
      ];
}
