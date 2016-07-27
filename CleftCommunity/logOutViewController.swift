//
//  logOutViewController.swift
//  CleftCommunity
//
//  Created by 陆明明 on 11/14/15.
//  Copyright © 2015 ShuaiFu. All rights reserved.
//
import UIKit
import Parse

class logOutViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    
    func showInBox(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ImageView.image = UIImage(named: "Weichen Ning.JPG")
        //NameLabel.text = PFUser.currentUser()?.username
        ImageView.layer.cornerRadius = ImageView.frame.height/2
        ImageView.layer.masksToBounds = true
        ImageView.image = UIImage(data: myInfo.photo)
        NameLabel.text = myInfo.nickname
    }
    
   
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        if PFUser.currentUser() == nil {
            //print("no user")
        }
        else{
            print(PFUser.currentUser()?.description)
        }
      
        
        self.dismissViewControllerAnimated(true, completion: nil)
        showInBox()
    }
    

}
