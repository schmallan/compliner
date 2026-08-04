import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList; 
import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

int lineFidel = 25;

ArrayList<node> nodes = new ArrayList<node>();
void setup(){
   // windowResize(500,500);
    initNodeTypes();
    fullScreen();
}

node selectedNode = null;
int frameSinceClick = 0;
void mousePressed(){
    if (key(CONTROL)){
        if (selectedNode!=null){
            node n = selectNode();
            if (n!=null){
                if (selectedNode.mainConnection==n || selectedNode.sideConnection==n){
                    selectedNode.removeConnection(n);
                } else {
                    selectedNode.addConnection(n);
                }
                selectedNode=null;
                return;
            }
        }
    }

    if (mouseButton==LEFT) {selectedNode = selectNode(); }
    if (frameSinceClick<=10){
        if (selectedNode==null){
            node n = new node(mouseX,mouseY,0,nodeTypeList.get(0));
            nodes.add(n);
            selectedNode=n;

        }
    }
    frameSinceClick = 0;
}

node selectNode(){
    for (node n:nodes){
        if (n.check(mouseX,mouseY)){
            rx = n.posX-mouseX;
            ry = n.posY-mouseY;
            return n;
        }
    }
    return null;
}
int rx = 0;
int ry = 0;
void draw(){
    frameSinceClick++;
    background(255);
    for (node n:nodes){
        
        n.render(selectedNode==n);
    }
    if (mousePressed&mouseButton==LEFT&selectedNode!=null){
        selectedNode.posX = mouseX+rx;
        selectedNode.posY = mouseY+ry;
        
        selectedNode.updSpline();

    }
    if (mousePressed&mouseButton==RIGHT&selectedNode!=null){
        float dx = mouseX-selectedNode.posX;
        float dy = mouseY-selectedNode.posY;
        selectedNode.angle = vector2angle(dx,dy)[0];
        selectedNode.controlDist = sqrt(dx*dx+dy*dy);
        
        selectedNode.updSpline();
    }

    fill(0);
    textSize(20);
    if (selectedNode!=null){
        text(selectedNode.ntype.name+"\n"+selectedNode.data+((isEnteringText)?"<":""),50,50);
    }
    text(
        "[A]rithmetic\n"+
        "[B]ranch\n"+
        "[C]ontrol\n"+
        "[T]ag\n"+
        "[S]tring\n"
        ,50,100);
    if (isEnteringText){
        textSize(50);
        text("ENTERING TEXT",200,100);
    }

}

