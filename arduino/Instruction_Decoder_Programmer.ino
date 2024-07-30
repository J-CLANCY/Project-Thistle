#define SHIFT_DATA 2
#define SHIFT_CLK 3
#define SHIFT_LATCH 4
#define EEPROM_D0 5
#define EEPROM_D7 12
#define WRITE_EN 13

/*
 * Output the address bits and outputEnable signal using shift registers.
 */
void setAddress(int address, bool outputEnable) {
  shiftOut(SHIFT_DATA, SHIFT_CLK, MSBFIRST, (address >> 8) | (outputEnable ? 0x00 : 0x80));
  shiftOut(SHIFT_DATA, SHIFT_CLK, MSBFIRST, address);

  digitalWrite(SHIFT_LATCH, LOW);
  digitalWrite(SHIFT_LATCH, HIGH);
  digitalWrite(SHIFT_LATCH, LOW);
}


/*
 * Read a byte from the EEPROM at the specified address.
 */
byte readEEPROM(int address) {
  for (int pin = EEPROM_D0; pin <= EEPROM_D7; pin += 1) {
    pinMode(pin, INPUT);
  }
  setAddress(address, /*outputEnable*/ true);

  byte data = 0;
  for (int pin = EEPROM_D7; pin >= EEPROM_D0; pin -= 1) {
    data = (data << 1) + digitalRead(pin);
  }
  return data;
}


/*
 * Write a byte to the EEPROM at the specified address.
 */
void writeEEPROM(int address, byte data) {
  setAddress(address, /*outputEnable*/ false);
  for (int pin = EEPROM_D0; pin <= EEPROM_D7; pin += 1) {
    pinMode(pin, OUTPUT);
  }

  for (int pin = EEPROM_D0; pin <= EEPROM_D7; pin += 1) {
    digitalWrite(pin, data & 1);
    data = data >> 1;
  }
  digitalWrite(WRITE_EN, LOW);
  delayMicroseconds(1);
  digitalWrite(WRITE_EN, HIGH);
  delay(10);
}


/*
 * Read the contents of the EEPROM and print them to the serial monitor.
 */
void printContents() {
  for (int base = 0; base <= 2047; base += 16) {
    byte data[16];
    for (int offset = 0; offset <= 15; offset += 1) {
      data[offset] = readEEPROM(base + offset);
    }

    char buf[80];
    sprintf(buf, "%03x:  %02x %02x %02x %02x %02x %02x %02x %02x   %02x %02x %02x %02x %02x %02x %02x %02x",
            base, data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7],
            data[8], data[9], data[10], data[11], data[12], data[13], data[14], data[15]);

    Serial.println(buf);
  }
}

#define HLT 0b100000000000000000000000
#define RI  0b010000000000000000000000
#define RO  0b001000000000000000000000
#define MI  0b000100000000000000000000
#define PIN 0b000010000000000000000000
#define PO  0b000001000000000000000000
#define PE  0b000000100000000000000000
#define II  0b000000010000000000000000
#define DI  0b000000001000000000000000
#define DO  0b000000000100000000000000
#define CI  0b000000000010000000000000
#define CO  0b000000000001000000000000
#define BI  0b000000000000100000000000
#define BO  0b000000000000010000000000
#define AI  0b000000000000001000000000
#define AO  0b000000000000000100000000
#define ALI 0b000000000000000010000000
#define ALO 0b000000000000000001000000
#define CYI 0b000000000000000000100000
#define OI  0b000000000000000000010000
#define OO  0b000000000000000000001000
#define AC  0b000000000000000000000100
#define BC  0b000000000000000000000010

uint32_t data[] = {
 /* MI|PO, RO|II, MI|PO|PE, RO|MI, RO|AI, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|BI, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|CI, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|DI, PE, 0, 0,
  
  MI|PO, RO|II, MI|PO|PE, RO|MI, RI|AO, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RI|BO, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RI|CO, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RI|DO, PE, 0, 0,
  
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  MI|PO, RO|II, MI|PO|PE, RO|MI, RO|PIN, PE, 0, 0,
  
  MI|PO, RO|II,    PIN|AO,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    PIN|BO,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    PIN|CO,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    PIN|DO,     0,    0,  PE, 0, 0,
  
  MI|PO, RO|II,      HLT,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,      HLT,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,      HLT,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,      HLT,     0,    0,  PE, 0, 0,
  
  MI|PO, RO|II,       AC,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,       BC,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,        0,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,        0,     0,    0,  PE, 0, 0,
  
  MI|PO, RO|II,    OI|AI,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    OI|BI,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    OI|CI,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    OI|DI,     0,    0,  PE, 0, 0,
  
  MI|PO, RO|II,    OO|AI,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    OO|BI,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    OO|CI,     0,    0,  PE, 0, 0,
  MI|PO, RO|II,    OO|DI,     0,    0,  PE, 0, 0,*/
  
  MI|PO, RO|II,      ALI,ALO|AI,    0,  PE, 0, 0,
  MI|PO, RO|II,      ALI,ALO|AI,    0,  PE, 0, 0,
  MI|PO, RO|II,      ALI,ALO|AI,    0,  PE, 0, 0,
  MI|PO, RO|II,      ALI,ALO|AI,    0,  PE, 0, 0,
  
  MI|PO, RO|II,  CYI|ALI,ALO|AI|CYI,0,  PE, 0, 0,
  MI|PO, RO|II,  CYI|ALI,ALO|AI|CYI,0,  PE, 0, 0,
  MI|PO, RO|II,  CYI|ALI,ALO|AI|CYI,0,  PE, 0, 0,
  MI|PO, RO|II,  CYI|ALI,ALO|AI|CYI,0,  PE, 0, 0,
};

int address[] = {
  67,
  68,
  69,
  83,
  84,
  85,
  107,
  108,
  109,
  123,
  124,
  125,
  
};

void setup() {
  
  // put your setup code here, to run once:
  pinMode(SHIFT_DATA, OUTPUT);
  pinMode(SHIFT_CLK, OUTPUT);
  pinMode(SHIFT_LATCH, OUTPUT);
  digitalWrite(WRITE_EN, HIGH);
  pinMode(WRITE_EN, OUTPUT);
  Serial.begin(57600);

  // Erase entire EEPROM
 
 /* Serial.print("Erasing EEPROM");
  for (int address = 0; address <= 2047; address += 1) {
    writeEEPROM(address, 0x00);

    if (address % 64 == 0) {
      Serial.print(".");
    }
  }
  Serial.println(" done");


  // Program data bytes
  Serial.print("Programming EEPROM");
  for (int i = 0; i < 319; i += 1) {
    writeEEPROM(i, data[i]);

    if (i % 64 == 0) {
      Serial.print(".");
    }
  }*/
 /* for (int i = 0; i < 63; i += 1) {
    writeEEPROM(i+1024, data[i]);
  }*/
  /*for(int i=0;i<=11;i++){
    writeEEPROM(address[i], 0x00);
  }*/
  Serial.println(" done");


  // Read and print out the contents of the EERPROM
  Serial.println("Reading EEPROM");
  printContents();
}


void loop() {
  // put your main code here, to run repeatedly:

}
