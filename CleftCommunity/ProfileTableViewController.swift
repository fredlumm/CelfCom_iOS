//
//  ProfileTableViewController.swift
//  CleftCommunity
//  The table view that show user's profile.
//  Created by ShuaiFu on 15/11/1.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit

var profileInfo = ["Profile Photo", "Name", "Community ID", "Gender", "Age", "Region", "E-mail", "Phone", "Motto"]

class ProfileTableViewController: UITableViewController {
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profileInfo.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("profileInfoCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        cell.textLabel?.text = profileInfo[indexPath.row]
        
        if(indexPath.row == 0){
            cell.detailTextLabel?.text = ""
            let iv = UIImageView(image: UIImage(data: myInfo.photo!))
            cell.contentView.addSubview(iv)
            iv.frame = CGRectMake(cell.contentView.frame.width - 90, 0, 90, 90)
        }
        else if(indexPath.row == 1){
            cell.detailTextLabel?.text = myInfo.nickname
        }
        else if(indexPath.row == 2){
            cell.detailTextLabel?.text = myInfo.ID
        }
        else if(indexPath.row == 3){
            cell.detailTextLabel?.text = myInfo.gender
        }
        else if(indexPath.row == 4){
            cell.detailTextLabel?.text = myInfo.age
        }
        else if(indexPath.row == 5){
            cell.detailTextLabel?.text = myInfo.region
        }
        else if(indexPath.row == 6){
            cell.detailTextLabel?.text = myInfo.email
        }
        else if(indexPath.row == 7){
            cell.detailTextLabel?.text = myInfo.phone
        }
        else if(indexPath.row == 8){
            cell.detailTextLabel?.text = myInfo.motto
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 90
        }
        else{
            return self.view.frame.height*0.07
        }
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditInfo" {
            if let destination = segue.destinationViewController as? EditInfoViewController {
                if let proIndex = tableView.indexPathForSelectedRow?.row {
                    destination.selectItem = profileInfo[proIndex]
                    destination.navigationItem.title = profileInfo[proIndex]
                }
                destination.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if(tableView.indexPathForSelectedRow?.row == 2 || tableView.indexPathForSelectedRow?.row == 6){
            return false
        }
        else{
            return true
        }
    }
}
