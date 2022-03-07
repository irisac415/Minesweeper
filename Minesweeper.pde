import de.bezier.guido.*;
private static final int NUM_ROWS = 20;
private static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
   
    // make the manager
    Interactive.make( this );
   
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r ++){
      for(int c = 0; c < NUM_COLS; c ++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    for(int i = 0; i < 30; i ++)
      setMines();
}
public void setMines()
{
    int RowR = (int)(Math.random()*NUM_ROWS);
    int ColR = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[RowR][ColR])){
      mines.add(buttons[RowR][ColR]);
    }
}

public void draw ()
{
    background(0);
    if(isWon() == true)
      displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    boolean won = true;
    for(int i = 0; i < buttons.length; i ++){
      for(int j = 0; j < buttons[i].length; j ++){
        if(!mines.contains(buttons[i][j]) && buttons[i][j].clicked == false)
          won = false;
      }
    }
    return won;
}
public void displayLosingMessage()
{
    //System.out.println("you lose");
    fill(200,100,100);
    buttons[NUM_ROWS-2][NUM_COLS-1].setLabel("U");
    buttons[NUM_ROWS-2][NUM_COLS-2].setLabel("O");
    buttons[NUM_ROWS-2][NUM_COLS-3].setLabel("Y");
    buttons[NUM_ROWS-1][NUM_COLS-4].setLabel("L");
    buttons[NUM_ROWS-1][NUM_COLS-3].setLabel("O");
    buttons[NUM_ROWS-1][NUM_COLS-2].setLabel("S");
    buttons[NUM_ROWS-1][NUM_COLS-1].setLabel("E");
    //text("haha I win boohoo",200,200);
}
public void displayWinningMessage()
{
    //your code here
    //System.out.println("YOU WIN");
    fill(100,200,100);
    buttons[0][0].setLabel("Y");
    buttons[0][1].setLabel("O");
    buttons[0][2].setLabel("U");
    buttons[1][0].setLabel("W");
    buttons[1][1].setLabel("I");
    buttons[1][2].setLabel("N");
}
public boolean isValid(int r, int c)
{
   if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
     return true;
   return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
      numMines++;
    if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
      numMines++;
    if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
      numMines++;
    if(isValid(row,col-1) && mines.contains(buttons[row][col-1]))
      numMines++;
    if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
      numMines++;
    if(isValid(row+1,col) && mines.contains(buttons[row+1][col]))
      numMines++;
    if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
      numMines++;
    if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
      numMines++;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed ()
    {
        clicked = true;
        if(mouseButton == RIGHT){
          flagged = !flagged;
          if(flagged == false)
            clicked = false;
        }
        else if(mines.contains(this)){
          displayLosingMessage();
        }
        else if(countMines(myRow,myCol) >0)
          myLabel = countMines(myRow,myCol) + "";
        else{
          for(int i = myRow-1; i <=myRow+1; i ++)
            for(int j = myCol-1; j <= myCol + 1; j ++)
              if(isValid(i,j) && !buttons[i][j].isClicked())
                buttons[i][j].mousePressed();
            //your code here
        }
    }
    public void draw ()
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) )
            fill(200,140,245);
        else if(clicked)
            fill( 220 );
        else
            fill( 150 );

        rect(x, y, width, height);
        fill(0,0,255);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked()
    {
      return clicked;
    }
}
