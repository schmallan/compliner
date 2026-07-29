float[] angle2vector(float angle, float magnitude){
    return new float[]{cos(angle)*magnitude,sin(angle)*magnitude};
}
float[] vector2angle(float x, float y){
    return new float[]{atan2(y,x),sqrt((x*x+y*y))};
}

//parametric equation (all variables either x or y, 0<t<1)
float cubicbezier(float t, float s1, float e1, float s2, float e2){
    float invt = 1-t;
    float res = 0;
    res += pow(invt,3)*s1;
    res += pow(invt,2)*e1*3*t;
    res += pow(invt,1)*e2*3*t*t;
    res += pow(invt,0)*s2*t*t*t;
    return res;
}

class spline{
    float[][] points;
    node node1;
    node node2;
    float offsetAngle;
    spline(node n1, node n2, float offa){
        points = new float[lineFidel+1][2];
        node1 = n1;
        node2 = n2;
        offsetAngle = offa;
        calculateSpline();
    }

    void calculateSpline(){
        float[] ray1 = angle2vector(node1.angle+offsetAngle,node1.controlDist);
        float[] ray2 = angle2vector(node2.angle-PI,node2.controlDist);

        for (int i = 0; i<=lineFidel; i++){
            float t = (float)i/lineFidel;
            points[i][0] = cubicbezier(t,node1.posX,node1.posX+ray1[0],node2.posX,node2.posX+ray2[0]);
            points[i][1] = cubicbezier(t,node1.posY,node1.posY+ray1[1],node2.posY,node2.posY+ray2[1]);
            
        }
        points[lineFidel] = new float[]{node2.posX,node2.posY};
    }

    void renderSpline(int dotted){
        
        for (int i = 0; i<lineFidel; i++){
            if (i%dotted==0) line(points[i][0],points[i][1],points[i+1][0],points[i+1][1]);
            
        }
        int i=lineFidel/2;
                float ang = atan2(points[i+1][1]-points[i][1],points[i+1][0]-points[i][0]);
                noStroke();
                fill(0);
                renderShape(shapeArrow,points[i+1][0],points[i+1][1],0.15,ang);
                stroke(0);
            
    }
}