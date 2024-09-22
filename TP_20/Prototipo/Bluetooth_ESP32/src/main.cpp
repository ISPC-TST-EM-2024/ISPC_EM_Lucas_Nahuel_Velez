#include "BluetoothSerial.h"

BluetoothSerial SerialBT;
bool deviceConnected = false;  // Bandera para verificar si está conectado

void setup() {
  Serial.begin(115200);
  SerialBT.begin("ESP32_BT");  // Inicia Bluetooth
  Serial.println("Esperando emparejamiento...");
}

void loop() {
  if (!SerialBT.hasClient()) {  // Si no hay cliente conectado
    if (deviceConnected) {
      Serial.println("Dispositivo desconectado.");
      deviceConnected = false;
    }
    delay(1000);  // Reintentar cada segundo
  } else {
    if (!deviceConnected) {
      Serial.println("Dispositivo conectado.");
      deviceConnected = true;
    }

    // Enviar y recibir datos como siempre
    if (Serial.available()) {
      SerialBT.println(Serial.readString());
    }

    if (SerialBT.available()) {
      Serial.println("Datos recibidos: " + SerialBT.readString());
    }
  }
}
