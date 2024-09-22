#include <WiFi.h>  // Librería estándar para manejo de Wi-Fi

// Define las credenciales de la red Wi-Fi
const char* ssid = "Tu_SSID";
const char* password = "Tu_Contraseña";

void setup() {
  Serial.begin(115200);  // Inicializa el monitor serie
  conectarWiFi();        // Llama a la función que conecta al Wi-Fi
}

void loop() {
  // Monitorea el estado de la conexión
  if (WiFi.status() != WL_CONNECTED) {
    Serial.println("Conexión perdida. Intentando reconectar...");
    conectarWiFi();  // Reconecta si se pierde la conexión
  } else {
    Serial.println("Conectado a Wi-Fi.");
    Serial.print("IP Address: ");
    Serial.println(WiFi.localIP());  // Imprime la IP obtenida
  }
  delay(10000);  // Monitorea el estado cada 10 segundos
}

void conectarWiFi() {
  Serial.println("Conectando a Wi-Fi...");
  WiFi.begin(ssid, password);  // Inicia la conexión Wi-Fi

  // Espera hasta que la conexión sea exitosa
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("\nConexión establecida.");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());  // Imprime la dirección IP obtenida
}
