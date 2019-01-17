//
//  ViewController.swift
//  utilityApp
//
//  Created by Yuanbo Li on 11/13/18.
//  Copyright © 2018 the_world. All rights reserved.
//

import UIKit
import CoreLocation
import EventKit

class MainWeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var todayDateAndTime: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cityName:UILabel!
    @IBOutlet weak var todayTemperature: UILabel!
    @IBOutlet weak var todayDescription: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    // locManager is used for managing user GPS location
    var locManager:CLLocationManager!

    // data for displaying the weather
    var timeArrayHour = [String](repeating: "hour", count: 24)
    var imageArrayHour = [UIImage](repeating: UIImage(), count: 24)
    var tempArrayHour = [String](repeating: "10°", count: 24)

    var week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var timeArrayWeek = [String]()
    var imageArrayWeek = [UIImage](repeating: UIImage(), count: 7)
    var tempArrayWeek = [String](repeating: "10°", count: 7)


    // store the weather info got from Weather API
    var weather:Weather? = nil

    @IBOutlet weak var todayImage: UIImageView!
    @IBOutlet weak var collectionViewA: UICollectionView!
    @IBOutlet weak var collectionViewB: UICollectionView!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // set up the basic configuration, get weather info from API
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize time array using calandar
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let weekday = calendar.component(.weekday, from: date)
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        todayDateAndTime.text = formatter.string(from: date)
        todayDateAndTime.adjustsFontSizeToFitWidth = true
        
        for i in 0..<24{
            timeArrayHour[i] = "\((hour + i)%24):00"
            if i == 0{
                timeArrayHour[0] = "Now"
            }
        }
        
        timeArrayWeek += week.suffix(from: weekday-1) + week.prefix(upTo: weekday-1)
        
        requestAccessToGPS()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToGesture(sender:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        WeatherWrapper.GetWeather{weather, error in
            if error == true {
                let alert = UIAlertController(title: "Weather Info Collection Failed", message: "You may want to reopen the app for updated weather info", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            DispatchQueue.main.async {
                self.weather = weather
                
                self.forDemo()
                
                //initialization
                self.initTimeAndDate()
                self.collectionViewA.reloadData()
                self.collectionViewB.reloadData()
                
            }
        }
    }

    /* ------------- Helper Function for View Configuration --------------- */
    func initTimeAndDate(){
        //initialize hourly
        for i in 0..<24{
            if let hourIconString = self.weather?.hourlyWeather?.data[i].icon{
                imageArrayHour[i] = UIImage(named: hourIconString)!
            }else{
                print("\n\n\n----")
                print("self.weather?.hourlyWeather?.data[i].icon does not exist")
                print("----\n\n\n")
            }
            if let hourTempString = self.weather?.hourlyWeather?.data[i].apparentTemperature{
                tempArrayHour[i] = String(Int(Double(hourTempString) ?? 0.0)) + "°"
            }else{
                print("\n\n\n----")
                print("self.weather?.hourlyWeather?.data[i].apparentTemperature does not exist")
                print("----\n\n\n")
            }
        }

        for i in 0..<7{
            let dayWeather = self.weather?.dailyWeather?.data[i+1]
            if let weekIconString = dayWeather?.icon{
                imageArrayWeek[i] = UIImage(named: weekIconString)!
            }else{
                print("\n\n\n----")
                print("self.weather?.dailyWeather?.data[i].icon does not exist")
                print("----\n\n\n")
            }
            if let lowTemp = dayWeather?.temperatureLow, let highTemp = dayWeather?.temperatureHigh{
                let lowTempInt = Float(lowTemp)?.rounded()
                let highTempInt = Float(highTemp)?.rounded()
                if let unwrappedLowTemp = lowTempInt, let unwrappedHighTemp = highTempInt{
                    tempArrayWeek[i] = "\(Int(unwrappedLowTemp)) - \(Int(unwrappedHighTemp))°"
                }
            }else{
                print("\n\n\n----")
                print("weather?.dailyWeather?.data[i].apparentTemperatureHigh/Low does not exist")
                print("----\n\n\n")
            }
        }

        //today
        if let tempDS = self.weather?.curWeather?.curApparentTemp{
            todayTemperature.text = " " + String(Int(Double(tempDS) ?? 0.0)) + "°"

        }

        todayDescription.text = self.weather?.curWeather?.curSummary

        todayTemperature.adjustsFontSizeToFitWidth = true
        todayDescription.adjustsFontSizeToFitWidth = true

        //        print("\n\n\n--for curIcon")
        //        print(self.weather?.curWeather?.curIcon)
        //        print("\n\n\n--for curIcon")

        let weatherIcon = self.weather?.curWeather?.curIcon ?? "clear-day"

        todayImage.image = UIImage(named: weatherIcon)

        if weatherIcon == "clear-night" || weatherIcon == "partly-cloudy-night" {
            imageView.image = UIImage(named: "night_background")
            self.todayDateAndTime.textColor = UIColor.black
            self.cityName.textColor = UIColor.black
            
        }
        else if weatherIcon == "rain" || weatherIcon == "snow" || weatherIcon == "sleet"{
            imageView.image = UIImage(named: "rainy_background")
            self.todayDateAndTime.textColor = UIColor.white
            self.cityName.textColor = UIColor.white
            self.detailButton.setTitleColor(.white, for: .normal)
        }
        else if weatherIcon == "cloudy" || weatherIcon == "partly-cloudy-day"{
            imageView.image = UIImage(named: "cloudy_background")
            self.todayDateAndTime.textColor = UIColor.black
            self.cityName.textColor = UIColor.black
        }else {
            //maybe need a background for night?
            imageView.image = UIImage(named: "sunny_background")
            self.todayDateAndTime.textColor = UIColor.black
            self.cityName.textColor = UIColor.black
        }

        //initialize the imageArray of hour and week

    }

    func requestAccessToGPS() {
        self.locManager = CLLocationManager()
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.requestAlwaysAuthorization()
        if !( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            print("location failed in request")
            return
        }
    }
    
    /* ---------- Demo specific ----------*/
    // to set up environment for demo
    func forDemo(){
        self.weather?.dailyWeather?.data[0].icon = "rain"
        self.weather?.dailyWeather?.data[0].precipProbability = "0.9"
        self.weather?.curWeather?.curSummary = "Rain"
        self.weather?.curWeather?.curIcon = "rain"
        for idx in 0...7{
            self.weather?.hourlyWeather?.data[idx].icon = "rain"
        }
        let eventStore = EKEventStore()
        for calendar in eventStore.calendars(for: EKEntityType.event){
            if calendar.title == "Calendar"{
                let newEvent = EKEvent(eventStore: eventStore)
                newEvent.calendar = eventStore.calendar(withIdentifier: calendar.calendarIdentifier)
                newEvent.title = "Demo Task"
                let currentTime = Date()
                var newstarttime = currentTime.addingTimeInterval(-60.0*Double(Calendar.current.component(.minute, from: currentTime)))
                newstarttime = newstarttime.addingTimeInterval(3600.0 * Double(1))
                var newendtime = currentTime.addingTimeInterval(-60.0*Double(Calendar.current.component(.minute, from: currentTime)))
                newendtime = newendtime.addingTimeInterval(3600.0 * Double(2))
                
                newEvent.startDate = newstarttime
                newEvent.endDate = newendtime
                
                do {
                    try eventStore.save(newEvent, span: .thisEvent, commit: true)
                    //delegate?.eventDidAdd()
                    
                    //self.dismiss(animated: true, completion: nil)
                } catch {
                    let alert = UIAlertController(title: "Demo Event could not set up, please grant access", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    /* ----------- Today Detail Button ---------*/
    @IBAction func tapOnTodaysDetail(_ sender: Any) {
        if weather == nil{
            return
        }

        if let data = self.weather?.dailyWeather?.data{
            pushWeatherDetailView(withWeatherData: data[0], dayDescription: "Today", hourlyData: weather?.hourlyWeather)
        }
    }

    // perform weather detail view transition
    func pushWeatherDetailView(withWeatherData weatherData: SingleDayWeather, dayDescription day: String?, hourlyData hourly: HourlyWeather?){
        let vc = WeatherDetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        vc.dayWeather = weatherData
        vc.dayDescription = day
        vc.hourlyWeather = hourly

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /* ------------- Action responding to swipe up gesture --------- */
    @objc
    func respondToGesture(sender: UISwipeGestureRecognizer! ){
        if sender.direction == UISwipeGestureRecognizer.Direction.up{
            let vc = CalendarCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            vc.weather = self.weather
            vc.backgroundImage = self.imageView.image
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromTop
            navigationController?.view.layer.add(transition, forKey: nil)
            navigationController?.pushViewController(vc, animated: false)

        }
    }

    /* --------------- Programmatically set up view position -------- */
    func setAnchor(forView view: UIView, atTop top: CGFloat, fromLeft left: CGFloat, withHeight height: CGFloat, withWidth width: CGFloat){
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top * self.view.frame.height).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: left * self.view.frame.width).isActive = true
        view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: width).isActive = true
        view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: height).isActive = true
    }


    /* ------------- Collection View Delegate ---------- */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == self.collectionViewA{
            return timeArrayHour.count
        } else {
            return timeArrayWeek.count
        }


    }

    // perform navigation
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewA {
            return
        }
        if let weatherData = self.weather?.dailyWeather?.data{
            var dayDescription: String? = nil
            if indexPath.item == 0{
                dayDescription = "Tomorrow"
            }else{
                if let date = Calendar.current.date(byAdding: .day, value: indexPath.item + 1, to: Date()){
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM-dd"
                    dayDescription = formatter.string(from: date)
                }else{
                    dayDescription = ""
                }
            }
            pushWeatherDetailView(withWeatherData: weatherData[indexPath.item + 1], dayDescription: dayDescription, hourlyData: weather?.hourlyWeather)

        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.collectionViewA {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell


            cellA.imgImage.image = imageArrayHour[indexPath.row]
            cellA.imgLabel.text = timeArrayHour[indexPath.row]
            cellA.imgTemperature.text = tempArrayHour[indexPath.row]

            cellA.imgLabel.adjustsFontSizeToFitWidth = true
            cellA.imgTemperature.adjustsFontSizeToFitWidth = true

            return cellA
        }

        else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell


            cellB.imgImage.image = imageArrayWeek[indexPath.row]
            cellB.imgLabel.text = timeArrayWeek[indexPath.row]
            cellB.imgTemperature.text = tempArrayWeek[indexPath.row]

            cellB.imgLabel.adjustsFontSizeToFitWidth = true
            cellB.imgTemperature.adjustsFontSizeToFitWidth = true

            return cellB
        }
    }
}

