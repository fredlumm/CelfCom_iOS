//
//  ComProfileTableViewController.swift
//  CleftCommunity
//  The table view that link from each comment to show comment author's profile.
//  Created by ShuaiFu on 15/12/3.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import Parse

class ComProfileTableViewController: UITableViewController {
    
    var friend = UserInfo()
    var isfriend: Bool = false

    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        //Judge if the user is your friend
        for item in friends{
            if(item.ID == friend.ID){
                isfriend = true
                break
            }
        }
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
        return profileInfo.count+1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...
        var cell: UITableViewCell!
        switch(indexPath.row) {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = "Photo"
            cell.detailTextLabel?.text = ""
            let iv = UIImageView(image: UIImage(data: friend.photo!))
            cell.contentView.addSubview(iv)
            iv.frame = CGRectMake(cell.contentView.frame.width - 100, 0, 90, 90)
            break;
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.nickname
            break;
            
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.ID
            break;
            
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.gender
            break;
            
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.age
            break;
            
        case 5:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.region
            break;
            
        case 6:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.email
            break;
            
        case 7:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.phone
            break;
            
        case 8:
            cell = tableView.dequeueReusableCellWithIdentifier("friendcell", forIndexPath: indexPath)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell.selectionStyle = .None
            cell.textLabel?.text = profileInfo[indexPath.row]
            cell.detailTextLabel?.text = friend.motto
            break;
            
        // The cell that show whether user is following or not following this person
        case 9:
            cell = tableView.dequeueReusableCellWithIdentifier("followCell", forIndexPath: indexPath)
            if(isfriend == false){
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
                cell.textLabel?.text = "+Follow"
                cell.textLabel?.backgroundColor = UIColor(red: 100/255.0, green: 149/255.0, blue: 237/255.0, alpha: 0.3)
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                cell.detailTextLabel?.hidden = true
                cell.backgroundColor = UIColor(red: 100/255.0, green: 149/255.0, blue: 237/255.0, alpha: 0.3)
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
                cell.textLabel?.text = "Following"
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                cell.detailTextLabel?.hidden = true
                cell.backgroundColor = UIColor.grayColor()
            }
            break;
            
        default:
            break;
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        if(indexPath.row == profileInfo.count){
            cell!.accessoryType = UITableViewCellAccessoryType.None
            cell!.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
            cell!.textLabel?.text = "Following"
            cell!.textLabel?.backgroundColor = UIColor.grayColor()
            cell!.textLabel?.textAlignment = NSTextAlignment.Center
            cell!.detailTextLabel?.hidden = true
            cell!.backgroundColor = UIColor.grayColor()
            
            if(isfriend == false){
                //update friends list
                friends.append(friend)
                pushtoparse()
                isfriend = true
                
                let alert = UIAlertController(title: "Saved", message: "You are now following this user.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default){
                    (action: UIAlertAction) -> Void in
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 90
        }
        else{
            return self.view.frame.height*0.07
        }
    }
    
    //Upload that a new friend is now being followed
    func pushtoparse(){
        let query = PFQuery(className:"UserInfo")
        query.whereKey("ID", equalTo:myInfo.ID)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // Do something with the found objects
                for object in objects! {
                    var arr = object["friends"] as! Array<String>
                    arr.append(self.friend.ID)
                    object["friends"] = arr
                    object.saveInBackground()
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
    }
}
