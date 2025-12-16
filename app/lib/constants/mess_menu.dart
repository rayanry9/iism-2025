List<List<String>> getMessMenuByDayTime(int date) {
  var listStudent = [
    [
      "Milk",
      "Tea",
      "Coffee Powder",
      "Boiled Egg/ Egg Omelet/ [Egg bhurji - alternate days]",
      "Banana",
      "Bread",
      "Toast Bread",
      "Butter",
      "Fruit Jam",
      "Sprouts(Chana, mung ean sprouts)",
      "Oats",
      "Seasonal Fruit juice",
      "Pickle",
      "Sauce",
      "Peanut butter",
      "Chocos",
    ],
    [
      "Salad (Vegetables)",
      "Papad",
      "Curd",
      "Pickle",
      "Roti",
      "Sambar",
      "Rasam",
      "White rice",
      "Fresh juice",
      "Fruits (Apple & Gauva)",
      "Ghee",
      "Butter",
      "Soup (Veg & Non Veg)",
      "Sweets (Every day different)",
      "Mouth freshener - Fennel seeds, rock sugar toothpick",
    ],
    [
      "Salad (Vegetables)",
      "Papad",
      "Curd",
      "Pickle",
      "Roti",
      "Sambar",
      "Rasam",
      "White rice",
      "Fresh juice",
      "Ghee",
      "Butter",
      "Soup (Veg & Non Veg)",
      "Sweets",
      "Hot milk (Haldi, Badam)",
      "Mouth freshener - Fennel seeds, rock sugar toothpick",
    ],
  ];
  var listStaff = [
    [
      "Milk",
      "Tea",
      "Coffee Powder",
      "Boiled Egg/ Egg Omelet/ [Egg bhurji - alternate days]",
      "Banana",
      "Bread",
      "Toast Bread",
      "Butter",
      "Fruit Jam",
      "Sprouts(Chana, mung ean sprouts)",
      "Corn flakes",
      "Seasonal Fruit juice",
      "Pickle",
      "Sauce",
      "Peanut butter",
    ],
    [
      "Salad (Vegetables)",
      "Papad",
      "Curd",
      "Pickle",
      "Roti",
      "Sambar",
      "Rasam",
      "White rice",
      "Fresh juice",
      "Fruits (Apple & Gauva)",
      "Ghee",
      "Butter",
      "Soup (Veg & Non Veg)",
      "Sweets",
    ],
    [
      "Salad (Vegetables)",
      "Papad",
      "Curd",
      "Pickle",
      "Roti",
      "Sambar",
      "Rasam",
      "White rice",
      "Fresh juice",
      "Ghee",
      "Butter",
      "Soup (Veg & Non Veg)",
      "Sweets",
      "Hot milk (Haldi, Badam)",
    ],
  ];
  switch (date) {
    case 12:
      listStudent[0].addAll([]); // No breakfast on 12 Dec
      listStudent[1].addAll([]); // No lunch on 12 Dec
      listStudent[2].addAll([
        "Papdi chaat",
        "Moong dal halwa",
        "Veg Biryani",
        "Butter Naan",
        "Chana Masala",
        "Egg Biryani",
        "Chicken Curry",
        "Kofta",
      ]);
      return listStudent;
    case 13:
      listStudent[0].addAll([
        "Rava / Ragi Idli sambar",
        "Mint chutney",
        "Dal chutney",
        "Khichdi",
      ]);

      listStudent[1].addAll([
        "Jeera Rice",
        "Mix dal",
        "Paneer tikka masala",
        "Black chana curry",
        "Curry (Jain)",
        "Dal (Jain)",
        "Kolhapuri Chicken curry",
        "Kheer",
      ]);

      listStudent[2].addAll([
        "Veg Pulao rice",
        "Aloo Gobi",
        "Matar Paneer",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Fry Chicken",
      ]);

      return listStudent;
    case 14:
      listStudent[0].addAll([
        "Rice Idli, sambar, mint chutney, dal chatni",
        "Medu vada",
        "Freid idli & coconut chutney",
      ]);
      listStudent[1].addAll([
        "Butter Chapati",
        "Kadhi pakoda",
        "Dry Aloo curry",
        "Kadai Paneer",
        "Dal",
        "Butter Chicken",
        "Curry (Jain)",
        "Dal (Jain)",
      ]);
      listStudent[2].addAll([
        "Gulab Jamun",
        "Butter naan",
        "Dal makhani",
        "Dry Lady finger",
        "Paneer Masala",
        "Veg Biryani",
        "Chicken Biryani",
        "Salan",
        "Curry (Jain)",
        "Dal (Jain)",
      ]);
      return listStudent;
    case 15:
      listStudent[0].addAll(["Aalu puri sabji", "Upama"]);
      listStudent[1].addAll([
        "Basmati rice",
        "Dal fry",
        "Dahi Chhachh",
        "Mix veg",
        "White matar masala",
        "Curry (Jain)",
        "Dal (Jain)",
      ]);
      listStudent[2].addAll([
        "Rasgulla",
        "Dal Fry",
        "Paneer tikka",
        "Jeera rice",
        "Curry (Jain)",
        "Dal (Jain)",
        "Fish Curry",
        "Egg Biryani",
      ]);
      return listStudent;
    case 16:
      listStudent[0].addAll([
        "Uttapam",
        "Set dosa",
        "Sambar",
        "Mint chutney",
        "Dal chutney",
        "Coconut chutney",
      ]);
      listStudent[1].addAll([
        "Mix dal",
        "Paneer butter masala",
        "Rajma",
        "Curry (Jain)",
        "Dal (Jain)",
        "Mutton curry",
        "Egg bhurji",
      ]);
      listStudent[2].addAll([
        "Chamcham",
        "Paneer Bhurji",
        "Tandoori roti",
        "Mandi rice",
        "Dal Fry",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Egg curry",
      ]);
      return listStudent;
    case 17:
      listStudent[0].addAll([
        "Masala Dosa",
        "Sambar",
        "Mint chutney",
        "Dal chutney",
        "Wada",
      ]);
      listStudent[1].addAll([
        "Dal tadka",
        "Mix veg",
        "Chole",
        "Paneer do pyaza",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken hyderabadi curry",
      ]);
      listStudent[2] = [
        "Chilli paneer",
        "Veg pasta",
        "Paneer 65",
        "Hara Bhara kabab",
        "Pani puri",
        "Kachori chaat",
        "Aloo tikki chaat",
        "Papdi chaat",
        "Manchow Soup",
        "Sweet Corn Soup",
        "Spring roll",
        "Crispy corn",
        "Hakka noodles",
        "Chicken 65",
        "Chicken tandoori",
        "Fish fry",
        "Chicken lollipop",
        "Mutton kabab",
        "Paneer butter masala",
        "Paneer kolhapuri",
        "Dal tadka",
        "Malai kofta",
        "Mix veg",
        "Bhindi fry",
        "Steam rice",
        "Jeera rice",
        "Veg Dum Biryani",
        "Rumali roti",
        "Dum Chicken curry",
        "Mutton masala",
        "Hyderabadi biryani",
        "Rabdi funnel cake",
        "Apricot delight",
        "Moong dal halwa",
        "Ice creams",
        "Mocktails",
      ];
      return listStudent;
    case 18:
      listStudent[0].addAll([
        "Rava/Ragi Idli",
        "Sambar",
        "Mint chutney",
        "Dal chutney",
        "Khichdi",
      ]);
      listStudent[1].addAll([
        "Jeera Rice",
        "Mix dal",
        "Paneer tikka masala",
        "Black chana curry",
        "Curry (Jain)",
        "Dal (Jain)",
        "Kolhapuri Chicken curry",
      ]);
      listStudent[2].addAll([
        "Papdi chaat",
        "Moong dal halwa",
        "Veg Biryani",
        "Naan",
        "Chana masala",
        "Kofta",
        "Curry (Jain)",
        "Dal (Jain)",
        "Egg Biryani",
        "Chicken Curry",
      ]);
      return listStudent;
    case 19:
      listStudent[0].addAll([
        "Veg cutlet",
        "Mint chutney",
        "Dal chutney",
        "Aalu paratha",
      ]);
      listStudent[1].addAll([
        "Butter Roti",
        "Basmati rice",
        "Dal fry",
        "Mix veg",
        "Palak Paneer",
        "Curry (Jain)",
        "Kashmiri Chicken curry",
        "Kheer",
      ]);
      listStudent[2].addAll([
        "Veg Pulao rice",
        "Aloo Gobi",
        "Matar Paneer",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Fry Chicken",
      ]);
      return listStudent;
    case 20:
      listStudent[0].addAll(["Pav bhaji", "Upama"]);
      listStudent[1].addAll([
        "Mix Dal",
        "Kaju Paneer",
        "Mix veg",
        "Curry (Jain)",
        "Dal (Jain)",
        "Mughlai Mutton curry",
      ]);
      listStudent[2].addAll([
        "Rasmalai",
        "Tandoori roti",
        "Lemon rice",
        "Malai Kofta",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken 65 fry",
        "Egg masala",
      ]);
      return listStudent;
    case 21:
      listStudent[0].addAll(["Poha", "Jilebi", "Bread pakoda", "Aloo paratha"]);
      listStudent[1].addAll([
        "Chole masala",
        "Paneer masala",
        "Curry (Jain)",
        "Dal (Jain)",
      ]);
      listStudent[2].addAll([
        "Butter Chicken",
        "Dabal ka Mitha",
        "Naan",
        "Pudina rice",
        "Dal fry",
        "Kaju kurma",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Mutton curry",
      ]);
      return listStudent;
    case 22:
      listStudent[0].addAll([
        "Masala Dosa",
        "Sambar",
        "Mint chutney",
        "Dal chutney",
        "Wada",
      ]);
      listStudent[1].addAll([]);
      listStudent[2].addAll([
        "Dal tadka",
        "Mix veg",
        "Chole",
        "Paneer do pyaza",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken hyderabadi curry",
      ]);
      return listStudent;

    case 23:
      listStaff[0].addAll(["Poha", "Jilebi", "Bread pakoda"]);
      listStaff[1].addAll([
        "Chole masala",
        "Paneer masala",
        "Curry (Jain)",
        "Dal (Jain)",
      ]);
      listStaff[2].addAll([
        "Butter Chicken",
        "Dabal ka Mitha",
        "Butter Naan",
        "Pudina rice",
        "Dal fry",
        "Kaju kurma",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Mutton curry",
      ]);
      return listStaff;

    case 24:
      listStaff[0].addAll([
        "Idli",
        "Sambar",
        "Mint chutney",
        "Dal chatni",
        "Medu vada",
        "Fried idli",
        "Coconut chutney",
      ]);
      listStaff[1].addAll([
        "Butter chapati",
        "Kadhi pakoda",
        "Dry Aloo curry",
        "Kadai Paneer",
        "Dal",
        "Curry (Jain)",
        "Dal (Jain)",
      ]);
      listStaff[2].addAll([
        "Butter chicken",
        "Gulab Jamun",
        "Butter naan",
        "Dal makhani",
        "Dry Lady finger",
        "Paneer masala",
        "Veg Biryani",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Salan",
      ]);
      return listStaff;

    case 25:
      listStaff[0].addAll([
        "Uttapam",
        "Set dosa",
        "Sambar",
        "Mint chutney",
        "Dal chatni",
        "Coconut chutney",
      ]);
      listStaff[1].addAll([
        "Mix dal",
        "Paneer butter masala",
        "Rajma",
        "Curry (Jain)",
        "Dal (Jain)",
        "Mutton curry",
        "Egg burji",
      ]);
      listStaff[2].addAll([
        "Chamcham",
        "Tandoori roti",
        "Mandi rice",
        "Paneer bhurji",
        "Palak Paneer",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Egg curry",
      ]);
      return listStaff;

    case 26:
      listStaff[0].addAll([
        "Masala Dosa",
        "Sambar",
        "Mint chutney",
        "Dal chatni",
        "Wada",
      ]);

      listStaff[1].addAll([
        "Dal tadka",
        "Mix veg",
        "Chole",
        "Paneer roti",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken hyderabadi curry",
      ]);

      // Gala Dinner replaces normal dinner
      listStaff[2].addAll([
        // Veg Starters
        "Chilli paneer",
        "Veg pasta (white & red sauce)",
        "Paneer 65",
        "Hara Bhara kabab",
        "Pani puri (multi flavor water)",
        "Kachori chaat",
        "Aloo tikki chaat",
        "Papdi chaat",
        "Manchow Soup",
        "Sweet Corn Soup",
        "Spring roll",
        "Crispy corn",
        "Hakka noodles",

        // Non-veg starters
        "Chicken 65",
        "Chicken tandoori",
        "Fish fry (Murrel & Catla)",
        "Chicken lollipop",
        "Mutton kabab",

        // Veg Main Course
        "Paneer butter masala",
        "Paneer kolhapuri",
        "Dry Fry Bhindi",
        "Malai kofta",
        "Mix veg",
        "Dal tadka (live)",
        "Steam rice",
        "Jeera rice",
        "Veg Dum Biryani",

        // Non-veg main course
        "Dum ka Red Chicken Curry",
        "Murgh makkanwala",
        "Mutton masala",
        "Chicken Dum Biryani (with raita & salan)",

        // Mughlai Zone
        "Rumali roti",

        // Desserts & sweets
        "Funnel cake with Rabdi",
        "Apricot Delight",
        "Moong dal halwa",
        "Cream salad",
        "Kesariya jalebi with rabri",
        "Ice cream – 5 types",
        "Paan (Zero tobacco)",

        // Mocktails
        "Blue Lagoon",
        "Blue berry mint & lime",
        "Mojito",
        "Orange juice",
      ]);

      return listStaff;

    case 27:
      listStaff[0].addAll([
        "Veg cutlet",
        "Mint chutney",
        "Dal chatni",
        "Aalu paratha",
      ]);
      listStaff[1].addAll([
        "Butter Roti",
        "Basmati rice",
        "Dal fry",
        "Mix veg",
        "Palak Panner",
        "Kashmiri Chicken curry",
      ]);
      listStaff[2].addAll([
        "Khir",
        "Veg Pulao rice",
        "Aloo Gobi",
        "Matar Paneer",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Fry Chicken",
      ]);
      return listStaff;

    case 28:
      listStaff[0].addAll(["Pav bhaji", "Upama"]);
      listStaff[1].addAll([
        "Mix Dal",
        "Kaju Paneer",
        "Mix veg",
        "Curry (Jain)",
        "Dal (Jain)",
        "Mughlai Mutton curry",
      ]);
      listStaff[2].addAll([
        "Rasmalai",
        "Tandoori roti",
        "Lemon rice",
        "Malai Kofta",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken 65 fry",
        "Egg masala",
      ]);
      return listStaff;

    case 29:
      listStaff[0].addAll(["Poha", "Jilebi", "Bread pakoda", "Aloo paratha"]);
      listStaff[1].addAll([
        "Chole masala",
        "Paneer masala",
        "Curry (Jain)",
        "Dal (Jain)",
      ]);
      listStaff[2].addAll([
        "Butter Chicken",
        "Dabal ka Mitha",
        "Naan",
        "Pudina rice",
        "Dal fry",
        "Kaju kurma",
        "Curry (Jain)",
        "Dal (Jain)",
        "Chicken biryani",
        "Mutton curry",
      ]);
      return listStaff;

    case 30:
      listStaff[0].addAll([
        "Idli",
        "Sambar",
        "Mint chutney",
        "Dal chatni",
        "Medu vada",
        "Fried idli",
        "Coconut chutney",
      ]);
      listStaff[1].addAll([]);
      listStaff[2].addAll([]);
      return listStaff;
    default:
      return [];
  }
}
