class node{
    int posX;
    int posY;
    float angle;
    int size = 15;
    float controlDist = 50;

    String nfamily;
    
    nodeType ntype;

    node primaryBack;
    ArrayList<node> backNodes;
    
    node mainConnection;
    node sideConnection;
    
    spline mainSpline;
    spline sideSpline;

    boolean valid = false;

    node(int x, int y, float a, nodeType n){
        backNodes = new ArrayList<node>();
        posX = x;
        posY = y;
        angle = a;
        morph(n);
    }
    void verify(){
        valid = true;
        int numConnections = 0;
        numConnections += (mainConnection!=null) ? 1 : 0;
        numConnections += (sideConnection!=null) ? 1 : 0;
        if (numConnections!=ntype.branch) valid = false;
        if (primaryBack==null) valid = false;
    }

    void morph(nodeType newt){
        ntype = newt;
        nfamily = newt.family;
        if (ntype.branch<2){
            sideConnection=null;
            sideSpline=null;
        }
        //if (ntype.branch<1){
          //  mainConnection=null;
          //  mainSpline=null;
        //}
    }
    void render(int ncolor, boolean select){
        fill(ncolor);
        if (!valid) fill(255,0,0);
        noStroke();
        //fill(100);
        //ellipse(posX,posY,size*2,size*2);
        renderShape(ntype.shape,posX,posY,0.2,angle);
        float[] ray = angle2vector(angle,controlDist);
        stroke(0,0,255);
        if (select) line(posX,posY,posX+(int)ray[0],posY+(int)ray[1]);
        
        strokeWeight(5);
        stroke(0);
        if (mainConnection!=null){
            int dot = 3; 
            if (mainConnection.primaryBack==this) dot = 1;
            mainSpline.renderSpline(dot);
        }
        if (sideConnection!=null) sideSpline.renderSpline(3);

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
        if (con.primaryBack==null){
            con.primaryBack = this;
        } else {
            con.backNodes.add(this);
        }

        if (mainConnection==null || ntype.branch<2){
            mainConnection = con; 
            mainSpline = new spline(this,con,0);
            updSpline();
        } else if (ntype.branch==2){
            sideConnection = con; 
            sideSpline = new spline(this,con,0);
            updSpline();
        }
        
        verify();

    }
    void removeConnection(node con){
        if (con==null) return;
        if (con.primaryBack==this){
            if (con.backNodes.size()==0){
                con.primaryBack=null;
            } else {
                con.primaryBack=con.backNodes.get(0);
                con.backNodes.remove(0);
            }
        } else {
            con.backNodes.remove(this);
        }
        if (sideConnection==con){sideSpline = null; sideConnection = null;}
        if (mainConnection==con){mainSpline = null; mainConnection = null;}
        
        verify();
    }

    boolean check(int x, int y){
        int dx = (x-posX);
        int dy = (y-posY);
        return sqrt(dx*dx+dy*dy)<size;
    }
}