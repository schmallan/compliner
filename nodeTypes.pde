class nodeType{

    String name;
    String internalName;
    int branch;
    int[][][] shape;
    int argNum;
    String family;
    boolean isOperand;
    int ncolor;
    String defaultData;
    boolean isHead;
    nodeType(String n,  String i, String d, int b, int[][][] s, int a, String t, boolean o, boolean h, color c){
        name = n;
        internalName = i;
        branch = b;
        shape = s;
        defaultData = d;
        argNum = a;
        family = t;
        isOperand = o;
        ncolor = c;
        isHead = h;
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
        if (t.internalName.equals(name)) return t;
    }
    return null;
}

nodeType getNamedFamily(String name){
    for (nodeType t : nodeTypeList){
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
        "Byte Register","arg_reg_"+intRegs[i][0],intRegs[i][0],1,shapeByte,1,"byte",true,true,c
        ));
        nodeTypeList.add(new nodeType(
        "Word Register","arg_reg_"+intRegs[i][1],intRegs[i][1],1,shapeWord,1,"word",true,true,c
        ));
        nodeTypeList.add(new nodeType(
        "Double Register","arg_reg_"+intRegs[i][2],intRegs[i][2],1,shapeDouble,1,"double",true,true,c
        ));
        nodeTypeList.add(new nodeType(
        "Quad Register","arg_reg_"+intRegs[i][3],intRegs[i][3],1,shapeQuad,1,"quad",true,true,c
        ));

         nodeTypeList.add(new nodeType(
        "Deref. Byte Register","arg_reg_d_"+intRegs[i][0],"["+intRegs[i][0]+"]",1,shapeByteD,1,"byte_d",true,true,c
        ));
        nodeTypeList.add(new nodeType(
        "Deref. Word Register","arg_reg_d_"+intRegs[i][1],"["+intRegs[i][1]+"]",1,shapeWordD,1,"word_d",true,true,c
        ));
        nodeTypeList.add(new nodeType(
        "Deref. Double Register","arg_reg_d_"+intRegs[i][2],"["+intRegs[i][2]+"]",1,shapeDoubleD,1,"double_d",true,true,c
        ));
        nodeTypeList.add(new nodeType(
        "Deref. Quad Register","arg_reg_d_"+intRegs[i][3],"["+intRegs[i][3]+"]",1,shapeQuadD,1,"quad_d",true,true,c
        ));
        
       nodeTypeList.add(new nodeType(
         "tag","arg_tag_"+i,("tag"+i),1,shapeTag,1,"tag",true,true,c
        ));
            
        
    }
    
    colorMode(RGB,255,255,255);
    
        nodeTypeList.add(new nodeType(
            "Custom Text","arg_text","",1,shapeText,1,"arg",true,true,color(0,0,0)
        ));nodeTypeList.add(new nodeType(
            "Custom Number","arg_num","",1,shapeNum,1,"arg",true,true,color(0,0,0)
        ));

    nodeTypeList.add(new nodeType(
        "No Operation","instr_nop","nop",1,shapeNop,0,"control",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Move","instr_mov","mov",1,shapeMov,2,"control",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Label Definition","prepr_label_def","label",1,shapeLabel,1,"control",false,true,color(0,0,0) 
    )); nodeTypeList.add(new nodeType(
        "Return","instr_ret","ret",0,shapeRet,0,"control",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Call Function","instr_call","call",1,shapeCall,1,"control",false,false,color(0,0,0) 
    )); nodeTypeList.add(new nodeType(
        "Stack Pop","instr_pop","pop",1,shapePop,1,"control",false,false,color(0,0,0) 
    )); nodeTypeList.add(new nodeType(
        "Stack Push","instr_push","push",1,shapePush,1,"control",false,false,color(0,0,0) 
    
    
    )); nodeTypeList.add(new nodeType(
        "Import Function","prepr_extern","extern",0,shapeExtern,1,"preprocessor",false,true,color(0,0,0)   
    )); nodeTypeList.add(new nodeType(
        "Export Function","prepr_global","global",0,shapeGlobal,1,"preprocessor",false,true,color(0,0,0)   
    
    )); nodeTypeList.add(new nodeType(
        "Define Byte(s)","prepr_db","db",0,shapeDb,2,"preprocessor",false,true,color(0,0,0)   
    )); nodeTypeList.add(new nodeType(
        "Define Word(s)","prepr_dw","dw",0,shapeDw,2,"preprocessor",false,true,color(0,0,0)   
    )); nodeTypeList.add(new nodeType(
        "Define Double(s)","prepr_dd","dd",0,shapeDd,2,"preprocessor",false,true,color(0,0,0)   
    )); nodeTypeList.add(new nodeType(
        "Define Quad(s)","prepr_dq","dq",0,shapeDq,2,"preprocessor",false,true,color(0,0,0)   

    )); nodeTypeList.add(new nodeType( 
        "Jump if <0","instr_jl","jl",2,shapeJl,2,"jump",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Jump if =0","instr_jz","jz",2,shapeJz,2,"jump",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Jump if <=0","instr_jng","jng",2,shapeJng,2,"jump",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Jump if >0","instr_jg","jg",2,shapeJg,2,"jump",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Jump if !0","instr_jnz","jnz",2,shapeJnz,2,"jump",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Jump if >=0","instr_jnl","jnl",2,shapeJnl,2,"jump",false,false,color(0,0,0)

    )); nodeTypeList.add(new nodeType(
        "Increment","instr_inc","inc",1,shapeInc,1,"arithmetic",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Add","instr_add","add",1,shapeAdd,2,"arithmetic",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Multiply","instr_mul","mul",1,shapeMul,2,"arithmetic",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Decrement","instr_dec","dec",1,shapeDec,1,"arithmetic",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Subtract","instr_sub","sub",1,shapeSub,2,"arithmetic",false,false,color(0,0,0)
    )); nodeTypeList.add(new nodeType(
        "Divide","instr_div","div",1,shapeDiv,1,"arithmetic",false,false,color(0,0,0)
    ));
    
}