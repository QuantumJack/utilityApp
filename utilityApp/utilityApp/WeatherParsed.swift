//
//  File.swift
//  utilityApp
//
//  Created by Weiran Guo on 2018/11/22.
//  Copyright © 2018 the_world. All rights reserved.
//

import Foundation

struct WeatherWrapper {
    static func GetWeather(input: (Double, Double),completion: @escaping(_ weather:Weather?, _ error: Bool?) -> Void) {
        WeatherAPI.APICall(input: input){ response, error in
            
            if (response == nil){
            	completion(nil, true)
                return
            }
            //print("Call success")

            let weather = Weather.init(weatherJson: response ?? [:])
            completion(weather, false)
        }
    }
    static func GetWeather(completion: @escaping(_ weather:Weather?, _ error: Bool?) -> Void) {
        WeatherAPI.APICall{ response, error in
            
            if (response == nil){
                completion(nil, true)
                return
            }
            //print("Call success")
            
            let weather = Weather.init(weatherJson: response ?? [:])
            completion(weather, false)
        }
    }
}


class Weather {
    var originJson:[String: Any]?
    var curWeather:CurWeather?
    var hourlyWeather:HourlyWeather?
    var dailyWeather:DailyWeather?
    var timezone:String
    
    init(weatherJson: [String:Any]){
        self.originJson = weatherJson
            //print(self.originJson)
        self.curWeather = CurWeather.init(current: weatherJson["currently"] as! [String : Any])
        self.hourlyWeather = HourlyWeather.init(hours: weatherJson["hourly"] as! [String : Any])
        self.dailyWeather = DailyWeather.init(daily: weatherJson["daily"] as! [String : Any])
        self.timezone = "\(weatherJson["timezone"] ?? "")"
            //print(self.curTemp)
    }
        //print(self.curTemp)
}

class CurWeather {
    var curTemp:String
    var curApparentTemp:String
    var curCloudCover:String
    var curDewPoint:String
    var curHumidity:String
    var curIcon:String
    var curNearestStormDistance:String
    var curOzone:String
    var curPrecipIntensity:String
    var curPrecipIntensityError:String
    var curPrecipProbability:String
    var curPrecipType:String
    var curPressure:String
    var curSummary:String
    var curTime:String
    var curUvIndex:String
    var curVisibility:String
    var curWindBearing:String
    var curWindGust:String
    var curWindSpeed:String
    var usefulList:[(String, String)] = []
    
    init(current:[String:Any]){
        //print("Current success")
        //print(current)
        self.curTemp = "\(current["temperature"] ?? "")"
        self.curApparentTemp = "\(current["apparentTemperature"] ?? "")"
        self.curCloudCover = "\(current["cloudCover"] ?? "")"
        self.curDewPoint = "\(current["dewPoint"] ?? "")"
        self.curHumidity = "\(current["humidity"] ?? "")"
        self.curIcon = "\(current["icon"] ?? "")"
        self.curNearestStormDistance = "\(current["nearestStormDistance"] ?? "")"
        self.curOzone = "\(current["ozone"] ?? "")"
        self.curPrecipIntensity = "\(current["precipIntensity"] ?? "")"
        self.curPrecipIntensityError = "\(current["precipIntensityError"] ?? "")"
        self.curPrecipProbability = "\(current["precipProbability"] ?? "")"
        self.curPrecipType = "\(current["precipType"] ?? "")"
        self.curPressure = "\(current["pressure"] ?? "")"
        self.curSummary = "\(current["summary"] ?? "")"
        self.curTime = "\(current["time"] ?? "")"
        self.curUvIndex = "\(current["uvIndex"] ?? "")"
        self.curVisibility = "\(current["visibility"] ?? "")"
        self.curWindBearing = "\(current["windBearing"] ?? "")"
        self.curWindGust = "\(current["windGust"] ?? "")"
        self.curWindSpeed = "\(current["windSpeed"] ?? "")"
        self.usefulList.append(("temperature", self.curTemp))
        self.usefulList.append(("feels like", self.curApparentTemp))
        self.usefulList.append(("cloud cover", self.curCloudCover))
        self.usefulList.append(("dew point", self.curDewPoint))
        self.usefulList.append(("humidity", self.curHumidity))
        self.usefulList.append(("ozone", self.curOzone))
        self.usefulList.append(("pressure", self.curPressure))
        self.usefulList.append(("uv index", self.curUvIndex))
        self.usefulList.append(("visibility", self.curVisibility))
        //self.usefulList.append(("wind bearing", self.curWindBearing))
        self.usefulList.append(("wind speed", self.curWindSpeed))
        self.usefulList.append(("precip type", self.curPrecipType))
        self.usefulList.append(("precip probability", String(format: "%.4f", self.curPrecipProbability)))
        //self.usefulList.append(("wind gust",))
        //print(self.curTemp)
        
    }
}

class HourWeather {
    var time: String
    var summary: String
    var icon: String
    var precipIntensity: String
    var precipProbability: String
    var precipType: String
    var temperature: String
    var apparentTemperature: String
    var dewPoint: String
    var humidity: String
    var pressure: String
    var windSpeed: String
    var windGust: String
    var windBearing: String
    var cloudCover: String
    var uvIndex: String
    var visibility: String
    var ozone: String
    var usefulList:[(String, String)] = []
    
    init(hour : [String: Any]){
        //print("Hour success")
        self.time = "\(hour["time"] ?? "")"
        self.summary = "\(hour["summary"] ?? "")"
        self.icon = "\(hour["icon"] ?? "")"
        self.precipIntensity = "\(hour["precipIntensity"] ?? "")"
        self.precipProbability = "\(hour["precipProbability"] ?? "")"
        self.precipType = "\(hour["precipType"] ?? "")"
        self.temperature = "\(hour["temperature"] ?? "")"
        self.apparentTemperature = "\(hour["apparentTemperature"] ?? "")"
        self.dewPoint = "\(hour["dewPoint"] ?? "")"
        self.humidity = "\(hour["humidity"] ?? "")"
        self.pressure = "\(hour["pressure"] ?? "")"
        self.windSpeed = "\(hour["windSpeed"] ?? "")"
        self.windGust = "\(hour["windGust"] ?? "")"
        self.windBearing = "\(hour["windBearing"] ?? "")"
        self.cloudCover = "\(hour["cloudCover"] ?? "")"
        self.uvIndex = "\(hour["uvIndex"] ?? "")"
        self.visibility = "\(hour["visibility"] ?? "")"
        self.ozone = "\(hour["ozone"] ?? "")"
        self.usefulList.append(("temperature", self.temperature))
        self.usefulList.append(("feels like", self.apparentTemperature))
        self.usefulList.append(("dew point", self.dewPoint))
        self.usefulList.append(("humidity", self.humidity))
        self.usefulList.append(("pressure", self.pressure))
        self.usefulList.append(("wind speed", self.windSpeed))
        self.usefulList.append(("cloud cover", self.cloudCover))
        self.usefulList.append(("uv index", self.uvIndex))
        self.usefulList.append(("visibility", self.visibility))
        self.usefulList.append(("ozone", self.ozone))
    }
}

class HourlyWeather {
    var summary:String
    var data:[HourWeather] = []
    
    
    init(hours:[String:Any]){
        //self.data = [HourWeather]()
        //print("Hourly success")
        self.summary = "\(hours["summary"] ?? "")"
        var temp:[[String:Any]]
        temp = hours["data"] as! [[String : Any]]
        
        for i in 0...48 {
            self.data.append(HourWeather.init(hour: temp[i]))
        }
    }
}

class SingleDayWeather {
    var time:String
    var summary:String
    var icon:String
    var sunriseTime:String
    var sunsetTime:String
    var moonPhase:String
    var precipIntensity:String
    var precipIntensityMax:String
    var precipIntensityMaxTime:String
    var precipProbability:String
    var precipType:String
    var temperatureHigh:String
    var temperatureHighTime:String
    var temperatureLow:String
    var temperatureLowTime:String
    var apparentTemperatureHigh:String
    var apparentTemperatureHighTime:String
    var apparentTemperatureLow:String
    var apparentTemperatureLowTime:String
    var dewPoint:String
    var humidity:String
    var pressure:String
    var windSpeed:String
    var windGust:String
    var windGustTime:String
    var windBearing:String
    var cloudCover:String
    var uvIndex:String
    var uvIndexTime:String
    var visibility:String
    var ozone:String
    var temperatureMin:String
    var temperatureMinTime:String
    var temperatureMax:String
    var temperatureMaxTime:String
    var apparentTemperatureMin:String
    var apparentTemperatureMinTime:String
    var apparentTemperatureMax:String
    var apparentTemperatureMaxTime:String
    var usefulList:[(String, String)] = []
    init(day: [String:Any]) {
        self.time = "\(day["time"] ?? "")"
        self.summary = "\(day["summary"] ?? "")"
        self.icon = "\(day["icon"] ?? "")"
        self.sunriseTime = "\(day["sunriseTime"] ?? "")"
        self.sunsetTime = "\(day["sunsetTime"] ?? "")"
        self.moonPhase = "\(day["moonPhase"] ?? "")"
        self.precipIntensity = "\(day["precipIntensity"] ?? "")"
        self.precipIntensityMax = "\(day["precipIntensityMax"] ?? "")"
        self.precipIntensityMaxTime = "\(day["precipIntensityMaxTime"] ?? "")"
        self.precipProbability = "\(day["precipProbability"] ?? "")"
        self.precipType = "\(day["precipType"] ?? "")"
        self.temperatureHigh = "\(day["temperatureHigh"] ?? "")"
        self.temperatureHighTime = "\(day["temperatureHighTime"] ?? "")"
        self.temperatureLow = "\(day["temperatureLow"] ?? "")"
        self.temperatureLowTime = "\(day["temperatureLowTime"] ?? "")"
        self.apparentTemperatureHigh = "\(day["apparentTemperatureHigh"] ?? "")"
        self.apparentTemperatureHighTime = "\(day["apparentTemperatureHighTime"] ?? "")"
        self.apparentTemperatureLow = "\(day["apparentTemperatureLow"] ?? "")"
        self.apparentTemperatureLowTime = "\(day["apparentTemperatureLowTime"] ?? "")"
        self.dewPoint = "\(day["dewPoint"] ?? "")"
        self.humidity = "\(day["humidity"] ?? "")"
        self.pressure = "\(day["pressure"] ?? "")"
        self.windSpeed = "\(day["windSpeed"] ?? "")"
        self.windGust = "\(day["windGust"] ?? "")"
        self.windGustTime = "\(day["windGustTime"] ?? "")"
        self.windBearing = "\(day["windBearing"] ?? "")"
        self.cloudCover = "\(day["cloudCover"] ?? "")"
        self.uvIndex = "\(day["uvIndex"] ?? "")"
        self.uvIndexTime = "\(day["uvIndexTime"] ?? "")"
        self.visibility = "\(day["visibility"] ?? "")"
        self.ozone = "\(day["ozone"] ?? "")"
        self.temperatureMin = "\(day["temperatureMin"] ?? "")"
        self.temperatureMinTime = "\(day["temperatureMinTime"] ?? "")"
        self.temperatureMax = "\(day["temperatureMax"] ?? "")"
        self.temperatureMaxTime = "\(day["temperatureMaxTime"] ?? "")"
        self.apparentTemperatureMin = "\(day["apparentTemperatureMin"] ?? "")"
        self.apparentTemperatureMinTime = "\(day["apparentTemperatureMinTime"] ?? "")"
        self.apparentTemperatureMax = "\(day["apparentTemperatureMax"] ?? "")"
        self.apparentTemperatureMaxTime = "\(day["apparentTemperatureMaxTime"] ?? "")"

        //self.usefulList.append(("sun rise", ))
        self.usefulList.append(("moon phase", self.moonPhase))
        self.usefulList.append(("precip type", self.precipType))
        self.usefulList.append(("precip probability", self.precipProbability))
        self.usefulList.append(("temperature high", self.temperatureHigh))
        self.usefulList.append(("temperature low", self.temperatureLow))
        self.usefulList.append(("dew point", self.dewPoint))
        self.usefulList.append(("humidity", self.humidity))
        self.usefulList.append(("pressure", self.pressure))
        self.usefulList.append(("wind speed", self.windSpeed))
        self.usefulList.append(("cloud cover", self.cloudCover))
        self.usefulList.append(("uv index", self.uvIndex))
        self.usefulList.append(("visibility", self.visibility))
        self.usefulList.append(("ozone", self.ozone))
    }
    
    //func unixTimeToReal
}

class DailyWeather {
    var summary:String
    var icon:String
    var data:[SingleDayWeather] = []
    
    init(daily:[String:Any]) {
        self.summary = "\(daily["summary"] ?? "")"
        self.icon = "\(daily["icon"] ?? "")"
        var temp: [[String:Any]]
        temp = daily["data"] as! [[String : Any]]
        
        for i in 0...7{
            self.data.append(SingleDayWeather.init(day: temp[i]))
        }
    }
}
