
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

void keyPressed() {
  keys.put(keyCode, true);
  if (keyCode==BACKSPACE & selectedNode!=null){
    removeNode(selectedNode);
  }
  if (key==TAB & selectedNode!=null){
    String family = selectedNode.ntype.family;

    int n = nodeTypeList.indexOf(selectedNode.ntype);
    n = (n+1)%nodeTypeList.size();
    
       // print((nodeTypeList.get(n).family));
      while (!family.equals(nodeTypeList.get(n).family)){
        n = (n+1)%nodeTypeList.size();
      }
    selectedNode.morph(nodeTypeList.get(n));
  }

  nodeType ntype = null;
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
    case 's':
    ntype = getNamedFamily("arg");
      break;
    
    
    case '1':
    ntype = getNamedFamily("byte");
      break;
    case '2':
    ntype = getNamedFamily("word");
      break;
    case '3':
    ntype = getNamedFamily("double");
      break;
    case '4':
    ntype = getNamedFamily("quad");
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