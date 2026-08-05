void graphSave(){
    gsave(savepath+filepath);
    warningmsg = "Graph save successful.";
    wm = 300;
}

void gsave(String path){
    String[] tosave = new String[nodes.size()];
    for (int i = 0; i<nodes.size(); i++){
        tosave[i] = serializeNode(nodes.get(i));
    }
    saveStrings(path+".txt", tosave);
    
}

String[] saved = new String[]{};
String filepath = "";
String savepath = "saves/";

void graphLoad(){
    saved = loadStrings(savepath+filepath+".txt");
    if (saved==null){
        warningmsg = "Invalid file path!";
        wm = 300;
        return;
    }
    
    nodes = new ArrayList<node>();
    for (int i = 0; i<saved.length; i++){
        nodes.add(new node(0,0,0,getNamedFamily("jump")));
    }
    for (int i = 0; i<saved.length; i++){
        deserializeNode(saved[i],nodes.get(i));
    //    println(saved[i]);
    }
    for (int i = 0; i<saved.length; i++){
        node n = nodes.get(i);
        if (n.mainConnection!=null){
            n.mainSpline = new spline(n,n.mainConnection);
        }
        if (n.sideConnection!=null){
            n.sideSpline = new spline(n,n.sideConnection);
        }
    }
    for (node n : nodes){
        if (n.mainConnection!=null){
            if (n.mainConnection.primaryBack!=n) n.mainConnection.backNodes.add(n);
            if (n.ntype.isOperand) n.mainConnection.opcount++;
        }
        if (n.sideConnection!=null){
            if (n.sideConnection.primaryBack!=n) n.sideConnection.backNodes.add(n);
            if (n.ntype.isOperand) n.sideConnection.opcount++;
        }
    }
    for (node n : nodes){
        n.verify();
    }
    
    warningmsg = "Graph load successful.";
    wm = 300;
}
void deserializeNode(String s, node n){
    String[] fields = s.split(",");

    n.posX = Integer.parseInt(fields[1]);
    n.posY = Integer.parseInt(fields[2]);
//    println(n.posX+"/"+n.posY+":");
    n.angle = Float.parseFloat(fields[3]);
    n.ntype = (getNamedType(fields[4]));
    n.controlDist = Float.parseFloat(fields[5]);
    int mc = Integer.parseInt(fields[6]);
    if (mc!=-1) n.mainConnection = nodes.get(mc);
    int sc = Integer.parseInt(fields[7]);
    if (sc!=-1) n.sideConnection = nodes.get(sc);
    int ib = Integer.parseInt(fields[8]);
    if (ib!=-1) n.primaryBack = nodes.get(ib);
    n.data = fields[9];
    n.opindex = Integer.parseInt(fields[10]);

}
String serializeNode(node n){
    String s = "1px/2py/3angle/4intername/5controldist/6imain/7iside/8ipback/9data/10opindex,";
    s = "v1,";
    s+=n.posX+",";
    s+=n.posY+",";
    s+=n.angle+",";
    s+=n.ntype.internalName+",";
    s+=n.controlDist+",";
    s+=nodes.indexOf(n.mainConnection)+",";
    s+=nodes.indexOf(n.sideConnection)+",";
    s+=nodes.indexOf(n.primaryBack)+",";
    s+=n.data+",";
    s+=n.opindex+",";

    return s;
}