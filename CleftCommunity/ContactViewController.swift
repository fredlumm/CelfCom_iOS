//
//  ContactViewController.swift
//  CleftCommunity
//
//  Created by ShuaiFu on 15/11/1.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate {

    var email: UILabel!
    var phone: UILabel!
    var location: UILabel!
    var website: UILabel!
    var emailText: UIButton!
    var phoneText: UIButton!
    var locationText: UILabel!
    var websiteText:UILabel!
    var facebookButton: UIButton!
    var twitterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        email = UILabel()
        email.frame = CGRectMake(10, 90, 150, 25)
        email.text = "E-mail:"
        email.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        self.view.addSubview(email)
        phone = UILabel()
        phone.frame = CGRectMake(10, 140, 150, 25)
        phone.text = "Phone Number:"
        phone.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        self.view.addSubview(phone)
        location = UILabel()
        location.frame = CGRectMake(10, 190, 150, 25)
        location.text = "Location:"
        location.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        self.view.addSubview(location)
        website = UILabel()
        website.frame = CGRectMake(10, 240, 150, 25)
        website.text = "Website:"
        website.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        self.view.addSubview(website)

        emailText = UIButton(frame: CGRectMake(160, 90, self.view.frame.width - 170, 25))
        emailText.setTitle("sf165@duke.edu", forState: UIControlState.Normal)
        emailText.setTitleColor(UIColor.blackColor(), forState: .Normal)
        emailText.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        //emailText.titleLabel?.textAlignment = .Right
        emailText.contentHorizontalAlignment = .Right
        //emailText.backgroundColor = UIColor.grayColor()
        emailText.addTarget(self, action: "SendEmail:", forControlEvents: .TouchUpInside)
        self.view.addSubview(emailText)
        
        phoneText = UIButton(frame: CGRectMake(160, 140, self.view.frame.width - 170, 25))
        phoneText.setTitle("9198088701", forState: UIControlState.Normal)
        phoneText.setTitleColor(UIColor.blackColor(), forState: .Normal)
        phoneText.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        phoneText.contentHorizontalAlignment = .Right
        //phoneText.backgroundColor = UIColor.grayColor()
        phoneText.addTarget(self, action: "SendMessage:", forControlEvents: .TouchUpInside)
        self.view.addSubview(phoneText)
        
        
        locationText = UILabel()
        locationText.frame = CGRectMake(160, 190, self.view.frame.width - 170, 25)
        locationText.text = "Durham"
        locationText.textAlignment = .Right
        locationText.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        self.view.addSubview(locationText)
        websiteText = UILabel()
        websiteText.frame = CGRectMake(160, 240, self.view.frame.width - 170, 25)
        websiteText.text = "www.ece.duke.edu"
        websiteText.textAlignment = .Right
        websiteText.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        self.view.addSubview(websiteText)
        
        facebookButton = UIButton(frame: CGRectMake(10, 300, 100, 100))
        facebookButton.setBackgroundImage(UIImage(named: "facebook.png"), forState: .Normal)
        facebookButton.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
        facebookButton.tag = 1
        self.view.addSubview(facebookButton)
        
        twitterButton = UIButton(frame: CGRectMake(self.view.frame.width - 110, 300, 100, 100))
        twitterButton.setBackgroundImage(UIImage(named: "twitter.png"), forState: .Normal)
        twitterButton.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
        twitterButton.tag = 2
        self.view.addSubview(twitterButton)
        
        
        
    }
    
    func buttonAction(sender: UIButton) {
        if (sender.tag == 1) {
            let urlString = "http://www.facebook.com"
            let url = NSURL(string: urlString)
            UIApplication.sharedApplication().openURL(url!)
        }
        if (sender.tag == 2) {
            let urlString = "http://www.twitter.com"
            let url = NSURL(string: urlString)
            UIApplication.sharedApplication().openURL(url!)
        }

    }
    
    func SendEmail(sender: UIButton){
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([(emailText.titleLabel?.text)!])            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
        
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func SendMessage(sender: UIButton) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "Enter a message";
        messageVC.recipients = [(phoneText.titleLabel?.text)!]
        
        messageVC.messageComposeDelegate = self;
        
        self.presentViewController(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.rawValue:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.rawValue:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    
    
    // MARK: MFMailComposeViewControllerDelegate

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
