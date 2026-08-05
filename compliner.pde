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
    
    //graphLoad();
}

node selectedNode = null;
int frameSinceClick = 0;
void mousePressed(){
    if (key(CONTROL)){
        node n = selectNode();
        if (selectedNode!=null & n!=selectedNode){
            if (n!=selectedNode){
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
        } else {
            selectedNode = selectNode();
            if (selectedNode==null) return;
            node newn = new node(0,0,0,getNamedType(selectedNode.ntype.internalName));
            nodes.add(newn);
            newn.data = selectedNode.data;
            selectedNode = newn;
            rx = 50;
            ry = 50;
                    return;
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
int wm = 0;
int fc = 0;
String warningmsg = "";
int autosaveinterval = 30*60;
void draw(){
    if (wm>0) wm--;
    if (wm==0) warningmsg = "";

    fc++;
    if (fc>autosaveinterval){
        fc = 0;
        wm = 300;
        warningmsg = "Graph autosaved.";
        gsave(savepath+"autosave-"+filepath);
    }

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

    textSize(30);
    fill(color(255,255-wm,255-wm));
    text(warningmsg,350,100);
    fill(0);
    textSize(20);
    if (selectedNode!=null){
        text(selectedNode.ntype.name+"\n"+selectedNode.data+((isEnteringText)?"<":""),50,50);
    }
    text(
        "Editing file: "+filepath+((selectedNode==null&isEnteringText)?"<":"")+"\n"+
        "[lmb] select\n"+
        "[drag] move\n"+
        "[rmb] adjust\n"+
        "[enter] edit text\n"+
        "[backspace] delete\n"+
        "[tab] switch type\n"+
        "[ctrl][lmb] connect/disconnect\n"+
        "[ctrl][drag] duplicate\n"+
        "[delete] clear all\n"+
        
        "[S]ave\n"+
        "[L]oad\n"+
        "[A]rithmetic\n"+
        "[B]ranch\n"+
        "[C]ontrol\n"+
        "[T]ag\n"+
        "[E]ditable\n"+
        "[P]reprocessor\n"+
        "[ctrl][register] Deref. registers\n"+
        "[1234] Int registers\n"
        ,50,100);
    
    if (isEnteringText){
        textSize(50);
        text("ENTERING TEXT",200,200);
    }
}

