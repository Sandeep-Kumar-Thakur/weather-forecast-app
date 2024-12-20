🌦 Weather Forecast App
A sleek, modern Flutter-based weather forecast application that helps you stay updated with real-time weather information. Whether you want to check the current weather at your location or explore conditions in other cities worldwide, this app has got you covered!

✨ Features
Real-time Weather Updates: Stay informed about the latest temperature, humidity, wind speed, and more.
Search by Location: Easily search and check weather for any city worldwide.
Geolocation Support: Automatically fetch weather details for your current location.
Clean and Intuitive UI: A user-friendly interface for seamless navigation and interaction.
Detailed Forecast: Access a comprehensive forecast, including hourly and daily breakdowns.

🛠️ Tech Stack
Flutter: For building a cross-platform and high-performance app.
API Integration: Powered by a robust weather API to fetch real-time data.
State Management: BLOC (customize based on your implementation).
Responsive Design: Optimized for various screen sizes and orientations.

Prerequisites
Flutter SDK installed on your system
Access to a weather API (weatherapi)
API Key from the chosen weather API provider

Configure Environment Variables:

Create a .env file in the project root.
Add the following content:
dotenv
Copy code
base_url=""  
key=""  
Ensure you use the flutter_dotenv package to load these variables into your project.