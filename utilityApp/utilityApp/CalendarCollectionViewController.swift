//
//  CalendarCollectionViewController.swift
//  utilityApp
//
//  Created by RENZE WANG on 11/28/18.
//  Copyright © 2018 the_world. All rights reserved.
//

import UIKit
import EventKit

private let reuseIdentifier = "Cell"
private let headerID = "calenderHeader"



class CalendarCell: UICollectionViewCell{
    let timeLabel = UILabel()
    let taskLabel = UILabel()
    let colorLabel = UILabel()
    let pad = UIView()
    let imageview = UIImageView(image: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func setAnchor(forView view: UIView, atTop top: CGFloat, fromLeft left: CGFloat, withHeight height: CGFloat, withWidth width: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: top * self.frame.height).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left * self.frame.width).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: width).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: height).isActive = true
    }
    
    func setupViews(){
        // set up time label info
        self.addSubview(timeLabel)
        let timeTop: CGFloat = 0
        let timeLeft: CGFloat = 0
        let timeWidth: CGFloat = 0.2
        let timeHeight: CGFloat = 1
        setAnchor(forView: timeLabel, atTop: timeTop, fromLeft: timeLeft, withHeight: timeHeight, withWidth: timeWidth)
        timeLabel.numberOfLines = 2
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: timeLabel.font.fontName, size: 15)
        //timeLabel.backgroundColor = .white
        timeLabel.backgroundColor = .clear
        
        // set up color label (color vertical line)
        self.addSubview(colorLabel)
        let colorTop: CGFloat = 0
        let colorLeft = timeLeft + timeWidth
        let colorHeigh: CGFloat = 1
        let colorWidth: CGFloat = 0.005
        setAnchor(forView: colorLabel, atTop: colorTop, fromLeft: colorLeft, withHeight: colorHeigh, withWidth: colorWidth)
        
        self.addSubview(pad)
        let padTop: CGFloat = 0
        let padLeft = timeLeft + timeWidth + 0.005
        let padHeight: CGFloat = 1
        let padWidth: CGFloat = 0.02
        setAnchor(forView: pad, atTop: padTop, fromLeft: padLeft, withHeight: padHeight, withWidth: padWidth)
        //pad.backgroundColor = .white
        pad.backgroundColor = .clear
        
        
        self.addSubview(taskLabel)
        let taskTop: CGFloat = 0
        let taskLeft = padLeft + padWidth
        let taskHeight: CGFloat = 1
        let taskWidth = 1 - taskLeft
        setAnchor(forView: taskLabel, atTop: taskTop, fromLeft: taskLeft, withHeight: taskHeight, withWidth: taskWidth)
        taskLabel.backgroundColor = .clear
        
        // set up image view for tips
        addSubview(imageview)
        let imageviewTop: CGFloat = 0.1
        let imageviewLeft: CGFloat = 0.95 - (40 / self.frame.width)
        let imageviewHeight: CGFloat = 40 / 50
        let imageviewWidth = 40 / self.frame.width
        setAnchor(forView: imageview, atTop: imageviewTop, fromLeft: imageviewLeft, withHeight: imageviewHeight, withWidth: imageviewWidth)
        //imageview.backgroundColor = .clear
        
        forTest()
        
    }
    func forTest(){
        //print("enter test")
        //timeLabel.backgroundColor = .orange
        //taskLabel.backgroundColor = .yellow
        pad.backgroundColor = taskLabel.backgroundColor
        
        timeLabel.text = "08:00 AM\n09:00 AM"
        taskLabel.text = "Beat Weiran"
        
        
    }
}

class CalendarHeaderCell: UICollectionViewCell{
    let dateLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setAnchor(forView view: UIView, atTop top: CGFloat, fromLeft left: CGFloat, withHeight height: CGFloat, withWidth width: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: top * self.frame.height).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left * self.frame.width).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: width).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: height).isActive = true
    }
    
    func setupViews(){
        addSubview(dateLabel)
        let dateTop: CGFloat = 0
        let dateLeft: CGFloat = 0.05
        let dateHeight: CGFloat = 1
        let dateWidth = 0.95 - dateLeft
        setAnchor(forView: dateLabel, atTop: dateTop, fromLeft: dateLeft, withHeight: dateHeight, withWidth: dateWidth)
        
        forTest()
    }
    
    func forTest(){
        dateLabel.text = "Today"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    
}

class CalendarCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate{

    let eventStore = EKEventStore()
    var calendars: [EKCalendar]?
    var totalDates:Int = 0
    var dates:[String] = []
    var eventLists:[[(startTime:String, endTime:String, content:String, calendar:String, startDate:Date, endDate:Date, location:CLLocationCoordinate2D?)]] = []
    var colorList: [String:UIColor] = [:]
    let colors:[UIColor] = [UIColor.brown, UIColor.green, UIColor.purple, UIColor.orange, UIColor.yellow, UIColor.red]
    // need set up before navigate into this view controller
    var weather: Weather? = nil
    var backgroundImage: UIImage? = nil
    
    // used for parameter of delete event
    var deleteIndexPath: IndexPath? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        //print("appear")
        checkCalendarAuthorizationStatus()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(weather?.curWeather?.curHumidity)
        //print("load")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        self.collectionView!.register(CalendarCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(CalendarHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        self.collectionView?.backgroundView = UIImageView(image: self.backgroundImage)
        self.collectionView?.backgroundView?.alpha = 0.4
        self.collectionView.backgroundColor = .white
        //self.collectionView.backgroundView?.backgroundColor = UIColor.clear
        
        let addTaskButton = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(tapOnAddTaskButton))
        addTaskButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name:"Helvetica", size: 30.0) as Any], for: .normal)
        
        self.navigationItem.rightBarButtonItem = addTaskButton
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(eventCellLongPressed))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.collectionView.addGestureRecognizer(lpgr)

        collectionViewConfig()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func eventCellLongPressed(gestureRecognizer: UILongPressGestureRecognizer){
        print("Long pressed")
        let deleteOptionMenu = UIAlertController(title: "", message: "Delete Event?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: deleteEventHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let p = gestureRecognizer.location(in: self.collectionView)
        let indexPath = collectionView.indexPathForItem(at: p)
        // set as parameter
        self.deleteIndexPath = indexPath
        
        deleteOptionMenu.addAction(deleteAction)
        deleteOptionMenu.addAction(cancelAction)
        self.present(deleteOptionMenu, animated: true, completion: nil)
    }
    
    func deleteEventHandler(delete: UIAlertAction) -> Void{
        // delete at self.deleteIndexPathhere
        //print("delete event at \(self.deleteIndexPath)")
        if let indexPath = self.deleteIndexPath{
            deleteEvent(cellForItemAt: indexPath)
            self.collectionView.reloadData()
        }
    }
    
    @objc func tapOnAddTaskButton(){
        // add task button action here
        print("add task")
        
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            // Things are in line with being able to show the calendars in the table view
            
            //let vc = AddCalendarEventViewController()
            //self.navigationController?.pushViewController(vc, animated: true)
            //let vc = storyboard.
            let storyboard = UIStoryboard(name: "Main", bundle: nil) //if bundle is nil the main bundle will be used
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "AddEvent") as! AddCalendarEventViewController
            
            secondViewController.weather = self.weather
            secondViewController.calendarCollection = self
            self.navigationController!.pushViewController(secondViewController, animated: true)
            self.collectionView.reloadData()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            requestAccessAlert()
        }
        
        //print(self.eventLists[1].count)
        //print(self.eventLists)
    }
    
    func collectionViewConfig(){
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionHeadersPinToVisibleBounds = true
        
        
        
    }
    
    
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            // Things are in line with being able to show the calendars in the table view
            loadCalendars()
            self.collectionView.reloadData()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            requestAccessAlert()
        }
    }
    
    

    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                DispatchQueue.main.async(execute: {
                    self.loadCalendars()
                    self.collectionView.reloadData()
                })
            } else {
                DispatchQueue.main.async(execute: {
                    self.requestAccessAlert()
                })
            }
        })
    }
    
    func requestAccessAlert() {
        let alert = UIAlertController(title: "Calendar required", message: "This app needs to load your calendar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Go to setting", style: .default, handler: { action in
            switch action.style{
            case .default:
                let openSettingsUrl = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(openSettingsUrl!, options: [:], completionHandler: nil)
                //UIApplication.shared.openURL(openSettingsUrl!)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func stringToDate(strdate:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE MMM dd yyyy hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateFormatter.date(from: strdate)!
        return date
    }
    
    func deleteEvent(cellForItemAt indexPath: IndexPath) {
        
        
        let eventsPredicate = eventStore.predicateForEvents(withStart: self.eventLists[indexPath.section][indexPath.row].startDate, end: self.eventLists[indexPath.section][indexPath.row].endDate, calendars: self.calendars)
        
        var events = eventStore.events(matching: eventsPredicate)
        events.sort(){
            (e1: EKEvent, e2: EKEvent) -> Bool in
            return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
        }
        for event in events{
            do {
                try eventStore.remove(event, span: .thisEvent)
                //delegate?.eventDidAdd()
                
                //self.dismiss(animated: true, completion: nil)
            } catch {
                let alert = UIAlertController(title: "Event could not delete", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        loadCalendars()
    }
    
    func loadCalendars() {
        self.totalDates = 0
        self.eventLists = []
        self.dates = []
        self.calendars = eventStore.calendars(for: EKEntityType.event)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        // Create start and end date NSDate instances to build a predicate for which events to select
        
        let startDate = dateFormatter.date(from: "2018-11-01")
        let endDate = dateFormatter.date(from: "2018-12-31")
        
        if let startDate = startDate, let endDate = endDate {
            
            // Use an event store instance to create and properly configure an NSPredicate
            let eventsPredicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: self.calendars)
            
            var events = eventStore.events(matching: eventsPredicate)
            events.sort(){
                (e1: EKEvent, e2: EKEvent) -> Bool in
                return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
            }
            //print(events.count)
            dateFormatter.dateFormat = "EE MMM dd yyyy hh:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            if events.count == 0{
                return
            }
            for i in 0...events.count-1 {
                let thisStartDate = String(dateFormatter.string(from: events[i].startDate).prefix(15))
                
                if self.dates.contains(thisStartDate) != true {
                    self.dates.append(thisStartDate)
                    self.totalDates = self.totalDates + 1
                    self.eventLists.append([])
                }
                let starthour = String(dateFormatter.string(from: events[i].startDate))
                //print(starthour)
                let endhour = String(dateFormatter.string(from: events[i].endDate))
                
                self.eventLists[self.totalDates-1].append((startTime: starthour, endhour, events[i].title, events[i].calendar.title, events[i].startDate, events[i].endDate, events[i].structuredLocation?.geoLocation?.coordinate))
                if self.colorList[events[i].calendar.title] == nil {
                    colorList[events[i].calendar.title] = colors[colorList.count % colors.count]
                    //print(self.colorList[events[i].calendar.title])
                }
            }
            
            //print(self.totalDates)
            //print(self.dates)
            //print(self.eventLists)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.totalDates
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //print("test")
        //print(eventLists[section])
        return eventLists[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CalendarCell
        cell.colorLabel.backgroundColor = colorList[self.eventLists[indexPath.section][indexPath.row].calendar]
        cell.timeLabel.text = self.eventLists[indexPath.section][indexPath.row].startTime.suffix(8) + "\n" +
            self.eventLists[indexPath.section][indexPath.row].endTime.suffix(8)
        cell.taskLabel.text = self.eventLists[indexPath.section][indexPath.row].content
        // Configure the cell
        
        //print(eventLists[indexPath.section][indexPath.row].calendar)
        //print(eventLists[indexPath.section][indexPath.row].content)
        //print(eventLists[indexPath.section][indexPath.row].endTime)
        //print(eventLists[indexPath.section][indexPath.row].startTime)
        
        //print("converting!")
        var useUmbrella = false
        let thisstartdate = stringToDate(strdate: eventLists[indexPath.section][indexPath.row].startTime)
        let thisenddate = stringToDate(strdate: eventLists[indexPath.section][indexPath.row].endTime)
        let currentdate = Date()
        if (thisenddate.timeIntervalSince(currentdate) < 0){
            //print("past")
        }
        else{
            //print(thisstartdate.timeIntervalSince(currentdate))
            if (thisstartdate.timeIntervalSince(currentdate) < 48.0*3600){
                //print("within")
                if (eventLists[indexPath.section][indexPath.row].location != nil){
                    WeatherWrapper.GetWeather(input: ((eventLists[indexPath.section][indexPath.row].location?.latitude)!, (eventLists[indexPath.section][indexPath.row].location?.longitude)!)){weather, error in
                        //let tempweather = self.weather
                        //self.weather = weather
                        
                        let startindex = (Int(thisstartdate.timeIntervalSince(currentdate)) / 3600) + 1
                        let endindex = Int(thisenddate.timeIntervalSince(currentdate)) / 3600 + 1
                        if (endindex-1 >= startindex){
                            for i in startindex...endindex-1{
                                //print(i)
                                if (weather?.hourlyWeather?.data[i].icon == "rain" || weather?.hourlyWeather?.data[i].icon == "snow" ||
                                    weather?.hourlyWeather?.data[i].icon == "sleet"){
                                    print("bad weather")
                                    useUmbrella = true
                                }
                            }
                        }
                        else{
                            if (weather?.hourlyWeather?.data[startindex].icon == "rain" || weather?.hourlyWeather?.data[startindex].icon == "snow" ||
                                weather?.hourlyWeather?.data[startindex].icon == "sleet"){
                                print("bad weather")
                                useUmbrella = true
                            }
                        }
                    }
                }
                else{
                    print("Davis")
                    let startindex = (Int(thisstartdate.timeIntervalSince(currentdate)) / 3600) + 1
                    let endindex = Int(thisenddate.timeIntervalSince(currentdate)) / 3600 + 1
                    if (endindex-1 >= startindex){
                        for i in startindex...endindex-1{
                            //print(i)
                            if (weather?.hourlyWeather?.data[i].icon == "rain" || weather?.hourlyWeather?.data[i].icon == "snow" ||
                                weather?.hourlyWeather?.data[i].icon == "sleet"){
                                print("bad weather")
                                useUmbrella = true
                            }
                        }
                    }
                    else{
                        if (weather?.hourlyWeather?.data[startindex].icon == "rain" || weather?.hourlyWeather?.data[startindex].icon == "snow" ||
                            weather?.hourlyWeather?.data[startindex].icon == "sleet"){
                            print("bad weather")
                            useUmbrella = true
                        }
                    }
                }
                //print(cell.timeLabel.text)
            }
        }
        
        if useUmbrella == true{
            //print("add umbrella")
            let image = UIImage(named: "umbrella")
            //print(image)
            cell.imageview.image = image
            cell.imageview.contentMode = .scaleToFill
            
        }else{
            cell.imageview.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! CalendarHeaderCell
        //calendars?[indexPath.section].
        
        cell.dateLabel.text = self.dates[indexPath.section]
        cell.backgroundColor = UIColor(red: 212/255, green: 224/255, blue: 254/255, alpha: 1)
        //cell.backgroundColor = .clear
        return cell
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
