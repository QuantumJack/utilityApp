//
//  TipCollectionViewController.swift
//  utilityApp
//
//  Created by RENZE WANG on 12/2/18.
//  Copyright © 2018 the_world. All rights reserved.
//

import UIKit


class TipViewController: UIViewController {
    
    let rainHeader = UILabel()
    var backgroundView = UIImageView()
    let rainTipLabel = UILabel()
    let tmptrLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // Do any additional setup after loading the view.
    }
    
    func setupViews(){
        
        self.backgroundView.image = UIImage(named: "rainy_background")
        self.view.addSubview(backgroundView)
        let backgroundTopLeft: CGFloat = 0
        let backgroundHeightWidth: CGFloat = 1
        setAnchor(forView: backgroundView, atTop: backgroundTopLeft, fromLeft: backgroundTopLeft, withHeight: backgroundHeightWidth, withWidth: backgroundHeightWidth)
        
        self.view.addSubview(rainHeader)
        let rainHeaderTop: CGFloat = 0.25
        let rainHeaderLeft: CGFloat = 0.1
        let rainHeaderHeight: CGFloat = 0.05
        let rainHeaderWidth: CGFloat = 0.9 - rainHeaderLeft
        setAnchor(forView: rainHeader, atTop: rainHeaderTop, fromLeft: rainHeaderLeft, withHeight: rainHeaderHeight, withWidth: rainHeaderWidth)
        
        // set up rainTipLabel
        self.view.addSubview(rainTipLabel)
        let rainTipTop = rainHeaderTop + rainHeaderHeight
        let rainTipLeft = rainHeaderLeft
        let rainTipHeight: CGFloat = 0.1
        let rainTipWidth: CGFloat = 0.9 - rainTipLeft
        setAnchor(forView: rainTipLabel, atTop: rainTipTop, fromLeft: rainTipLeft, withHeight: rainTipHeight, withWidth: rainTipWidth)
        
        // set up temperature label
        self.view.addSubview(tmptrLabel)
        let tmptrTop = rainTipTop + rainTipHeight
        let tmptrLeft = rainTipLeft
        let tmptrHeight: CGFloat = 0.1
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
        
        rainTipLabel.text = "Possibly rain in the afternoon, please bring your unbrella."
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
    
    // helper function to set up view position
    func setAnchor(forView view: UIView, atTop top: CGFloat, fromLeft left: CGFloat, withHeight height: CGFloat, withWidth width: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: top * self.view.frame.height).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: left * self.view.frame.width).isActive = true
        view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: width).isActive = true
        view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: height).isActive = true
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
