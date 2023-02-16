class Constants {
  static String MONGO_CONN_URL =
      "mongodb+srv://Krish:7qj-A9Qr.cJ-STK@cluster.jwxvr.mongodb.net/sample?retryWrites=true&w=majority";

  static String TYPEOFPRODUCT_CAKE = "Cake";
  static String TYPEOFPRODUCT_SNACKS = "Snacks";
  static String CATEGORY_FLAVOUR = "Flavor";
  static String CATEGORY_CUSTOM = "Customized";
  static String CATEGORY_VIVANSSPECIAL = "Vivan's Special";
  static String CATEGORY_OCCASION = "Occasion";
  static String CATEGORY_SPECIALONE = "Special one";
  static String CATEGORY_SNACKS = "Snacks";
  static String TAG_CHOCLATE = "Choclate";
  static String TAG_BLACKFOREST = "Black Forest";
  static String TAG_WHITEFOREST = "White Forest";
  static String TAG_VANILLA = "Vanilla";
  static String TAG_BUTTERSCOTCH = "Butter Scotch";
  static String TAG_STRAWBERRY = "Strawberry";
  static String TAG_REDVELVET = "Red Velvet";
  static String TAG_MANGO = "Mango";
  static String TAG_PINEAPPLE = "Pineapple";
  static String TAG_BLACKCURRENT = "Black Current";
  static String TAG_ORANGE = "Orange";
  static String TAG_FRUITFILLINGS = "Fruit Fillings";
  static String TAG_TRUFFLES = "Truffles";
  static String TAG_PHOTOCAKE = "Photo";
  static String TAG_DESIGNER = "Designer";
  static String TAG_CARTOON = "Cartoon";
  static String TAG_BIRTHDAY = "Birthday";
  static String TAG_ANNIVERSARY = "Anniversary";
  static String TAG_SNACKS = "Snacks";
  static String TAG_ADDONS = "Add Ons";
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
