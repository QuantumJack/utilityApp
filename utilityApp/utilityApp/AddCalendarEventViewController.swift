//
//  AddCalendarEventViewController.swift
//  utilityApp
//
//  Created by Weiran Guo on 2018/12/4.
//  Copyright © 2018 the_world. All rights reserved.
//

import UIKit
import EventKit

class AddCalendarEventViewController: UIViewController {
    
    var calendar: EKCalendar!
    var calendarCollection: CalendarCollectionViewController!
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventStartDatePicker: UIDatePicker!
    @IBOutlet weak var eventEndDatePicker: UIDatePicker!
    @IBOutlet weak var eventByDatePicker: UIDatePicker!
    @IBOutlet weak var startNotify:UILabel!
    
    @IBOutlet weak var startDate:UILabel!
    @IBOutlet weak var endDate:UILabel!
    @IBOutlet weak var byDate:UILabel!
    @IBOutlet weak var startTime:UILabel!
    @IBOutlet weak var endTime:UILabel!
    @IBOutlet weak var hourTextField: UITextField!
    
    @IBOutlet weak var byTime:UILabel!
    @IBOutlet weak var startDatePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var startDatePickerMarginTop: NSLayoutConstraint!
    
    @IBOutlet weak var indoorCheck:UIButton!
    @IBOutlet weak var outdoorCheck:UIButton!
    
    @IBOutlet weak var endDatePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var endDatePickerMarginTop: NSLayoutConstraint!
    
    @IBOutlet weak var byDatePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var byDatePickerMarginTop: NSLayoutConstraint!
    
    @IBOutlet weak var locationCell: UITableViewCell!
    
    //var delegate: EventAddedDelegate?
    var weather:Weather?
    var eventTitle:String?
    var datePickerOpened: Bool = false    // state variable
    let datePickerHeightOpened: CGFloat = 214
    let datePickerHeightClosed: CGFloat = 0
    let datePickerMarginTopOpened: CGFloat = 50  // 18 (see below)
    let datePickerMarginTopClosed: CGFloat = 50
    let animateTimeStd: TimeInterval = 0.5
    let animateTimeZero: TimeInterval = 0.0
    
    var enddatePickerOpened: Bool = false    // state variable
    let enddatePickerHeightOpened: CGFloat = 214
    let enddatePickerHeightClosed: CGFloat = 0
    let enddatePickerMarginTopOpened: CGFloat = 10  // 18 (see below)
    let enddatePickerMarginTopClosed: CGFloat = 10
    let endanimateTimeStd: TimeInterval = 0.5
    let endanimateTimeZero: TimeInterval = 0.0
    
    var bydatePickerOpened: Bool = false    // state variable
    let bydatePickerHeightOpened: CGFloat = 214
    let bydatePickerHeightClosed: CGFloat = 0
    let bydatePickerMarginTopOpened: CGFloat = 10  // 18 (see below)
    let bydatePickerMarginTopClosed: CGFloat = 10
    let byanimateTimeStd: TimeInterval = 0.5
    let byanimateTimeZero: TimeInterval = 0.0
    
    var coordinate:CLLocationCoordinate2D?
    
    func showStartDatePicker(show: Bool, animateTime: TimeInterval) {
        // set state variable
        datePickerOpened = show
        
        // this makes the datePicker disappear from the screen BUT leaves the space still occupied
        // this is not strictly necessary but it will make the appearance more tidy
        self.eventStartDatePicker.isHidden = !show
        
        // animate the datePicker open/hide - this is the where the constraints are modified
        UIView.animate(withDuration: animateTime, animations: {
            
            // toggle open/close the datePicker
            self.startDatePickerHeight.constant = (show ? self.datePickerHeightOpened : self.datePickerHeightClosed)
            
            // toggle open/close the datePicker top margin
            // as it turns out for me, it looked better in my set up to have top margin zero all the time but I'm leaving the code here in case I need it later
            self.startDatePickerMarginTop.constant = (show ? self.datePickerMarginTopOpened : self.datePickerMarginTopClosed)
            
            // this I understand tells the view to update
            self.view.layoutIfNeeded()
        })
    }
    
    func showEndDatePicker(show: Bool, animateTime: TimeInterval) {
        // set state variable
        enddatePickerOpened = show
        
        // this makes the datePicker disappear from the screen BUT leaves the space still occupied
        // this is not strictly necessary but it will make the appearance more tidy
        self.eventEndDatePicker.isHidden = !show
        
        // animate the datePicker open/hide - this is the where the constraints are modified
        UIView.animate(withDuration: animateTime, animations: {
            
            // toggle open/close the datePicker
            self.endDatePickerHeight.constant = (show ? self.enddatePickerHeightOpened : self.enddatePickerHeightClosed)
            
            // toggle open/close the datePicker top margin
            // as it turns out for me, it looked better in my set up to have top margin zero all the time but I'm leaving the code here in case I need it later
            self.endDatePickerMarginTop.constant = (show ? self.enddatePickerMarginTopOpened : self.enddatePickerMarginTopClosed)
            
            // this I understand tells the view to update
            self.view.layoutIfNeeded()
        })
    }
    
    func showByDatePicker(show: Bool, animateTime: TimeInterval) {
        // set state variable
        bydatePickerOpened = show
        //print(show)
        // this makes the datePicker disappear from the screen BUT leaves the space still occupied
        // this is not strictly necessary but it will make the appearance more tidy
        self.eventByDatePicker.isHidden = !show
        //print(show)
        // animate the datePicker open/hide - this is the where the constraints are modified
        UIView.animate(withDuration: animateTime, animations: {
            
            // toggle open/close the datePicker
            self.byDatePickerHeight.constant = (show ? self.bydatePickerHeightOpened : self.bydatePickerHeightClosed)
            
            // toggle open/close the datePicker top margin
            // as it turns out for me, it looked better in my set up to have top margin zero all the time but I'm leaving the code here in case I need it later
            self.byDatePickerMarginTop.constant = (show ? self.bydatePickerMarginTopOpened : self.bydatePickerMarginTopClosed)
            
            // this I understand tells the view to update
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        //print("print \(sender.date)")
        self.startTime.text = DateToString(date: sender.date)
        print(self.startTime.text ?? "None")  // "somedateString" is your string date
    }
    
    @IBAction func endDatePickerChanged(sender: UIDatePicker) {
        self.endTime.text = DateToString(date: sender.date)
        print(self.endTime.text ?? "None")
    }
    
    @IBAction func byDatePickerChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "MMM dd yyyy hh:mm a"
        let somedateString = dateFormatter.string(from: sender.date)
        self.byTime.text = somedateString
        print(self.byTime.text ?? "None")
    }
    
    func DateToString(date :Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "hh:mm a"
        let somedateString = dateFormatter.string(from: date)
        return somedateString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddCalendarEventViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        //print("laod")
        //self.dateTextField.text = "1"
        self.hourTextField.text = "1"
        //self.dateTextField.textColor = UIColor.lightGray
        self.scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 2000)
        self.indoorCheck.isSelected = true
        self.outdoorCheck.isSelected = false
        self.eventStartDatePicker.datePickerMode = .time
        self.eventEndDatePicker.datePickerMode = .time

        self.startTime.text = DateToString(date: initialDatePickerValue())
        self.endTime.text = DateToString(date: endinitialDatePickerValue())
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "MMM dd yyyy hh:mm a"
        let somedateString = dateFormatter.string(from: endinitialDatePickerValue())
        self.byTime.text = somedateString

        self.eventStartDatePicker?.setDate(initialDatePickerValue(), animated: false)
        self.eventEndDatePicker?.setDate(endinitialDatePickerValue(), animated: false)
        self.eventByDatePicker?.setDate(endinitialDatePickerValue(), animated: false)
        
        showStartDatePicker(show: false, animateTime: animateTimeZero)
        showEndDatePicker(show: false, animateTime: endanimateTimeZero)
        showByDatePicker(show: false, animateTime: byanimateTimeZero)
        
        self.startDate.isUserInteractionEnabled = true
        self.endDate.isUserInteractionEnabled = true
        self.byDate.isUserInteractionEnabled = true
        let tapstart = UITapGestureRecognizer(target: self, action: #selector(AddCalendarEventViewController.tapStart))
        let tapend = UITapGestureRecognizer(target: self, action: #selector(AddCalendarEventViewController.tapEnd))
        let taploc = UITapGestureRecognizer(target: self, action: #selector(AddCalendarEventViewController.locationTapped))
        let tapby = UITapGestureRecognizer(target: self, action: #selector(AddCalendarEventViewController.tapBy))
        self.locationCell.addGestureRecognizer(taploc)
        self.startDate.addGestureRecognizer(tapstart)
        self.endDate.addGestureRecognizer(tapend)
        self.byDate.addGestureRecognizer(tapby)
        
        self.locationCell.textLabel!.text = "Location: Default your location"
        self.locationCell.textLabel!.textColor = UIColor.lightGray
        self.locationCell.layer.borderColor = UIColor.gray.cgColor
        
        //print(coordinate)
        //self.locationCell.heightAnchor
        //print(self.locationCell.textLabel!.text)
        //print(indoorCheck)

    }
    
    @objc
    func locationTapped(sender:UITapGestureRecognizer) {
        print("locationTapped")
        let storyboard = UIStoryboard(name: "Main", bundle: nil) //if bundle is nil the main bundle will be used
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        secondViewController.addCalendarView = self
        self.navigationController!.pushViewController(secondViewController, animated: true)
        //self.reloadInputViews()
    }
    
    @objc
    func tapStart(sender:UITapGestureRecognizer) {
        //print("tap working")
        showStartDatePicker(show: !datePickerOpened, animateTime: animateTimeStd)
    }
    
    @objc
    func tapEnd(sender:UITapGestureRecognizer) {
        //print("tap working")
        showEndDatePicker(show: !enddatePickerOpened, animateTime: endanimateTimeStd)
    }
    
    @objc
    func tapBy(sender:UITapGestureRecognizer) {
        //print("tap working")
        showByDatePicker(show: !bydatePickerOpened, animateTime: endanimateTimeStd)
    }
    
    func initialDatePickerValue() -> Date {
        //print("call")
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 9
        dateComponents.minute = 0
        dateComponents.second = 0
        
        let initdate = Calendar.current.date(from: dateComponents)!
        print(initdate)
        return initdate
    }
    
    func endinitialDatePickerValue() -> Date {
        //print("call")
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 21
        dateComponents.minute = 0
        dateComponents.second = 0

        let initdate = Calendar.current.date(from: dateComponents)!
        print(initdate)
        return initdate
    }
    
    @IBAction func indoorTapped(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        if (self.outdoorCheck.isSelected == sender.isSelected){
        	self.outdoorCheck.isSelected = !self.outdoorCheck.isSelected
        }
    }
    
    @IBAction func outdoorTapped(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        if (self.indoorCheck.isSelected == sender.isSelected){
        	self.indoorCheck.isSelected = !self.indoorCheck.isSelected
        }
    }
    
    @IBAction func addEventButtonTapped(_ sender: UIBarButtonItem) {
        // Create an Event Store instance
        scheduleEvent(startHour: eventStartDatePicker.date, endHour: eventEndDatePicker.date, startafter: Date(), deadline: self.eventByDatePicker.date, hours: Int(hourTextField.text ?? "1")!)//temp
    }
    
    func scheduleEvent(startHour:Date, endHour:Date, startafter:Date, deadline:Date, hours:Int){
        if (coordinate == nil){
            print("Schedule no coord")
            let start = Calendar.current.component(.hour, from: startHour)
            let end = Calendar.current.component(.hour, from: endHour)
            if (self.indoorCheck.isSelected == true){
                self.scheduleIndoorEvent(startHour: start, endHour: end, startafter: startafter, deadline: deadline, hours: hours)
            }
            else{
                self.scheduleOutdoorEvent(startHour: start, endHour: end, startafter: startafter, deadline: deadline, hours: hours)
            }
        }
        else{
            print("new place")
            WeatherWrapper.GetWeather(input: ((self.coordinate?.latitude)!, (self.coordinate?.longitude)!)){weather, error in
                if error == true {
                    return
                }
                self.weather = weather
                let start = Calendar.current.component(.hour, from: startHour)
                let end = Calendar.current.component(.hour, from: endHour)
                if (self.indoorCheck.isSelected == true){
                    self.scheduleIndoorEvent(startHour: start, endHour: end, startafter: startafter, deadline: deadline, hours: hours)
                }
                else{
                    self.scheduleOutdoorEvent(startHour: start, endHour: end, startafter: startafter, deadline: deadline, hours: hours)
                }
            }
        }
    }
    
    func scheduleIndoorEvent(startHour:Int, endHour:Int,startafter:Date, deadline:Date, hours:Int){
        print("indoor")
        let eventstore = EKEventStore()
        
        let currentTime = Date()
        var timeslot:[Bool] = []
        for i in 0...48{
            timeslot.append(true)
            if ((Calendar.current.component(.hour, from:currentTime) + i) % 24 < startHour ||
                (Calendar.current.component(.hour, from:currentTime) + i) % 24 > endHour - 1){
                timeslot[i] = false
            }
            var temp = currentTime.addingTimeInterval(3600.0 * Double(i))
            temp = temp.addingTimeInterval(-60.0 * Double(Calendar.current.component(.minute, from:temp)))
            if (temp.compare(deadline) == ComparisonResult.orderedDescending){
                timeslot[i] = false
            }
        }
        
        //print(timeslot)
        if (startafter.compare(Date()) == ComparisonResult.orderedAscending){
            print("wrong")
            for _ in (Int(startafter.timeIntervalSince(Date())) / 3600)...48{
                //print(j)
                
            }
        }
        else {
            for i in 0...(Int(startafter.timeIntervalSince(Date())) / 3600){
                timeslot[i] = false
            }
            for _ in (Int(startafter.timeIntervalSince(Date())) / 3600)...48{
                //print(j)
            }
        }
        var selectCalendar:[EKCalendar] = []
        var identifier:String = ""
        for calendar in eventstore.calendars(for: EKEntityType.event){
            print(calendar.title)
            if (calendar.title != "US Holidays" && calendar.title != "Birthdays" && calendar.title != "Found in Mail" && calendar.title != "Holidays in United States"){
                //print("correct")
                selectCalendar.append(calendar)
            }
            if (calendar.title == "Calendar"){
                identifier = calendar.calendarIdentifier
            }
        }
        //print(selectCalendar)
        let eventsPredicate = eventstore.predicateForEvents(withStart: startafter, end: deadline, calendars:selectCalendar)
        var events = eventstore.events(matching: eventsPredicate)
        events.sort(){
            (e1: EKEvent, e2: EKEvent) -> Bool in
            return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
        }
        for event in events{
            let startindex = (Calendar.current.component(.day, from: event.startDate) - Calendar.current.component(.day, from: currentTime))
                * 24 +
                (Calendar.current.component(.hour, from: event.startDate) - Calendar.current.component(.hour, from: currentTime))
            let endindex = (Calendar.current.component(.day, from: event.endDate) - Calendar.current.component(.day, from: currentTime))
                * 24 +
                (Calendar.current.component(.hour, from: event.endDate) - Calendar.current.component(.hour, from: currentTime))
            print("index is")
            //print(startindex)
            if (endindex-1 >= startindex){
                for k in startindex...endindex-1{
                    timeslot[k] = false
                }
            }
            else{
                timeslot[startindex] = false
            }
        }
        print(timeslot)
        for i in 0...48{
            var found = true
            if (i+hours-1 > 48){
                break
            }
            for j in i...i+hours-1{
                if (timeslot[j] != true){
                    found = false
                }
            }
            if found {
                print(identifier)
                print(i)
                
                let newEvent = EKEvent(eventStore: eventstore)
                newEvent.calendar = eventstore.calendar(withIdentifier: identifier)
                newEvent.title = self.eventNameTextField?.text ?? "Some Event Name"
                var newstarttime = currentTime.addingTimeInterval(-60.0*Double(Calendar.current.component(.minute, from: currentTime)))
                newstarttime = newstarttime.addingTimeInterval(3600.0 * Double(i))
                var newendtime = currentTime.addingTimeInterval(-60.0*Double(Calendar.current.component(.minute, from: currentTime)))
                newendtime = newendtime.addingTimeInterval(3600.0 * Double((i+hours)))
                
                newEvent.startDate = newstarttime
                newEvent.endDate = newendtime
                
                if (self.coordinate != nil){
                    let location = CLLocation(latitude: (self.coordinate?.latitude) ?? 38.5601, longitude: self.coordinate?.longitude ?? -121.7773)
                    let structuredLocation = EKStructuredLocation(title: (locationCell.textLabel?.text)!)  // same title with ekEvent.location
                    structuredLocation.geoLocation = location
                    newEvent.structuredLocation = structuredLocation
                }
                do {
                    try eventstore.save(newEvent, span: .thisEvent, commit: true)
                    //delegate?.eventDidAdd()
                    
                    //self.dismiss(animated: true, completion: nil)
                } catch {
                    let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
                navigationController?.popViewController(animated: true)
                break
            }
        }
        let alert = UIAlertController(title: "No Available time slot found", message: "Consider extend your range", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    func scheduleOutdoorEvent(startHour:Int, endHour:Int, startafter:Date, deadline:Date, hours:Int){
        print("outdoor")
        
        let eventstore = EKEventStore()
        
        let currentTime = Date()
        var timeslot:[Bool] = []
        for i in 0...48{
            //print(weather?.hourlyWeather?.data[i].icon)
            if (weather?.hourlyWeather?.data[i].icon == "rain" || weather?.hourlyWeather?.data[i].icon == "snow" ||
                weather?.hourlyWeather?.data[i].icon == "sleet"){
                print("rain")
                timeslot.append(false)
            }
            else{
                print("not rain")
                timeslot.append(true)
            }
            if ((Calendar.current.component(.hour, from:currentTime) + i) % 24 < startHour ||
                (Calendar.current.component(.hour, from:currentTime) + i) % 24 > endHour - 1){
                timeslot[i] = false
            }
            var temp = currentTime.addingTimeInterval(3600.0 * Double(i))
            temp = temp.addingTimeInterval(-60.0 * Double(Calendar.current.component(.minute, from:temp)))
            if (temp.compare(deadline) == ComparisonResult.orderedDescending){
                timeslot[i] = false
            }
        }
        //print(timeslot)
        if (startafter.compare(Date()) == ComparisonResult.orderedAscending){
            print("wrong")
            for _ in (Int(startafter.timeIntervalSince(Date())) / 3600)...48{
                //print(j)
                
            }
        }
        else {
            for i in 0...(Int(startafter.timeIntervalSince(Date())) / 3600){
                timeslot[i] = false
            }
            for _ in (Int(startafter.timeIntervalSince(Date())) / 3600)...48{
                //print(j)
            }
        }
        var selectCalendar:[EKCalendar] = []
        var identifier:String = ""
        for calendar in eventstore.calendars(for: EKEntityType.event){
            print(calendar.title)
            if (calendar.title != "US Holidays" && calendar.title != "Birthdays" && calendar.title != "Found in Mail" && calendar.title != "Holidays in United States") {
                //print("correct")
                selectCalendar.append(calendar)
            }
            if (calendar.title == "Calendar"){
                identifier = calendar.calendarIdentifier
            }
        }
        //print(selectCalendar)
        let eventsPredicate = eventstore.predicateForEvents(withStart: startafter, end: deadline, calendars:selectCalendar)
        var events = eventstore.events(matching: eventsPredicate)
        events.sort(){
            (e1: EKEvent, e2: EKEvent) -> Bool in
            return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
        }
        for event in events{
            let startindex = (Calendar.current.component(.day, from: event.startDate) - Calendar.current.component(.day, from: currentTime))
                * 24 +
                (Calendar.current.component(.hour, from: event.startDate) - Calendar.current.component(.hour, from: currentTime))
            let endindex = (Calendar.current.component(.day, from: event.endDate) - Calendar.current.component(.day, from: currentTime))
                * 24 +
                (Calendar.current.component(.hour, from: event.endDate) - Calendar.current.component(.hour, from: currentTime))
            print("index is")
            //print(startindex)
            if (endindex-1 >= startindex){
                for k in startindex...endindex-1{
                    timeslot[k] = false
                }
            }
            else{
                timeslot[startindex] = false
            }
        }
        print(timeslot)
        for i in 0...48{
            var found = true
            if (i+hours-1 > 48){
                break
            }
            for j in i...i+hours-1{
                if (timeslot[j] != true){
                    found = false
                }
            }
            if found {
                print(identifier)
                print(i)
                
                let newEvent = EKEvent(eventStore: eventstore)
                newEvent.calendar = eventstore.calendar(withIdentifier: identifier)
                newEvent.title = self.eventNameTextField?.text ?? "Some Event Name"
                var newstarttime = currentTime.addingTimeInterval(-60.0*Double(Calendar.current.component(.minute, from: currentTime)))
                newstarttime = newstarttime.addingTimeInterval(3600.0 * Double(i))
                var newendtime = currentTime.addingTimeInterval(-60.0*Double(Calendar.current.component(.minute, from: currentTime)))
                newendtime = newendtime.addingTimeInterval(3600.0 * Double((i+hours)))
                
                newEvent.startDate = newstarttime
                newEvent.endDate = newendtime
                
                if (self.coordinate != nil){
                    let location = CLLocation(latitude: (self.coordinate?.latitude) ?? 38.5601, longitude: self.coordinate?.longitude ?? -121.7773)
                    let structuredLocation = EKStructuredLocation(title: (locationCell.textLabel?.text)!)  // same title with ekEvent.location
                    structuredLocation.geoLocation = location
                    newEvent.structuredLocation = structuredLocation
                }
                do {
                    try eventstore.save(newEvent, span: .thisEvent, commit: true)
                    //delegate?.eventDidAdd()
                    
                    //self.dismiss(animated: true, completion: nil)
                } catch {
                    let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
                navigationController?.popViewController(animated: true)
                break
            }
        }
        let alert = UIAlertController(title: "No Available time slot found", message: "Consider extend your range", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
}
    
