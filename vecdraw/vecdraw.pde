
import java.util.ArrayList; 

int scale = 2;
ArrayList<int[]> points = new ArrayList<int[]>();
ArrayList<int[]> backpoints = new ArrayList<int[]>();


int hl = 300;
void setup(){
    windowResize(600,600);
}

int snapv = 10*scale;
int snap(int n){
    return (int)(n/snapv)*snapv;
}

boolean mh = false;
void mousePressed(){
    mh=true;
}
void mouseReleased(){
    mh=false;
    points.add(new int[]{snap(mouseX),snap(mouseY)});
}

void draw(){
    background(255);
    noStroke();
    fill(200);
    ellipse(hl,hl,200*scale,200*scale);
    stroke(0);
    strokeWeight(2);
    line(hl,0,hl,2*hl);
    line(0,hl,2*hl,hl);

    noStroke();
    fill(100);
    beginShape();
    for (int[] p : backpoints){
        fill(255,255,0);
        ellipse(p[0],p[1],10,10);

        vertex(p[0],p[1]);
    }
    fill(100);
    endShape();
    fill(0);
    
    beginShape();
    for (int[] p : points){
        ellipse(p[0],p[1],10,10);
        vertex(p[0],p[1]);
    }
    endShape();

    if (mh){
        fill(255,0,0);
        ellipse(snap(mouseX),snap(mouseY),10,10);
    }
}

void keyPressed(){
    if (keyCode==BACKSPACE){
        points.remove(points.size()-1);
    }
    if (key=='a'){
        float s = 200;
        for (float i = PI/8; i<=(2*PI)+0.5; i+=(PI/4)){
            points.add(new int[]{(int)(cos(i)*s)+hl,(int)(sin(i)*s)+hl});
        }
    }
    if (key=='s'){
        float s = 160;
        for (float i = 2*PI; i>=0-0.1; i-=(PI/10)){
            points.add(new int[]{(int)(cos(i)*s)+hl,(int)(sin(i)*s)+hl});
        }
    }
    if (key=='b'){
        for (int[] p : points){
            backpoints.add(p);
        }
        points.clear();

    }
    
    if (key=='m'){
        for (int[] p : points){
            p[0]=-(p[0]-hl)+hl;
        }
    }
    
    if (key=='n'){
        for (int[] p : points){
            p[1]=-(p[1]-hl)+hl;
        }
    }

    for (int[] p : points){
        int x = (p[0]-hl)/scale;
        int y = (p[1]-hl)/scale;
        
        print("{"+x+","+y+"},");
    }
}