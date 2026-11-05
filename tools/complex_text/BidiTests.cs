using System;
using ForestComplexText;
static class BidiTests {
 static string Reverse(string s){var c=s.ToCharArray();Array.Reverse(c);return new string(c);}
 static void Test(string input,string expected){string actual=Reverse(BidiOrder.ForTmp(input,1));if(actual!=expected)throw new Exception("Bidi mismatch: "+actual+" != "+expected);}
 static void Main(){
  Test("\uE000\uE001 12/34 — TFoL.info","TFoL.info — 12/34 \uE001\uE000");
  Test("\uE000\uE001 Southern Comfort","Southern Comfort \uE001\uE000");
  Test("\uE000\uE001 ١٢٣ \uE002456","456\uE002 ١٢٣ \uE001\uE000");
  Test("\uE000 2026-11-05","2026-11-05 \uE000");
  Test("\uE000 (123)","(123) \uE000");
  Test("(\uE000: 11/11)","(11/11 :\uE000)");
  string rich=BidiOrder.ForTmp("<color=#88FFAA>\uE000\uE001</color> <i>Latin</i>",1);
  if(rich!="<color=#88FFAA>\uE000\uE001</color> <i>nitaL</i>")throw new Exception("Rich tag styles changed: "+rich);
  if(BidiOrder.ForTmp("<i>\uE000",1)!="<i>\uE000</i>")throw new Exception("Original open-ended style rejected");
  if(BidiOrder.ForTmp("\uE000</i>",1)!="\uE000")throw new Exception("Original unmatched close changed visible text");
  if(BidiOrder.ForTmp("<color=red><i>\uE000</color>\uE001</i>",1)!="<color=red><i>\uE000</i></color><i>\uE001</i>")throw new Exception("Crossing styles lost");
  if(BidiOrder.ForTmp("<b>\uE000</b>",1)!="<b>\uE000</b>")throw new Exception("Bold tag changed");
  if(BidiOrder.ForTmp("<u>\uE000</u>",1)!="<u>\uE000</u>")throw new Exception("Underline tag changed");
  if(BidiOrder.ForTmp("<noparse></noparse>\uE000",1)!="\uE000")throw new Exception("Empty engine noparse wrapper exposed");
  Console.WriteLine("13 bidi regressions passed");
 }
}
