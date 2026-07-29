
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

void keyPressed() {
  keys.put(keyCode, true);
  if (keyCode==BACKSPACE & selectedNode!=null){
    
    for (node n:nodes){
        n.removeConnection(selectedNode);
    }
    selectedNode.removeConnection(selectedNode.mainConnection);
    selectedNode.removeConnection(selectedNode.sideConnection);

    nodes.remove(selectedNode);
  }
  if (key==TAB & selectedNode!=null){
    String family = selectedNode.nfamily;

    int n = nodeTypeList.indexOf(selectedNode.ntype);
    n = (n+1)%nodeTypeList.size();
    while (!family.equals(nodeTypeList.get(n).family)){
      n = (n+1)%nodeTypeList.size();
    }
    selectedNode.morph(nodeTypeList.get(n));
  }

  nodeType ntype = null;
  switch (key){
    case 'a':
      ntype = getNamedType("inc");
      break;
    case 'f':
    ntype = getNamedType("nop");
      break;
    case 'c':
    ntype = getNamedType("jl");
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