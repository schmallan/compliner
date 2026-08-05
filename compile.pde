//compiler steps

//1. find all "head" nodes
//all head nodes either have no primaryBack or are the sideconnection of their primaryBack.
//operands are not head nodes.
//start with a list of all nodes
//pick arbitrary node, then keep going back until you find a head node
//record head node, then keep going forward through mainconnection and remove all nodes traversed this way.
//repeat steps until list of all nodes is empty.

//2. label generation
//labels are created in the object
//all head nodes are labeled
//all nodes with any backNodes are labeled

//3. preprocessor
//all preprocessor nodes are head nodes
//generate preprocessor directives

//4. code generation
//loop through every head node
//generate instruction using arguments for node, go to mainconnection
//if mainconnection primary back is not node, write jump command to label and move next head node
//if node has no mainconnection (ret) move to next node