
Map<Integer, Boolean> keys = new HashMap<>();

void keyReleased() {
  keys.put(keyCode, false);
}

boolean key(Integer c) {
  Boolean r = keys.get(c);
  if (r==null) {
    keys.put(c, false);
    return false;
  }
  return r;
}

void removeNode(node selectedNode){
  for (node n:nodes){
        n.removeConnection(selectedNode);
    }
    selectedNode.removeConnection(selectedNode.mainConnection);
    selectedNode.removeConnection(selectedNode.sideConnection);

    nodes.remove(selectedNode);
}

boolean isEnteringText = false;
void keyPressed(){
  if (key==ENTER){
    isEnteringText=!isEnteringText;
  }

  if (isEnteringText){
    if (selectedNode!=null){
      if (!selectedNode.ntype.family.equals("arg")) return;
      String d = selectedNode.data;
      if (key==BACKSPACE){
        if (d.length()>0) selectedNode.data = d.substring(0,d.length()-1);
      } 
      if (key<127 & key>=32) {
       
        selectedNode.data += key;
      }
    } else {
      if (key==BACKSPACE){
        if (filepath.length()>0) filepath = filepath.substring(0,filepath.length()-1);
      } 
      if (key<127 & key>=32) {
       
        filepath += key;
      }
    }
    return;
  }

  keys.put(keyCode, true);
  if (keyCode==BACKSPACE & selectedNode!=null){
    removeNode(selectedNode);
    selectedNode = null;
  }
  if (key==TAB & selectedNode!=null){
    String family = selectedNode.ntype.family;

    int n = nodeTypeList.indexOf(selectedNode.ntype);
    n = (n+1)%nodeTypeList.size();
    
      while (!family.equals(nodeTypeList.get(n).family)){
        n = (n+1)%nodeTypeList.size();
      }
    selectedNode.morph(nodeTypeList.get(n));
  }

  nodeType ntype = null;
  String t;
  switch (key){
    case 'a':
      ntype = getNamedFamily("arithmetic");
      break;
    case 'b':
    ntype = getNamedFamily("jump");
      break;
    case 'c':
    ntype = getNamedFamily("control");
      break;
    case 't':
    ntype = getNamedFamily("tag");
      break;
    case 'e':
    ntype = getNamedFamily("arg");
      break;
    case 'p':
    ntype = getNamedFamily("preprocessor");
      break;
    case 's':
      graphSave();
      break;
    case 'l':
      graphLoad();
      break;
    case DELETE:
      selectedNode = null;
      nodes = new ArrayList<node>();
      filepath = "";
      break;
    
    case '1':
    t = "byte";
    t += (key(CONTROL)) ? "_d" : "";
    ntype = getNamedFamily(t);
      break;
    case '2':
    t = "word";
    t += (key(CONTROL)) ? "_d" : "";
    ntype = getNamedFamily(t);
      break;
    case '3':
    t = "double";
    t += (key(CONTROL)) ? "_d" : "";
    ntype = getNamedFamily(t);
      break;
    case '4':
    t = "quad";
    t += (key(CONTROL)) ? "_d" : "";
    ntype = getNamedFamily(t);
      break;

  }

  if (ntype!=null){
    if (selectedNode==null){
      node n = new node(mouseX,mouseY,0,ntype);
      nodes.add(n);
      selectedNode=n;
    } else {
      selectedNode.morph(ntype);
    }
  }

}