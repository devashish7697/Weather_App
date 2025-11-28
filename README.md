# 🌤️ Flutter Weather App
A modern, responsive, and beautifully designed weather application built using **Flutter**, **GetX**, and the **OpenWeather API**.  
The app displays real-time weather information including temperature, humidity, wind speed, visibility, and more — with a clean UI and dynamic background styling.

---

## 🚀 Features

- 🌍 Real-time weather information
- 📍 Auto location detection via GPS
- 🔍 Search weather by city
- ⚙️ Clean Architecture (Data → Domain → Presentation)
- ⚡ Lightning-fast API calls using **Dio**
- 🔒 Secure API key handling with Interceptors
- 🧭 GetX state management & dependency injection
- 🛑 Robust error + exception handling

### 🔹 **Real-Time Weather Data**
- Fetches live weather from OpenWeather API
- Shows city name, date, time, weather state
- Displays:
    - Temperature (°C)
    - Humidity (%)
    - Pressure (hPa)
    - Visibility (km)
    - Wind speed (km/h)
    - Cloudiness (%)
    - Min/Max temperature

### 🔹 **Dynamic Day & Night UI**
- Automatically changes icon and theme based on:
    - Current time
    - Weather conditions
- Supports linear gradient background

### 🔹 **Modern UI & Animations**
- Sleek circular slider for humidity visualisation
- Horizontal weather info cards
- Fully responsive design using:
    - MediaQuery
    - Percentage-based layout (no external packages)

### 🔹 **Search Functionality**
- Search for any city
- Real-time weather fetch on "Enter"
- Proper error handling (invalid city, network errors, etc.)

### 🔹 **State Management with GetX**
- GetX Controller for API calls
- GetX Observables for UI updates
- Smooth and simple state management

---

## 🛠️ **Tech Stack Used**

### **Frontend / Mobile App**
- **Flutter 3.x**
- **Dart**
- **GetX** for state management & dependency injection
- **SleekCircularSlider** for humidity visualization
- **Intl** package for date formatting

### **API**
- **OpenWeather API**
- HTTPS GET requests
- **DIO with Interceptors**
- JSON parsing & model mapping

### **Architecture**
- Getx Clean Architecture style (Controller → View)
- Clean, scalable folder structure

---

