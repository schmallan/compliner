class node{
    int posX;
    int posY;
    float angle;
    int size = 25;
    float controlDist = 50;

    String nfamily;
    
    nodeType ntype;

    node primaryBack = null;
    ArrayList<node> backNodes;
    
    node mainConnection;
    node sideConnection;
    
    spline mainSpline;
    spline sideSpline;

    boolean valid = false;
    int opcount = 0;

    int opindex = 0;

    node(int x, int y, float a, nodeType n){
        backNodes = new ArrayList<node>();
        posX = x;
        posY = y;
        angle = a;
        ntype = n;
    }
    void verify(){
        valid = true;
        int numConnections = 0;
        numConnections += (mainConnection!=null) ? 1 : 0;
        numConnections += (sideConnection!=null) ? 1 : 0;
        if (numConnections!=ntype.branch) valid = false;
        if (primaryBack==null & !(ntype.name.equals("label")||ntype.isOperand)) valid = false;
        if (!ntype.isOperand & ntype.argNum!=opcount) valid = false;
    }

    void morph(nodeType newt){
        if (newt.isOperand!=this.ntype.isOperand){
            node n = new node(posX,posY,angle,newt);
            nodes.add(n);
            selectedNode = n;
            removeNode(this);
            return;
        };

        ntype = newt;
        nfamily = newt.family;
        if (ntype.branch<2){
            sideConnection=null;
            sideSpline=null;
        }
        updSpline();
        //if (ntype.branch<1){
          //  mainConnection=null;
          //  mainSpline=null;
        //}
        verify();
    }
    void render(boolean select){
        int c = -1;
        if (!valid) c = color(255,200,200);
        if (selectedNode!=null){
            if (equals(selectedNode)){ 
                c = color(200,200,255);
                if (key(CONTROL)) c = color(200,255,255);
            }
            
            if (selectedNode.primaryBack!=null & this==selectedNode.primaryBack) c = color(0,255,0);
            
        }
        if (c!=-1){
            noStroke();
            fill(c);
            ellipse(posX,posY,size*2,size*2);
        }

        c = ntype.ncolor;
        fill(c);
        //if (!valid) fill(255,0,0);
        noStroke();

        //fill(100);
        //ellipse(posX,posY,size*2,size*2);
        renderShape(ntype.shape,posX,posY,0.2,angle);
        float[] ray = angle2vector(angle,controlDist);
        stroke(0,0,255);
        if (select) line(posX,posY,posX+(int)ray[0],posY+(int)ray[1]);
        
        stroke(0);
        if (mainConnection!=null){
            int sw = 4;
//            if (mainConnection.primaryBack==this) sw = 2;
            if (ntype.isOperand) sw = 2;
            mainSpline.renderSpline(1,sw);
        }
        if (sideConnection!=null) sideSpline.renderSpline(3,4);

    }
    void cSpine(){
        if (mainSpline!=null){
            mainSpline.calculateSpline();
        }
        if (sideSpline!=null){
            sideSpline.calculateSpline();
        }
    }
    void updSpline(){
        cSpine();
        if (primaryBack!=null) primaryBack.cSpine();
        for (node n:backNodes) n.cSpine();
        
    }
    void addConnection(node con){
        if (con==this) return;
        if (con.ntype.isOperand) return;

        if (ntype.isOperand){
            opindex = con.opcount;
            con.opcount++;
        }

        if (con.primaryBack==null & !isLoop(con) & !ntype.isOperand){
            con.primaryBack = this;
        } else {
            con.backNodes.add(this);
        }

        if (mainConnection==null || ntype.branch<2){
            removeConnection(mainConnection);
            mainConnection = con; 
            mainSpline = new spline(this,con,0);
            updSpline();
        } else if (ntype.branch==2){
            removeConnection(sideConnection);
            sideConnection = con; 
            sideSpline = new spline(this,con,0);
            updSpline();
        }
        
        verify();
        con.verify();

    }
    void promote(){
        if (primaryBack!=null) return;
                for (int i = 0; i<backNodes.size(); i++){
                    node promote = backNodes.get(i);
                    if (!promote.isLoop(this) & !promote.ntype.isOperand){
                        primaryBack=promote;
                        backNodes.remove(promote);
                        break;
                    }
                }
        verify();
    }
    void removeConnection(node con){
        if (con==null) return;
        if (ntype.isOperand & con.backNodes.contains(this)){ 
            con.opcount--;
            for (node n : con.backNodes){
                if (n.ntype.isOperand & n.opindex>this.opindex){
                    n.opindex--;
                }
            }
        }

        if (con.primaryBack==this){
                con.primaryBack=null;
                con.promote();
        } else {
            con.backNodes.remove(this);
        }
        if (sideConnection==con){sideSpline = null; sideConnection = null;}
        if (mainConnection==con){mainSpline = null; mainConnection = null;}
        
        node back = this.primaryBack;
        while (back!=null){
            back.promote();
            back = back.primaryBack;
        }

        con.verify();
        verify();
    }
    boolean isLoop(node n){
        node back = this;
        while (back!=null){
            back = back.primaryBack;
            if (back==n) return true;
        }
        return false;
    }
    boolean check(int x, int y){
        int dx = (x-posX);
        int dy = (y-posY);
        return sqrt(dx*dx+dy*dy)<size;
    }
}
