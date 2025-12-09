List<String> getAllIITNames() {
  return [
    'Bombay',
    'Bhubaneswar',
    'Bhilai',
    '(BHU) Varanasi',
    'Delhi',
    'Dharwad',
    'Guwahati',
    'Gandhinagar',
    'Goa',
    'Hyderabad',
    'Indore',
    '(ISM) Dhanbad',
    'Jodhpur',
    'Jammu',
    'Kanpur',
    'Kharagpur',
    'Madras',
    'Mandi',
    'Patna',
    'Palakkad',
    'Roorkee',
    'Ropar',
    'Tirupati',
  ];
}

String getIITImgSrcFromName(String name) {
  switch (name) {
    case "Bombay":
      return "assets/logos/iitb.webp";
    case "Bhubaneswar":
      return "assets/logos/iitbbs.webp";
    case "Bhilai":
      return "assets/logos/iitbh.webp";
    case "(BHU) Varanasi":
      return "assets/logos/iitbhu.webp";
    case "Delhi":
      return "assets/logos/iitd.webp";
    case "Dharwad":
      return "assets/logos/iitdh.webp";
    case "Guwahati":
      return "assets/logos/iitg.webp";
    case "Gandhinagar":
      return "assets/logos/iitgn.webp";
    case "Goa":
      return "assets/logos/iitg.webp";
    case "Hyderabad":
      return "assets/logos/iith.webp";
    case "Indore":
      return "assets/logos/iiti.webp";
    case "(ISM) Dhanbad":
      return "assets/logos/iitism.webp";
    case "Jodhpur":
      return "assets/logos/iitj.webp";
    case "Jammu":
      return "assets/logos/iitjmu.webp";
    case "Kanpur":
      return "assets/logos/iitk.webp";
    case "Kharagpur":
      return "assets/logos/iitkgp.webp";
    case "Madras":
      return "assets/logos/iitm.webp";
    case "Mandi":
      return "assets/logos/iitmd.webp";
    case "Patna":
      return "assets/logos/iitp.webp";
    case "Palakkad":
      return "assets/logos/iitpkd.webp";
    case "Roorkee":
      return "assets/logos/iitr.webp";
    case "Ropar":
      return "assets/logos/iitrpr.webp";
    case "Tirupati":
      return "assets/logos/iittp.webp";
    default:
      return "";
  }
}
