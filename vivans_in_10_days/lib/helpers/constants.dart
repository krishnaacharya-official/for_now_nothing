class Constants {
  static String CATEGORY_FLAVOUR = "Flavor";
  static String CATEGORY_CUSTOM = "Customized";
  static String CATEGORY_VIVANSSPECIAL = "Vivan's Special";
  static String CATEGORY_OCCASION = "Occasion";
  static String CATEGORY_SPECIALONE = "Special one";
  static String CATEGORY_SNACKS = "Snacks";
}

enum CategoryList {
  CATEGORY_FLAVOUR,
  CATEGORY_CUSTOM,
  CATEGORY_VIVANSSPECIAL,
  CATEGORY_OCCASION,
  CATEGORY_SPECIALONE,
  CATEGORY_SNACKS
}

String getCategory(CategoryList categoryList) {
  switch (categoryList) {
    case CategoryList.CATEGORY_CUSTOM:
      return Constants.CATEGORY_CUSTOM;
    case CategoryList.CATEGORY_FLAVOUR:
      return Constants.CATEGORY_FLAVOUR;
    case CategoryList.CATEGORY_OCCASION:
      return Constants.CATEGORY_OCCASION;
    case CategoryList.CATEGORY_SNACKS:
      return Constants.CATEGORY_SNACKS;
    case CategoryList.CATEGORY_SPECIALONE:
      return Constants.CATEGORY_SPECIALONE;

    default:
      return Constants.CATEGORY_VIVANSSPECIAL;
  }
}
