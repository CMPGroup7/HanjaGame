//import java.io.BufferedReader;
//import java.io.DataOutputStream;
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.net.URLEncoder;

class PWindowText{
  
  //Table sprSheet = loadTable(sketchPath()+"dict_file.tsv");

  String expHanja; //한자어
  String expHangul; //Hangul
  String expDef; //
  ArrayList <String> subHanja;   //한자
  ArrayList <String> subHanjaDef;
  TableRow row;
  int index;
  
  PWindowText(){}
  
  PWindowText(TableRow p_row, int p_index){
    
    row = p_row;
    index = p_index;
    subHanja = new ArrayList<String>(); 
    subHanjaDef = new ArrayList<String>();
    
    for(int i = 0; i < row.getColumnCount(); i++){
      
      if(i == 0)
        expHanja = row.getString(i);
      if(i == 1)
        expHangul = row.getString(i);
      if(i == 2)
        expDef = row.getString(i);
      if(i % 2 != 0 && i>2)
        subHanja.add(row.getString(i));
      if(i%2 == 0 && i>2)
        subHanjaDef.add(row.getString(i));
      
    }
    
    println(expHanja);
    println(expHangul);
    println(expDef);
    for(String subSyl : subHanja)
      println(subSyl);
    for(String subSylDef : subHanjaDef)
      println(subSylDef);
      
  }
  
  void reset(){
    
  }
  
  }
