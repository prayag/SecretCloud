  import processing.video.*;

Capture myCapture;
PFont font;
int y=0;
int numberOfRainLines = 0;
int size_x=1024;
int size_y=780;
PImage edgeImg;

Random seed;
//String[] Secrets = new String[1000];
//int noOfSecrets = 0;
Rain[] raindrops = new Rain[100000];
int numOfDrops = 0;
class Rain {
  
    int x = seed.nextInt(size_x);
    int y = 0;
    String rainDrop;
    Boolean shouldMove = true;
    
    Rain(String txt)
    {
      this.rainDrop = txt;
      println("Constructor Called");
    }
    
    void fall() {
    
     if(edgeImg.pixels[(int)y*myCapture.width+(int)x] < -14000000)
     {
         shouldMove = false;
     }
     else if(edgeImg.pixels[(int)y*myCapture.width+(int)x] > -10000000)
     {
       shouldMove = true;
     }
         
     if(shouldMove)
     {
       if(y+7<height)
         y = y + 7; 
     }
     
     fill(233,235,235);
     text(rainDrop,x,y);
   }

}

void setup() 
{
  size(size_x, size_y);
  font = loadFont("SegoeScript-Bold-48.vlw");
  /*String[] x = loadStrings("C:\\Users\\prayag\\Dropbox\\Secret_cloud\\text.txt");
  String[] y;
  for(int i =0; i<x.length;i++)
  {
       y = x[i].split(" ");
       for(int j=0;j<y.length;j++)
         {
           Secrets[noOfSecrets++] = y[j];
           //println(noOfSecrets + " " + Secrets[noOfSecrets]);
         }
  } */     
  // The name of the capture device is dependent those
  // plugged into the computer. To get a list of the 
  // choices, uncomment the following line 
  // println(Capture.list());
  // And to specify the camera, replace "Camera Name" 
  // in the next line with one from Capture.list()
  // myCapture = new Capture(this, width, height, "Camera Name", 30);
  
  // This code will try to use the last device used
  // by a QuickTime program
  myCapture = new Capture(this, width, height, 30);
  seed = new Random();
//
//  for(int i=0;i<numOfDrops;i++)
//      raindrops[i] = new Rain(Secrets[seed.nextInt(noOfSecrets)]);
}

void captureEvent(Capture myCapture) {
  myCapture.read();

}

void draw() {
      float[][] kernel = { { -1, -1, -1 },
                         { -1,  9, -1 },
                         { -1, -1, -1 } };
      
    //size(200, 200);
    //PImage img = loadImage(myCapture); // Load the original image
    image(myCapture, 0, 0); // Displays the image from point (0,0) 
    myCapture.loadPixels();
//    // Create an opaque image of the same size as the original
    edgeImg = createImage(myCapture.width, myCapture.height, RGB);
    PImage oldImg = edgeImg;
    // Loop through every pixel in the image.
    for (int y = 1; y < myCapture.height-1; y++) { // Skip top and bottom edges
      for (int x = 1; x < myCapture.width-1; x++) { // Skip left and right edges
        float sum = 0; // Kernel sum for this pixel
        for (int ky = -1; ky <= 1; ky++) {
          for (int kx = -1; kx <= 1; kx++) { 
            // Calculate the adjacent pixel for this kernel point
            int pos = (y + ky)*myCapture.width + (x + kx);
            // Image is grayscale, red/green/blue are identical
            float val = red(myCapture.pixels[pos]);
            // Multiply adjacent pixels based on the kernel values
            sum += kernel[ky+1][kx+1] * val;
          } 
        }
        // For this pixel in the new image, set the gray value
        // based on the sum from the kernel
        edgeImg.pixels[y*myCapture.width + x] = color(sum);
        //if(edgeImg.pixels[(int)y*myCapture.width+(int)x] == -16777216)
          // text('x',x,y); 
        
    
      }
    }
    // State that there are changes to edgeImg.pixels[]
  // edgeImg.updatePixels();
   // image(edgeImg, 100, 0); // Draw the new image
    
//    for(int x=0;x<edgeImg.width-1;x++)
//      for(int y=0;y<edgeImg.height-1;y++)
//        {
//        //if(edgeImg.pixels[x+y*edgeImg.height] == color(black))
//          {
//            println(edgeImg.pixels[x+y*edgeImg.height]);
//          }
//        }
//    

ArrayList words = readSecretWords();

rainComesDown(words.size()/5);

}


void rainComesDown(int rainAmount)
{
     println(numOfDrops);
     if (random(10) < rainAmount) 
     {
           size(size_x, size_y);          
           if(numOfDrops >= raindrops.length)
           {
             
           }  
           
           ArrayList secrets = readSecretWords();
           if(!secrets.isEmpty())
           {
               raindrops[numOfDrops++] = new Rain((String)secrets.get(seed.nextInt(secrets.size()))); // Create each object
           }
     }
   
    for(int i=0;i<numOfDrops;i++)
      raindrops[i].fall();
}


ArrayList readSecretWords()
{
    int noOfSecrets = 0;
    ArrayList Secrets = new ArrayList();
    String[] x = loadStrings("C:\\Users\\prayag\\Dropbox\\Secret_cloud\\text.txt"); 
    String[] y;
    for(int i =0; i<x.length;i++)
    {
         y = x[i].split(" ");
         for(int j=0;j<y.length;j++)
           {
             Secrets.add(y[j]);
             //Secrets[noOfSecrets++] = y[j];
           }
    }   
    
    return Secrets;
}
