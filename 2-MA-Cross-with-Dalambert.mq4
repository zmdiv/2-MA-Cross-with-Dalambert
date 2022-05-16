input int Short_MA_Points = 50;
input int Long_MA_Points = 200;

input double volbet = 0.1;

input int intStopLoss = 25;
input int intTakeProfit = 25;

double StopLoss = intStopLoss * 0.0001;
double TakeProfit = intTakeProfit * 0.0001;

int counter = 1;
double LastProfit;





void OnInit ()

{

double Short_MA = iMA(_Symbol,0,Short_MA_Points,0,MODE_SMA,PRICE_OPEN,0);
double Long_MA = iMA(_Symbol,0,Long_MA_Points,0,MODE_SMA,PRICE_OPEN,0);


if (Short_MA > Long_MA  && Bid < Short_MA && Bid > Long_MA && OrdersTotal() < 1)

   {
    OrderSend(_Symbol,OP_SELL,volbet,Bid,3,Bid + StopLoss,Bid - TakeProfit);
   }


else if (Short_MA < Long_MA  && Ask > Short_MA && Ask < Long_MA && OrdersTotal() < 1)

   {
    OrderSend(_Symbol,OP_BUY,volbet,Ask,3,Ask - StopLoss,Ask + TakeProfit);
   }


}


 
void OnTick()

{


double Short_MA = iMA(_Symbol,0,Short_MA_Points,0,MODE_SMA,PRICE_OPEN,0);
double Long_MA = iMA(_Symbol,0,Long_MA_Points,0,MODE_SMA,PRICE_OPEN,0);


for (int j=OrdersHistoryTotal()-1; j >=0; j--)

   {
   OrderSelect(j,SELECT_BY_POS,MODE_HISTORY);
   
   if(OrderSymbol() == _Symbol)
   
     if (j == OrdersHistoryTotal()-1)
     
        {
         LastProfit = OrderProfit();
         
 }
 }
         
         
         
         
 // SELLS        

if (LastProfit < 0 && Short_MA > Long_MA  && Bid < Short_MA && Bid > Long_MA && OrdersTotal() < 1)

   {
    counter += 1;
    OrderSend(_Symbol,OP_SELL,volbet*counter,Bid,3,Bid + StopLoss,Bid - TakeProfit);
   }


else if (LastProfit > 0 && counter == 1 && LastProfit < 0 && Short_MA > Long_MA  && Bid < Short_MA && Bid > Long_MA && OrdersTotal() < 1)

   {
    OrderSend(_Symbol,OP_SELL,volbet*counter,Bid,3,Bid + StopLoss,Bid - TakeProfit);
   }


else if (LastProfit > 0 && counter > 1 && Short_MA > Long_MA  && Bid < Short_MA && Bid > Long_MA && OrdersTotal() < 1)

   {
    counter -= 1;
    OrderSend(_Symbol,OP_SELL,volbet*counter,Bid,3,Bid + StopLoss,Bid - TakeProfit);
   }



// BUYS 



else if (LastProfit < 0 && Short_MA < Long_MA  && Ask > Short_MA && Ask < Long_MA && OrdersTotal() < 1)

   {
    counter += 1;
   OrderSend(_Symbol,OP_BUY,volbet*counter,Ask,3,Ask - StopLoss,Ask + TakeProfit);
   }


else if (LastProfit > 0 && counter == 1 && Short_MA < Long_MA  && Ask > Short_MA && Ask < Long_MA && OrdersTotal() < 1)

   {
   OrderSend(_Symbol,OP_BUY,volbet*counter,Ask,3,Ask - StopLoss,Ask + TakeProfit);
   }


else if (LastProfit > 0 && counter > 1 && Short_MA < Long_MA  && Ask > Short_MA && Ask < Long_MA && OrdersTotal() < 1)

   {
    counter -= 1;
    OrderSend(_Symbol,OP_BUY,volbet*counter,Ask,3,Ask - StopLoss,Ask + TakeProfit);
   }



}
