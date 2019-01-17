//
//  ViewController.swift
//  utilityApp
//
//  Created by RENZE WANG on 11/13/18.
//  Copyright © 2018 the_world. All rights reserved.
//

import UIKit

/* ----------- TipCell: Cell class for weather Tip -------- */
class TipCell: UICollectionViewCell{
    let rainHeader = UILabel()
    let rainTipLabel = UILabel()
    let tmptrLabel = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setFontColor(color: UIColor){
        rainHeader.textColor = color
        rainTipLabel.textColor = color
        tmptrLabel.textColor = color
        
    }
    
    func setAnchor(forView view: UIView, atTop top: CGFloat, fromLeft left: CGFloat, withHeight height: CGFloat, withWidth width: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: top * self.frame.height).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left * self.frame.width).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: width).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: height).isActive = true
    }
    
    func setupViews(){
        
        self.addSubview(rainHeader)
        let rainHeaderTop: CGFloat = 0.05
        let rainHeaderLeft: CGFloat = 0.1
        let rainHeaderHeight: CGFloat = 0.2
        let rainHeaderWidth: CGFloat = 0.9 - rainHeaderLeft
        setAnchor(forView: rainHeader, atTop: rainHeaderTop, fromLeft: rainHeaderLeft, withHeight: rainHeaderHeight, withWidth: rainHeaderWidth)
        
        // set up rainTipLabel
        self.addSubview(rainTipLabel)
        let rainTipTop = rainHeaderTop + rainHeaderHeight
        let rainTipLeft = rainHeaderLeft
        let rainTipHeight: CGFloat = 0.3
        let rainTipWidth: CGFloat = 0.9 - rainTipLeft
        setAnchor(forView: rainTipLabel, atTop: rainTipTop, fromLeft: rainTipLeft, withHeight: rainTipHeight, withWidth: rainTipWidth)
        
        // set up temperature label
        self.addSubview(tmptrLabel)
        let tmptrTop = rainTipTop + rainTipHeight
        let tmptrLeft = rainTipLeft
        let tmptrHeight: CGFloat = 0.4
        let tmptrWidth: CGFloat = 0.9 - tmptrLeft
        setAnchor(forView: tmptrLabel, atTop: tmptrTop, fromLeft: tmptrLeft, withHeight: tmptrHeight, withWidth: tmptrWidth)
        
        
        forTest()
    }
    
    func forTest(){
        rainHeader.text = "LOOKING AHEAD"
        rainHeader.textColor = UIColor.lightText
        rainHeader.font = UIFont(name: rainHeader.font.fontName, size: 25.0)
        rainHeader.font = UIFont.boldSystemFont(ofSize: rainHeader.font.pointSize)
        //rainHeader.backgroundColor = .orange
        
        rainTipLabel.text = "There is no rain, good weather!"
        rainTipLabel.textColor = .white
        rainTipLabel.font = UIFont(name: rainTipLabel.font.fontName, size: 20.0)
        //rainTipLabel.backgroundColor = .blue
        rainTipLabel.numberOfLines = 3
        
        tmptrLabel.text = "It is very cold, only 45° at 9 AM, please wear a coat."
        tmptrLabel.textColor = .white
        tmptrLabel.font = UIFont(name: rainTipLabel.font.fontName, size: 20.0)
        //tmptrLabel.backgroundColor = .purple
        tmptrLabel.numberOfLines = 3
    }
    
    
}


/* ----------- HeaderCell: Cell class for Weather Header -------- */

class HeaderCell: UICollectionViewCell {
    var temperatureLabel = UILabel()
    var locationLabel = UILabel()
    var dateLabel = UILabel()
    var weatherLabel = UILabel()
    var weatherIconImage = UIImageView()
    
    // extra navigation bar item in viewdidload
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundView = UIImageView()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func setFontColor(color: UIColor){
        temperatureLabel.textColor = color
        locationLabel.textColor = color
        dateLabel.textColor = color
        weatherLabel.textColor = color
        
    }
    
    func setAnchor(forView view: UIView, atTop top: CGFloat, fromLeft left: CGFloat, withHeight height: CGFloat, withWidth width: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: top * self.frame.height).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left * self.frame.width).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: width).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: height).isActive = true
    }
    
    func setupViews(){
        // set up temperature label position
        addSubview(temperatureLabel)
        let tmprTop: CGFloat = 0.25
        let tmprLeft: CGFloat = 0.1
        let tmprHeight: CGFloat = 0.3
        let tmprWidth: CGFloat = 0.5
        setAnchor(forView: temperatureLabel, atTop: tmprTop, fromLeft: tmprLeft, withHeight: tmprHeight, withWidth: tmprWidth)
        // set up temperature label font
        temperatureLabel.textColor = .white
        temperatureLabel.numberOfLines = 1
        temperatureLabel.font = UIFont(name: temperatureLabel.font.fontName, size: 50)
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: temperatureLabel.font.pointSize)
        
        // set up date label position
        addSubview(dateLabel)
        let dateTop: CGFloat = tmprTop + tmprHeight
        let dateLeft: CGFloat = tmprLeft
        let dateHeight: CGFloat = 0.1
        let dateWidth: CGFloat = 0.3
        setAnchor(forView: dateLabel, atTop: dateTop, fromLeft: dateLeft, withHeight: dateHeight, withWidth: dateWidth)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .left
        
        
        
        // set up location label position
        addSubview(locationLabel)
        let locTop = dateTop + dateHeight
        let locLeft = dateLeft
        let locHeight: CGFloat = 0.1
        let locWidth: CGFloat = 0.3
        setAnchor(forView: locationLabel, atTop: locTop, fromLeft: locLeft, withHeight: locHeight, withWidth: locWidth)
        // set up location label font
        locationLabel.textColor = .white
        locationLabel.numberOfLines = 1
        locationLabel.font = UIFont(name: temperatureLabel.font.fontName, size: 20)
        locationLabel.adjustsFontSizeToFitWidth = true
        locationLabel.textAlignment = .left
        
        // set up weather label
        addSubview(weatherLabel)
        let weatherTop = locTop + locHeight
        let weatherLeft = locLeft
        let weatherHeight: CGFloat = 0.1
        let weatherWidth: CGFloat = 0.5
        setAnchor(forView: weatherLabel, atTop: weatherTop, fromLeft: weatherLeft, withHeight: weatherHeight, withWidth: weatherWidth)
        weatherLabel.textColor = .white
        weatherLabel.textAlignment = .left
        weatherLabel.adjustsFontSizeToFitWidth = true
        
        // set up weather Icon image view
       
        addSubview(weatherIconImage)
        let weatherIconTop = tmprTop + 0.5 * tmprHeight
        let weatherIconLeft: CGFloat = 0.7
        let weatherIconHeight: CGFloat = 0.3
        let weatherIconWidth: CGFloat = weatherIconHeight * self.frame.height / self.frame.width
        setAnchor(forView: weatherIconImage, atTop: weatherIconTop, fromLeft: weatherIconLeft, withHeight: weatherIconHeight, withWidth: weatherIconWidth)
        weatherIconImage.image = UIImage(named: "rainy_icon")
        weatherIconImage.contentMode = .scaleToFill
        
        
        
        forTest()
    }
    
   
    
    func forTest(){
        /*
        dateLabel.backgroundColor = .red
        temperatureLabel.backgroundColor = .purple
        locationLabel.backgroundColor = .green
        weatherLabel.backgroundColor = .orange
        weatherIconImage.backgroundColor = .yellow
        */
        
        dateLabel.text = "Tomorrow"
        temperatureLabel.text = "50°F"
        locationLabel.text = "Davis"
        weatherLabel.text = "rainny"
        
    }
    
    /*
    func adjustFontSize(label: UILabel?) -> UIFont {
        var minFont: CGFloat = 18 // display min
        var maxFont: CGFloat = 67 // display max
        var fontSize: CGFloat = 0
        while(minFont <= maxFont){
            guard label?.text != nil else{
                break
            }
            
            fontSize = minFont + (maxFont - minFont) / 2
            if let labelText = label?.text {
                let text = labelText as NSString
                let labelHeight = label?.frame.size.height
                let strHeight = text.size(withAttributes: [NS])
                
            }
        }
    }*/
}

/* ----------- Normal weather detail cell -------- */

class WeatherCollectionViewCell: UICollectionViewCell {
    
    var attributeLabel: UILabel = UILabel()
    var detailLabel = UILabel()
    
    //this is called when a cell is dequeued
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setFontColor(color: UIColor){
        attributeLabel.textColor = color
        detailLabel.textColor = color
    }
    
    func setAnchor(forView view: UIView, atTop top: CGFloat, fromLeft left: CGFloat, withHeight height: CGFloat, withWidth width: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: top * self.frame.height).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: left * self.frame.width).isActive = true
        view.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: width).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: height).isActive = true
    }
    
    func setupViews(){
        addSubview(attributeLabel)
        let attrTop: CGFloat = 0
        let attrLeft: CGFloat = 0.1
        let attrHeight: CGFloat = 1
        let attrWidth: CGFloat = 0.5
        setAnchor(forView: attributeLabel, atTop: attrTop, fromLeft: attrLeft, withHeight: attrHeight, withWidth: attrWidth)
        attributeLabel.textAlignment = .left
        
        
        addSubview(detailLabel)
        let detailTop: CGFloat = 0
        let detailLeft: CGFloat = 0.4
        let detailHeight: CGFloat = 1
        let detailWidth: CGFloat = 0.5
        setAnchor(forView: detailLabel, atTop: detailTop, fromLeft: detailLeft, withHeight: detailHeight, withWidth: detailWidth)
        detailLabel.textAlignment = .right
        
        
        //fortest
        forTest()
    }
    
    func forTest(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}


class WeatherDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var weatherData: [WeatherDetail] = []
    let headerStr = "collectionHeader"
    let weatherCellStr = "weatherCellStr"
    let tipCellStr = "weatherTipStr"
    var fontColor = UIColor.white
    
    
    // need to be set before pushed into navigation view controller
    var dayWeather: SingleDayWeather? = nil
    // need to be set before pushed into navigation view controller
    var dayDescription: String? = nil
    // need to be set before pushed into navigation view controller
    var hourlyWeather: HourlyWeather? = nil
    
    // use rootController to get navigation controller
    var rootController: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let tipButton = UIBarButtonItem(title: "Weather Tips", style: .done, target: self, action: #selector(tapOnTipButton))
        //self.navigationItem.rightBarButtonItem = tipButton
        
        collectionViewConfig()
        //print("config finish")
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
        
        //for test purpose
        forTest()
    }
    
    
    func setupHeaderData(forHeader header: HeaderCell){
        if let temperatureLowStr = dayWeather?.temperatureLow, let temperatureHighStr = dayWeather?.temperatureHigh{
            let tempratureLowOpt = Float(temperatureLowStr)?.rounded()
            let tempratureHighOpt = Float(temperatureHighStr)?.rounded()
            if let temperatureLow = tempratureLowOpt, let temperatureHigh = tempratureHighOpt{
                header.temperatureLabel.text = "\(Int(temperatureLow)) - \(Int(temperatureHigh))°F"
            }
        }
        
        header.weatherLabel.text = dayWeather?.icon
        header.dateLabel.text = self.dayDescription
        if let icon = dayWeather?.icon, icon == "rain"{
            header.weatherIconImage.image = UIImage(named: "rain")
        }else if let icon = dayWeather?.icon, icon == "clear-day"{
            header.weatherIconImage.image = UIImage(named: "clear-day")
        }else{
            header.weatherIconImage.image = UIImage(named: "cloudy")
        }
    }
    
    
    @objc func tapOnTipButton(){
        let vc = TipViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    
    /* ------- collection view configuration ------*/
    func collectionViewConfig(){
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        //let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.sectionHeadersPinToVisibleBounds = true
        collectionView.backgroundColor = UIColor.clear
        
        
        let backgroundView = UIImageView()
        if let icon = dayWeather?.icon, icon == "rain"{
            backgroundView.image = UIImage(named: "rainy_background")
        }else if let icon = dayWeather?.icon, icon == "clear-day"{
            backgroundView.image = UIImage(named: "sunny_background")
        }else{
            backgroundView.image = UIImage(named: "cloudy_background")
        }
        backgroundView.contentMode = .scaleToFill
        //backgroundView.contentMode = .top
        collectionView.backgroundView = backgroundView
        //let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.sectionHeadersPinToVisibleBounds = true
        
        //backgroundImageView.clipsToBounds = true
        //self.weatherDetailCollectionView.backgroundView = self.backgroundImageView
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: weatherCellStr)
        collectionView.register(TipCell.self, forCellWithReuseIdentifier: tipCellStr)
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerStr)
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count + 1
    }
    
    func setupTipCellData(tipCell: TipCell){
        var dayIndex: Int? = nil
        if self.dayDescription == "Today"{
            dayIndex = 0
        }else{
            dayIndex = 1
        }
        
        //let date = Date()
        //let calendar = Calendar.current
        //let curhour = calendar.component(.hour, from: date)
        
        if let dayidx = dayIndex{
            if dayidx == 0{
               
                if let prob = dayWeather?.precipProbability, let proba = Float(prob), proba > 0.33{
                    tipCell.rainTipLabel.text = "It will rain today, please bring an umbrella"
                }
                
                if let tempLow = dayWeather?.temperatureLow, let low = Float(tempLow){
                    if low < 45{
                        tipCell.tmptrLabel.text = "The lowest temperature will be \(tempLow)°F, please wear a coat to keep warm."
                    }else{
                        tipCell.tmptrLabel.text = "The lowest temperature will be \(tempLow)°F. Not a very cold day!"
                    }
                }
                
            }else if dayidx == 1{
                if let prob = dayWeather?.precipProbability, let proba = Float(prob), proba > 0.33{
                    tipCell.rainTipLabel.text = "It will rain tomorrow, please bring an umbrella at that time."
                }
                
                if let tempLow = dayWeather?.temperatureLow, let low = Float(tempLow){
                    if low < 45{
                        tipCell.tmptrLabel.text = "The lowest temperature will be \(tempLow)°F, please wear a coat to keep warm tomorrow."
                    }else{
                        tipCell.tmptrLabel.text = "The lowest temperature will be \(tempLow)°F. Tomorrow is not a very cold day!"
                    }
                }
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item != 0 {
            let weather = self.weatherData[indexPath.item - 1]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: weatherCellStr, for: indexPath) as! WeatherCollectionViewCell
            cell.attributeLabel.text = weather.detailname
            cell.detailLabel.text = weather.content
            cell.attributeLabel.textColor = .white
            cell.detailLabel.textColor = .white
            cell.setFontColor(color: self.fontColor)
            return cell
        }else{
            // tip cell
            let tipCell = collectionView.dequeueReusableCell(withReuseIdentifier: tipCellStr, for: indexPath) as! TipCell
            
            setupTipCellData(tipCell: tipCell)
            tipCell.setFontColor(color: self.fontColor)
            
            return tipCell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerStr, for: indexPath) as! HeaderCell
        setupHeaderData(forHeader: header)
        header.setFontColor(color: self.fontColor)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0{
            return CGSize(width: view.frame.width, height: 200)
        }else{
            return CGSize(width: view.frame.width, height: 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width * 0.66)
    }
    
    func addData(key: String?, value: String?){
        if let k = key, let v = value {
            self.weatherData.append(WeatherDetail(withAttr: k, withContent: v))
        }
    }
    
    
    /* ----------- tests ---------- */
    func forTest(){
        self.weatherData.append(WeatherDetail())
        self.weatherData.append(WeatherDetail(withAttr: "HUMIDITY", withContent: "93%"))
        self.weatherData.append(WeatherDetail(withAttr: "WIND SPEED", withContent: "calm"))
        self.weatherData.append(WeatherDetail(withAttr: "WIND FROM", withContent: "N"))
        self.weatherData.append(WeatherDetail(withAttr: "DEW POINT", withContent: "54°"))
        self.weatherData.append(WeatherDetail(withAttr: "CLOUD COVER", withContent: "98%"))
        self.weatherData.append(WeatherDetail(withAttr: "PRESSURE", withContent: "30.0 IN"))
        self.weatherData.append(WeatherDetail(withAttr: "UI INDEX", withContent: "0 LOW"))
        self.weatherData.append(WeatherDetail(withAttr: "AIR QUALITY", withContent: "Moderate"))
        self.weatherData.append(WeatherDetail(withAttr: "VISIBILITY", withContent: "3 MI"))
        self.weatherData.append(WeatherDetail(withAttr: "RAIN ACCUM", withContent: "--"))
        
        self.weatherData = []
        
        if let list = self.dayWeather?.usefulList {
            for (key, value) in list{
                
                self.addData(key: key, value: value)
            }
        }  
    }


}



