class PWindowText {

  //Table sprSheet = loadTable(sketchPath("dict_file.tsv"));

  String expHanja; //한자어
  String expHangul; //Hangul
  String expDef; //
  ArrayList <String> subHanja;   //한자
  ArrayList <String> subHanjaDef;
  TableRow row;
  int index;

  PWindowText() {
    index = -1;
  }

  PWindowText(TableRow p_row, int p_index) {

    row = p_row;
    index = p_index;
    println(index);
    subHanja = new ArrayList<String>();
    subHanjaDef = new ArrayList<String>();

    expHanja = row.getString(0);
    expHangul = row.getString(1);
    expDef = row.getString(2);

    for (int i = 3; i < row.getColumnCount(); i+=2) {

      subHanja.add(row.getString(i));
      subHanjaDef.add(row.getString(i+1));
    }
    
     println(expHanja);
    println(expHangul);
    println(expDef);
    //  for (String subSyl : subHanja)
    //   println(subSyl);
    // for (String subSylDef : subHanjaDef)
    //   println(subSylDef);
  }
}
