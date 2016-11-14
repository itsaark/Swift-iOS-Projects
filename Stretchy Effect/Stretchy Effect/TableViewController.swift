//
//  TableViewController.swift
//  Stretchy Effect
//
//  Created by Arjun Kodur on 11/13/16.
//  Copyright © 2016 Arjun Kodur. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

//Header metrics
struct StretchyHeader {
    
    let headerHeight: CGFloat = 30
    let headerCut: CGFloat = 0
    
}

class TableViewController: UITableViewController {
    
    var images: [ImageModel]?
    
    var headerView: UIView!

    var newHeaderLayer: CAShapeLayer!
    
    //Update header view
    func updateView(){
        
        tableView.backgroundColor = UIColor.white
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(headerView)
        
        newHeaderLayer = CAShapeLayer()
        newHeaderLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = newHeaderLayer
        
        let newHeight = StretchyHeader().headerHeight - StretchyHeader().headerCut/2
        tableView.contentInset = UIEdgeInsetsMake(newHeight + 100, 0, 0, 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        setNewView()
    }
    
    //Set new dimensions
    func setNewView(){
        
        let newHeight = StretchyHeader().headerHeight - StretchyHeader().headerCut/2
        var getHeaderFrame =  CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: StretchyHeader().headerHeight)
        
        if tableView.contentOffset.y < newHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y + StretchyHeader().headerHeight/2
        }
        
        headerView.frame = getHeaderFrame
        let cutDirection = UIBezierPath()
        cutDirection.move(to: CGPoint(x: 0, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: 0))
        cutDirection.addLine(to: CGPoint(x: getHeaderFrame.width, y: getHeaderFrame.height))
        cutDirection.addLine(to: CGPoint(x: 0, y: getHeaderFrame.height - StretchyHeader().headerCut))
        newHeaderLayer.path = cutDirection.cgPath

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getImageData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setNewView()
        doTableRefresh()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 279
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return images?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.imageModel = images?[indexPath.row]
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getImageData()
        updateView()
    }
    
    //Get Image data using Alamofire
    func getImageData() {
        
        //Making request to Unsplash REST API
        Alamofire.request("https://unsplash.it/list").responseJSON { (response) in
            
            guard let value = response.result.value else{
                print("Coundn't fetch Json data")
                return
            }
            self.images = [ImageModel]()
            let json = JSON(value)
            for i in 15...25 {
                let imageModel = ImageModel()
                imageModel.author = json[i]["author"].stringValue
                let id = json[i]["id"].stringValue
                imageModel.urlString = "https://unsplash.it/750/750?image=" + id
                self.images?.append(imageModel)
                
            }
            self.doTableRefresh()
        }
    }
    
    //Table refresh
    func doTableRefresh()
    {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            return
        }
    }

}
