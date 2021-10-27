class PWindowText {

  //Table sprSheet = loadTable(sketchPath("dict_file.tsv"));

  String expHanja; //한자어
  String expHangul; //한자어 해당한 한글
  String expDef; //한자어 정의
  ArrayList <String> subHanja;   //한자
  ArrayList <String> subHanjaDef; //한자 정의 
  TableRow row; //Object to read from
  int index; //Index of row for checking index of instanced/created PWindowText object

  PWindowText() {
    index = -1;
  }

  PWindowText(TableRow p_row, int p_index) { //Something wrong in when getting values from TableRow object or maybe in Table object where it came from

    row = p_row;
    index = p_index;
    //println(index); //Test
    subHanja = new ArrayList<String>(); //These are ArrayLists since the columns of the TableRow could be any length
    subHanjaDef = new ArrayList<String>();

    expHanja = row.getString(0); //This is correct for the first word only
    expHangul = row.getString(1); // But not correct here
    expDef = row.getString(2); //Or here

    for (int i = 3; i < row.getColumnCount(); i+=2) { //Steps two steps, since every Hanja has a definition in the next column

      subHanja.add(row.getString(i));
      subHanjaDef.add(row.getString(i+1)); 
    }
    
    println(expHanja); //Check
    println(expHangul);
    println(expDef);
    //  for (String subSyl : subHanja)
    //   println(subSyl);
    // for (String subSylDef : subHanjaDef)
    //   println(subSylDef);
  }
}
