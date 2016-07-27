//
//  ShowFriendInfoTableViewController.swift
//  CleftCommunity
//  The table view that show a user's friend's profile.
//  Created by 宁伟晨 on 11/29/15.
//  Copyright © 2015 ShuaiFu. All rights reserved.
//

import UIKit

class ShowFriendInfoTableViewController: UITableViewController {

    var userInfo : UserInfo!
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profileInfo.count+1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch(indexPath.row) {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = "Photo"
            cell.detailTextLabel?.text = ""
            let iv = UIImageView(image: UIImage(data: userInfo.photo!))
            cell.contentView.addSubview(iv)
            iv.frame = CGRectMake(cell.contentView.frame.width - 100, 0, 90, 90)
            break;
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.nickname
            break;
            
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.ID
            break;
            
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.gender
            break;
            
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.age
            break;
            
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.region
            break;
            
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.email
            break;
            
        case 7:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.phone
            break;
            
        case 8:
            cell = tableView.dequeueReusableCellWithIdentifier("frienddetailcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = userInfo.motto
            break;
            
        // The cell that show whether user is following or not following this person
        case 9:
            cell = tableView.dequeueReusableCellWithIdentifier("followCell", forIndexPath: indexPath)
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.textLabel?.text = "Following"
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.detailTextLabel?.hidden = true
            cell.backgroundColor = UIColor.grayColor()
            break;
            
        default:
            break;
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
}
