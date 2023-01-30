//+------------------------------------------------------------------+
//|                                                 FluxDemberTI.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//26-nov-2022
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
  int Found = 1;
    int Found2 = 1;
 double newvalue=0;
  
  double SwingValue[2000];

  
 double Store[2000];
   datetime StoreTime[2000];
     int StoreCandle[2000];
     
  double a=0,b=0;
  double aa=0,bb=0;
int OnInit()
  {
//---
   ChartSetInteger(0,CHART_SHOW_GRID,false);
ChartSetInteger(0,CHART_COLOR_CANDLE_BEAR,Red);
ChartSetInteger(0,CHART_COLOR_CANDLE_BULL,Lime);
ChartSetInteger(0,CHART_COLOR_CHART_DOWN,Red);
ChartSetInteger(0,CHART_COLOR_CHART_UP,Lime);
ChartSetInteger(0,CHART_MODE, CHART_CANDLES);
ChartSetInteger(0,CHART_COLOR_BACKGROUND, Black);
              
   

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
 
 
   //  drawrectangle(posVelaStart,High[HighestCandle],posVelaEnd,Low[LowestCandle]  ,"b"+Found2);
     //************************************************************************
     //**********************************************************************
     
        
       for (int k=2;k<10;k++){
         if (existPicoUpMed(k,k+1,k+2)){
            Found++;
           double posVelaStart= k;
           
           //Find the highest ofthe last 30 candles
           int HighestCandle=  iHighest(_Symbol,PERIOD_H4,MODE_HIGH,4,posVelaStart);
           
           drawVerticalLine2(k+1,"a"+Found);
       
          
         }
          
         
      }
           
              
   }
  
  
 /*
    LecturaPrecio(Found,350,90,"p5D",  StringConcatenate("found: ")); 
     for(int k = 10; k < 50; k++){   // Get most recent ZigZag
    
      //Detectar cuando el valor es diferente a 0 en las ultimas N velas
      if(iCustom(NULL, PERIOD_H4, "ZigZag", 12, 5, 3, 0, k)!=0){
           Found++;
           double zigzagg =iCustom(NULL, 0, "ZigZag", 12, 5, 3, 0, k);
           
          SwingValue[Found]  =zigzagg; //CAPTURAMOS VALOR PICO DEL ZIG ZAG
       
          
          a= SwingValue[Found] ;//Ultimo dato
           b=  SwingValue[Found-1] ;//Penultimo dato
           
           //Solo si es diferente al dato anterior almacenar en STORE (Array Final)
             if (a!=b){
             Found2++;
             Store[Found2] = zigzagg;
             StoreTime[Found2]= Time[k]; //CAPTURAMOS LA FECHA
             
             DrawPriceTrendLine(StoreTime[Found2],StoreTime[Found2-1], 
                                 Store[Found2], 
                                Store[Found2-1], Green, STYLE_SOLID);   
           
           
             }
             aa =Store[Found2]; //Ultimo dato
             bb= Store[Found2-1]; //Penultimo dato
              
              
               
           //Dibujar Vertical
           //Apenas detecta un valor diferente a 0 Entonces Almacenar en Array temporal
           drawVerticalLine2(k,"a"+Found2);
           
           //********************************************************************
           //Dibujar rectangulo****************************************************
           //*********************************************************************
           double posVelaStart= k-2;
           double posVelaEnd= k+2;
           
           //Find the highest ofthe last 30 candles
           int HighestCandle=  iHighest(_Symbol,_Period,MODE_HIGH,4,posVelaStart);
           // Find the lowest of the last 30 candles
           int LowestCandle = iLowest(_Symbol,_Period,MODE_LOW,4,posVelaStart);
 
           drawrectangle(posVelaStart,High[HighestCandle],posVelaEnd,Low[LowestCandle]  ,"b"+Found2);
           //************************************************************************
           //**********************************************************************
          
           
             //Romper busqueda FOR si detecto valor PICO
             newvalue= zigzagg;
             if (newvalue!=0)   break; 
         }     
     }
     
      
     
     */
   
  
//+------------------------------------------------------------------+


bool isAlcista(int v) {

   bool up=false;
   double closex= iClose("NZDUSD",PERIOD_H4,v);
   double openx= iClose("NZDUSD",PERIOD_H4,v);
   if (closex>openx==true){
      up=true;
   }   
   return up;
}
bool isBajista(int v) {
   double closex= iClose("NZDUSD",PERIOD_H4,v);
   double openx= iClose("NZDUSD",PERIOD_H4,v);
   bool down=false;
   if (closex<openx==true){
      down=true;
   }   
   return down;
}

 

bool existPicoUp(int v1, int v2, int v3){
   bool existe=false;
   if ((ema(v2)>ema(v1))&& (ema(v2)>ema(v3))){ 
         existe = true; 
   }
   return existe;
}
bool existPicoUpMed(int v1, int v2, int v3){
   bool existe=false;
   if ((emaMed(v2)>emaMed(v1))&& (emaMed(v2)>emaMed(v3))){ 
         existe = true; 
   }
   return existe;
}
bool existPicoDownMed(int v1, int v2, int v3){
   bool existe=false;
   if ((emaMed(v2)<emaMed(v1))&& (emaMed(v2)<emaMed(v3))){ 
         existe = true; 
   }
   return existe;
}
    


void drawVerticalLine2(int barsBack, string name) {
   
   string lineName = "Line"+name;
  ObjectDelete(lineName);
      ObjectCreate(lineName,OBJ_VLINE,0,Time[barsBack],0);
      ObjectSet(lineName,OBJPROP_COLOR, clrRed);
      ObjectSet(lineName,OBJPROP_WIDTH,1);
      ObjectSet(lineName,OBJPROP_STYLE,STYLE_DOT);
    
}

void drawVerticalLine(int barsBack, string name) {
   
   string lineName = "Line"+name;
  ObjectDelete(lineName);
      ObjectCreate(lineName,OBJ_VLINE,0,Time[barsBack],0);
      ObjectSet(lineName,OBJPROP_COLOR, clrGreen);
      ObjectSet(lineName,OBJPROP_WIDTH,1);
      ObjectSet(lineName,OBJPROP_STYLE,STYLE_DOT);
    
}

double ema(int i){
   double ema; 
   ema =  iMA(NULL,PERIOD_H4 ,3,0,MODE_EMA,PRICE_WEIGHTED,i);
   return ema;
}
double emaMed(int i){
   double ema; 
   ema =  iMA(NULL,PERIOD_H4 ,1,0,MODE_EMA,PRICE_MEDIAN,i);
   return ema;
}
void drawrectangle(int posVelaStart,double pricestart, int postVelaEnd, double pricend,string name){
  string lineName = "Rectangle"+name;
   ObjectDelete(lineName); 
  ObjectCreate(lineName,OBJ_RECTANGLE,0,Time[posVelaStart],pricestart,Time[postVelaEnd],pricend);

}
void LecturaPrecio(double precio_sto,int cx, int cy, string name,string name2){

   ObjectCreate(name,OBJ_LABEL,0,0,0);
   ObjectSet(name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   ObjectSet(name,OBJPROP_XDISTANCE,cx);
   ObjectSet(name,OBJPROP_YDISTANCE,cy);
   ObjectSetText(name,name2 +DoubleToStr(precio_sto,5),10,"Arial",Yellow);

}

void DrawPriceTrendLine(datetime x1, datetime x2, double y1, 
                        double y2, color lineColor, double style)
  {
   string label = "Stochastic_DivergenceLine_v1.0# " + DoubleToStr(x1, 0);
   ObjectDelete(label);
   ObjectCreate(label, OBJ_TREND, 0, x1, y1, x2, y2, 0, 0);
   ObjectSet(label, OBJPROP_RAY, 0);
   ObjectSet(label, OBJPROP_COLOR, lineColor);
   ObjectSet(label, OBJPROP_STYLE,  style);
    ObjectSet(label, OBJPROP_WIDTH,  4);
  }  