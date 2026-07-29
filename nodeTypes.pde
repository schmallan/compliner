class nodeType{
    String name;
    int branch;
    int[][][] shape;
    int argNum;
    String family;

    nodeType(String n, int b, int[][][] s, int a, String t){
        name = n;
        branch = b;
        shape = s;
        argNum = a;
        family = t;
    }
}

nodeType getNamedType(String name){
    for (nodeType t : nodeTypeList){
        if (t.name==name) return t;
    }
    return null;
}

ArrayList<nodeType> nodeTypeList = new ArrayList<nodeType>();
void initNodeTypes(){
    nodeTypeList.add(new nodeType(
        "nop",1,shapeNop,0,"control"
    )); nodeTypeList.add(new nodeType(
        "mov",1,shapeMov,2,"control"
    )); nodeTypeList.add(new nodeType(
        "label",1,shapeLabel,1,"control" //special
    )); nodeTypeList.add(new nodeType(
        "ret",0,shapeRet,0,"control"
    )); nodeTypeList.add(new nodeType(
        "call",1,shapeCall,1,"control"   //special
    
    )); nodeTypeList.add(new nodeType( 
        "jl",2,shapeJl,2,"jump"
    )); nodeTypeList.add(new nodeType(
        "jz",2,shapeJz,2,"jump"
    )); nodeTypeList.add(new nodeType(
        "jng",2,shapeJng,2,"jump"
    )); nodeTypeList.add(new nodeType(
        "jg",2,shapeJg,2,"jump"
    )); nodeTypeList.add(new nodeType(
        "jnz",2,shapeJnz,2,"jump"
    )); nodeTypeList.add(new nodeType(
        "jnl",2,shapeJnl,2,"jump"
    )); nodeTypeList.add(new nodeType(
        "jmp",2,shapeJmp,2,"jump"

    )); nodeTypeList.add(new nodeType(
        "inc",1,shapeInc,1,"arithmetic"
    )); nodeTypeList.add(new nodeType(
        "add",1,shapeAdd,2,"arithmetic"
    )); nodeTypeList.add(new nodeType(
        "mul",1,shapeMul,2,"arithmetic"
    )); nodeTypeList.add(new nodeType(
        "dec",1,shapeDec,1,"arithmetic"
    )); nodeTypeList.add(new nodeType(
        "sub",1,shapeSub,2,"arithmetic"
    )); nodeTypeList.add(new nodeType(
        "div",1,shapeDiv,1,"arithmetic"
    )); 
    
}