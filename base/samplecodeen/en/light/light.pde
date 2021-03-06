# define EN1 6 // right motor enable pins
# define IN1 7 // right motor direction of the pin
# define EN2 5 // left motor enable pins
# define IN2 4 // left motor direction of the pin

# define FORW 1 // forward
# define BACK 0 // back
# define Vr 5 // reference voltage

float data; // store the analog voltage value

void Motor_Control (int M1_DIR, int M1_EN, int M2_DIR, int M2_EN) // control the motor rotation
{
   ////////// M1 ////////////////////////
   if (M1_DIR == FORW) // M1 direction of the motor
     digitalWrite (IN1, HIGH); // set high, set the direction of the forward
   else
     digitalWrite (IN1, LOW); // set low, set the direction of the back
   if (M1_EN == 0) // M1 motor speed
     analogWrite (EN1, LOW); // set low, miniQ stop
   else
     analogWrite (EN1, M1_EN); // Otherwise, set the corresponding value

   /////////// M2 //////////////////////
   if (M2_DIR == FORW) // M2 motor direction
     digitalWrite (IN2, HIGH); // set high, the direction of forward
   else
     digitalWrite (IN2, LOW); // set low, the direction of backward
   if (M2_EN == 0) // M2 motor speed
     analogWrite (EN2, LOW); // set low, to stop
   else
     analogWrite (EN2, M2_EN); // set the value for a given
}
void Read_Value (void) // read voltage
{
      data = analogRead (4);
      data = ((data * Vr) / 1024); // digital value into an analog value
      hunt_light ();// execute search light function
}
void hunt_light (void) // function to find the photon
{
      if (data> 1 & & data <2) // based on the actual measurement of the experimental environment
{
Motor_Control (FORW, 100, BACK, 100); // left
}
else if (data> 4 & & data <5)
{

                 Motor_Control (BACK, 100, FORW, 100); // turn right
}
else
{
Motor_Control (FORW, 0, FORW, 0); // stop
}
}
void setup ()
{
     unsigned char j;
      for (j = 4; j <= 7; j ++)// set the port to connect two sets of motor output mode
      {
          pinMode (j, OUTPUT);
      }
}
void loop ()
{
      Motor_Control (FORW, 100, FORW, 100); // car forward
      while (1)
      {
         Read_Value ();// read voltage
      }
}
