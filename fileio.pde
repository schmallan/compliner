void graphSave(){
    try{
        for (node n : nodes) n.serialPrep();

        FileOutputStream file = new FileOutputStream("myoutput.txt");
        ObjectOutputStream output = new ObjectOutputStream(file);
        node n1 = nodes.get(0);
        output.writeObject(n1);


        file.close();
    } catch (FileNotFoundException e){
        print(e);
    } catch (IOException e){
        print(e);
    }
}
void graphLoad(){

    for (node n : nodes) n.serialRestore();
}