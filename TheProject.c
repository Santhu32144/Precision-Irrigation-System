int SetMoist=85;
int SetMoistR=0;
int SetMoistL=0;
int cset=0;
int sensingCounter=0;
int screenCounter=0;
int getMoist=0;
char *buffer = "00";
int turnON=1;

#define LCD_ON lcd_cmd(_LCD_TURN_ON);
#define LCD_OFF lcd_cmd(_LCD_TURN_OFF);

//LCD
sbit LCD_RS at RC1_bit;
sbit LCD_EN at RC2_bit;
sbit LCD_D4 at RC3_bit;
sbit LCD_D5 at RC4_bit;
sbit LCD_D6 at RC5_bit;
sbit LCD_D7 at RC6_bit;

sbit LCD_RS_Direction at TRISC1_bit;
sbit LCD_EN_Direction at TRISC2_bit;
sbit LCD_D4_Direction at TRISC3_bit;
sbit LCD_D5_Direction at TRISC4_bit;
sbit LCD_D6_Direction at TRISC5_bit;
sbit LCD_D7_Direction at TRISC6_bit;
//End of LCD

void interrupt() {

//Hardware interrupt flag
if(INTCON.b0 ==1)
{
turnON=1;
if(portb.b7==1)
{
if(SetMoist==99)
{}
else
{
SetMoist++;
cset=0;
}
}

if(portb.b6==1)
{
turnON=1;
if(SetMoist==5)
{}
else
{
SetMoist--;
cset=0;
}
}

if(portb.b5==1)
{
turnON=1;
portc.b0 =!portc.b0;
}
intcon.b0=0;
}

if(portb.b4==1)
{
turnON=1;
}
//End of Hardware interrupt flag
// Timer0 flag
if(INTCON.b2 ==1)
{
sensingCounter++;
screenCounter++;

//2 minutes timer for moisture
if(sensingCounter==50)
{
sensingCounter=0;
getMoist=ADC_Read(0);
getMoist=(getMoist/1024.0)*100.0;
if(getMoist<setMoist)
{
portc.b0=0b1;
}
else if(getMoist>setMoist)
{
portc.b0=0b0;
}
} //end moisture

if(screenCounter==500)
{
screenCounter=0;
turnON=0;
}

intcon.b2=0;
}
//End of timer0 flag
//interrupt
}

void main() {
INTCON = 0b10101000;
 //Timer0
 option_reg= 0b10000111;
  //TMR0=0;
 //End of timer0
 trisb= 0b11111111;
 trisd = 0b00000000;
 trisc.b7 =0;
 trisc.b0=0;
 portc.b0=0;
portd.b7=1;
portc.b7= 1;
trisa.b0=1;
Lcd_Init();
//lcd_cmd(_LCD_CURSOR_OFF);
lcd_out(1,1,"Calculating");
lcd_out(2,1,"Moisture...");
delay_ms(1000);
lcd_cmd(_LCD_CLEAR);
lcd_out(1,5,"Moisture:");

while(1)
{
if(cset==0)
{
cset=1;
//calculate R
SetMoistR= SetMoist % 10;
switch (SetMoistR) {
case 0: SetMoistR=0x3F; break;
case 1: SetMoistR=0x06; break;
case 2: SetMoistR=0x5B; break;
case 3: SetmoistR=0x4F; break;
case 4: SetmoistR=0x66; break;
case 5: SetmoistR=0x6D; break;
case 6: SetmoistR=0x7D; break;
case 7: SetmoistR=0x07; break;
case 8: SetmoistR=0x7F; break;
case 9: SetmoistR=0x6F; break;
}
// end of R calculation

//calculate L
SetMoistL= (SetMoist/10) % 10;
switch (SetMoistL) {
case 0: SetMoistL=0x3F; break;
case 1: SetMoistL=0x06; break;
case 2: SetMoistL=0x5B; break;
case 3: SetmoistL=0x4F; break;
case 4: SetmoistL=0x66; break;
case 5: SetmoistL=0x6D; break;
case 6: SetmoistL=0x7D; break;
case 7: SetmoistL=0x07; break;
case 8: SetmoistL=0x7F; break;
case 9: SetmoistL=0x6F; break;
}
//end of L calculation
}
//7Segment
portd=SetmoistR;
portc.b7=0;
portd.b7=1;
delay_ms(100);
portd=SetmoistL;
portd.b7=0;
portc.b7=1;
delay_ms(50);
//End_7Segment

//IntToStr(getMoist,buffer);
buffer[0] = (getMoist/10)%10 +48;
buffer[1] = (getMoist)%10+48;
lcd_chr(2,8,buffer[0]);
lcd_chr(2,9,buffer[1]);
lcd_chr(2,11,'%');

if(turnON==1)
{
LCD_ON;
}
else
{
LCD_OFF;
}

} //while


}       //main