

 int rfReceivePin= A0;  //RF Receiver pin = Analog pin 0
 int motorpwm =8;
 int motorbrk=9;
 int motor=10;

 unsigned int data = 0; 
const unsigned int lowerThreshold = 600; // variable used to store received data
 const unsigned int upperThreshold = 1000;  //upper threshold value
 
 void setup(){
   pinMode(motorpwm, OUTPUT);
   pinMode(motorbrk, OUTPUT);
   pinMode(motor, OUTPUT);
   Serial.begin(9600);
 }
 void loop(){
   data=analogRead(rfReceivePin);    //listen for data on Analog pin 0
   
    if(data>upperThreshold){
     digitalWrite(motorpwm, LOW);
     digitalWrite(motorbrk, LOW);
     digitalWrite(motor, HIGH);
     
     Serial.println(data);
   }
   if(data<upperThreshold){
     digitalWrite(motorpwm, HIGH);
     digitalWrite(motorbrk, HIGH);
     digitalWrite(motor, LOW);
     Serial.println(data);
   }
   
 }
