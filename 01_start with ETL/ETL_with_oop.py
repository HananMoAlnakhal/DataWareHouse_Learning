import requests
import pandas as pd

class City_weather():

    def __init__(self,city_name,key="718db35187e1f1aa123e0a793d24c34d"):
        self.API_key=key
        self.name=city_name.title()
        self.API_url=f"http://api.openweathermap.org/data/2.5/weather?q={self.name}&appid={self.API_key}&units=metric"
        

    def GetWeather(self):
        try:
            self.connection = requests.get(self.API_url).json()
            print("Connected...")
            print(self.name+"'s weather data is ready in json")
            return(self.connection)
        except (Exception) as error:
            print("Error while getting the data:", error)

def json_to_dic(j):
    data = {
    "City": j["name"],
    "Country": j["sys"]["country"],
    "Temperature (°C)": j["main"]["temp"],
    "Feels Like (°C)": j["main"]["feels_like"],
    "Min Temperature (°C)": j["main"]["temp_min"],
    "Max Temperature (°C)": j["main"]["temp_max"],
    "Humidity (%)": j["main"]["humidity"],
    "Pressure (hPa)": j["main"]["pressure"],
    "Wind Speed (m/s)": j["wind"]["speed"],
    "Cloud Cover (%)": j["clouds"]["all"]
    }
    return(data)


gaza=City_weather("Gaza")
Paris=City_weather("Paris")
GazaWeather=json_to_dic(gaza.GetWeather())
ParisWeather=json_to_dic(Paris.GetWeather())


weather_df = pd.DataFrame([GazaWeather,ParisWeather])
print(weather_df)



        