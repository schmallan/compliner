class nodeType{
    String name;
    int branch;
    int[][][] shape;
    int argNum;
    String family;
    boolean isOperand;
    int ncolor;

    nodeType(String n, int b, int[][][] s, int a, String t, boolean o, color c){
        name = n;
        branch = b;
        shape = s;
        argNum = a;
        family = t;
        isOperand = o;
        ncolor = c;
    }
}

String[][] intRegs = new String[][]{
    {"al","ax","eax","rax","ah"},
    {"bl","bx","ebx","rbx","bh"},
    {"cl","cx","ecx","rcx","ch"},
    {"dl","dx","edx","rdx","dh"},
    
    {"sil","si","esi","rsi"},
    {"dil","di","edi","rdi"},
    {"spl","sp","esp","rsp"},
    {"bpl","bp","ebp","rbp"},

    {"r8b","r8w","r8d","r8"},
    {"r9b","r9w","r9d","r9"},
    {"r10b","r10w","r10d","r10"},
    {"r11b","r11w","r11d","r11"},
    {"r12b","r12w","r12d","r12"},
    {"r13b","r13w","r13d","r13"},
    {"r14b","r14w","r14d","r14"},
    {"r15b","r15w","r15d","r15"},
    
};

int[] regColors = new int[]{


#000000,
#643358,
#9c2e63,
#f378a3,

#c6cc54,
#609c4f,
#2c5e3b,
#f05b5b,

#ffe600,
#fabf61,
#e08d51,
#8a5865,
#56546e,
#5479b0,
#78c2d6,
#839fa6,
};

nodeType getNamedType(String name){
    for (nodeType t : nodeTypeList){
        print(t.name + ":" + name +"\n");
        if (t.name.equals(name)) return t;
    }
    return null;
}

nodeType getNamedFamily(String name){
    for (nodeType t : nodeTypeList){
        print(t.name + ":" + name +"\n");
        if (t.family.equals(name)) return t;
    }
    return null;
}

ArrayList<nodeType> nodeTypeList = new ArrayList<nodeType>();
void initNodeTypes(){

    colorMode(HSB,255,255,255);
    for (int i = 0; i<intRegs.length; i++){
        int c = regColors[i];
        nodeTypeList.add(new nodeType(
        intRegs[i][0],1,shapeByte,1,"byte",true,c
        ));
        nodeTypeList.add(new nodeType(
        intRegs[i][1],1,shapeWord,1,"word",true,c
        ));
        nodeTypeList.add(new nodeType(
        intRegs[i][2],1,shapeDouble,1,"double",true,c
        ));
        nodeTypeList.add(new nodeType(
        intRegs[i][3],1,shapeQuad,1,"quad",true,c
        ));
        nodeTypeList.add(new nodeType(
        ("tag"+i),1,shapeTagM,1,"tag",true,c
        ));
    }
    
    colorMode(RGB,255,255,255);
    
    nodeTypeList.add(new nodeType(
        "nop",1,shapeNop,0,"control",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "mov",1,shapeMov,2,"control",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "label",1,shapeLabel,1,"control",false,color(0,0,0) //special
    )); nodeTypeList.add(new nodeType(
        "ret",0,shapeRet,0,"control",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "call",1,shapeCall,1,"control",false,color(0,0,0)   //special
    
    )); nodeTypeList.add(new nodeType( 
        "jl",2,shapeJl,2,"jump",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "jz",2,shapeJz,2,"jump",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "jng",2,shapeJng,2,"jump",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "jg",2,shapeJg,2,"jump",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "jnz",2,shapeJnz,2,"jump",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "jnl",2,shapeJnl,2,"jump",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "jmp",2,shapeJmp,2,"jump",false,color(0,0,0)

    )); nodeTypeList.add(new nodeType(
        "inc",1,shapeInc,1,"arithmetic",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "add",1,shapeAdd,2,"arithmetic",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "mul",1,shapeMul,2,"arithmetic",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "dec",1,shapeDec,1,"arithmetic",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "sub",1,shapeSub,2,"arithmetic",false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "div",1,shapeDiv,1,"arithmetic",false,color(0,0,0)
    ));
    nodeTypeList.add(new nodeType(
        "string",1,shapeText,1,"arg",true,color(0,0,0)
    ));nodeTypeList.add(new nodeType(
        "number",1,shapeNum,1,"arg",true,color(0,0,0)
    ));
    
    
}