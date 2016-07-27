//
//  QATableViewController.swift
//  CleftCommunity
//  The table view that show all the questions and answers
//  Created by ShuaiFu on 15/11/1.
//  Copyright © 2015年 ShuaiFu. All rights reserved.
//

import UIKit

class QATableViewController: UITableViewController {
    
    let cellID = "cell"
    var selectedIndexPath : NSIndexPath?
    
    // MARK: - View Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hard code questions and answers
        let q1 = Q_A()
        q1.Ques = "What is cleft lip?"
        q1.Ans = "A cleft lip is a physical split or separation of the two sides of the upper lip and appears as a narrow opening or gap in the skin of the upper lip. This separation often extends beyond the base of the nose and includes the bones of the upper jaw and/or upper gum."
        let q2 = Q_A()
        q2.Ques = "What is cleft palate?"
        q2.Ans = "A cleft palate is a split or opening in the roof of the mouth. A cleft palate can involve the hard palate (the bony front portion of the roof of the mouth), and/or the soft palate (the soft back portion of the roof of the mouth)."
        let q3 = Q_A()
        q3.Ques = "Who Gets Cleft Lip and Cleft Palate?"
        q3.Ans = "Cleft lip, with or without cleft palate, affects one in 700 babies annually, and is the fourth most common birth defect in the U.S. Clefts occur more often in children of Asian, Latino, or Native American descent. Compared with girls, twice as many boys have a cleft lip, both with and without a cleft palate. However, compared with boys, twice as many girls have cleft palate without a cleft lip."
        let q4 = Q_A()
        q4.Ques = "What Causes a Cleft Lip and Cleft Palate?"
        q4.Ans = "In most cases, the cause of cleft lip and cleft palate is unknown. These conditions cannot be prevented. Most scientists believe clefts are due to a combination of genetic and environmental factors. There appears to be a greater chance of clefting in a newborn if a sibling, parent, or relative has had the problem.\n\nAnother potential cause may be related to a medication a mother may have taken during her pregnancy. Some drugs may cause cleft lip and cleft palate. Among them: anti-seizure/anticonvulsant drugs, acne drugs containing Accutane, and methotrexate, a drug commonly used for treating cancer, arthritis, and psoriasis."
        let q5 = Q_A()
        q5.Ques = "How Are Cleft Lip and Cleft Palate Diagnosed?"
        q5.Ans = "Because clefting causes very obvious physical changes, a cleft lip or cleft palate is easy to diagnose. Prenatal ultrasound can sometimes determine if a cleft exists in an unborn child. If the clefting has not been detected in an ultrasound prior to the baby's birth, a physical exam of the mouth, nose, and palate confirms the presence of cleft lip or cleft palate after a child's birth. Sometimes diagnostic testing may be conducted to determine or rule out the presence of other abnormalities."
        let q6 = Q_A()
        q6.Ques = "What Problems Are Associated With Cleft Lip and/or Palate?"
        q6.Ans = "Eating problems.\nWith a separation or opening in the palate, food and liquids can pass from the mouth back through the nose. Fortunately, specially designed baby bottles and nipples that help keep fluids flowing downward toward the stomach are available. Children with a cleft palate may need to wear a man-made palate to help them eat properly and ensure that they are receiving adequate nutrition until surgical treatment is provided.\n\nEar infections/hearing loss.\nChildren with cleft palate are at increased risk of ear infections since they are more prone to fluid build-up in the middle ear. If left untreated, ear infections can cause hearing loss. To prevent this from happening, children with cleft palate usually need special tubes placed in the eardrums to aid fluid drainage, and their hearing needs to be checked once a year.\n\nSpeech problems.\nChildren with cleft lip or cleft palate may also have trouble speaking. These children's voices don't carry well, the voice may take on a nasal sound, and the speech may be difficult to understand. Not all children have these problems and surgery may fix these problems entirely for some. For others, a special doctor, called speech pathologist, will work with the child to resolve speech difficulties."
        let q7 = Q_A()
        q7.Ques = "What’s the Treatment for Cleft Lip and Cleft Palate?"
        q7.Ans = "A cleft lip may require one or two surgeries depending on the extent of the repair needed. The initial surgery is usually performed by the time a baby is 3 months old.\n\nRepair of a cleft palate often requires multiple surgeries over the course of 18 years. The first surgery to repair the palate usually occurs when the baby is between 6 and 12 months old. The initial surgery creates a functional palate, reduces the chances that fluid will develop in the middle ears, and aids in the proper development of the teeth and facial bones.\n\nChildren with a cleft palate may also need a bone graft when they are about 8 years old to fill in the upper gum line so that it can support permanent teeth and stabilize the upper jaw. About 20% of children with a cleft palate require further surgeries to help improve their speech.Once the permanent teeth grow in, braces are often needed to straighten the teeth.\n\nAdditional surgeries may be performed to improve the appearance of the lip and nose, close openings between the mouth and nose, help breathing, and stabilize and realign the jaw. Final repairs of the scars left by the initial surgery will probably not be performed until adolescence, when the facial structure is more fully developed."
        let q8 = Q_A()
        q8.Ques = "What Is the Outlook for Children With Cleft Lip and/or Cleft Palate?"
        q8.Ans = "Although treatment for a cleft lip and/or cleft palate may extend over several years and require several surgeries depending upon the involvement, most children affected by this condition can achieve normal appearance, speech, and eating."
        qas.append(q1)
        qas.append(q2)
        qas.append(q3)
        qas.append(q4)
        qas.append(q5)
        qas.append(q6)
        qas.append(q7)
        qas.append(q8)
        self.tableView.tableFooterView = UIView()
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
        return qas.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath)
        
        // Configure the cell...
        // Design the sturcture of new cell
        if cell.viewWithTag(1) == nil {
            let titleLab = UILabel()
            titleLab.tag = 1
            cell.contentView.addSubview(titleLab)
            let answerText = UITextView()
            answerText.tag = 2
            cell.contentView.addSubview(answerText)
            titleLab.frame = CGRectMake(15, 0, cell.contentView.frame.width - 20, 45)
            answerText.frame = CGRectMake(10, 45, cell.contentView.frame.width - 20, 115)
        }
        
        // Assign value for each cell
        let titleLab = cell.viewWithTag(1) as! UILabel
        titleLab.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        titleLab.numberOfLines = 2
        titleLab.text = qas[indexPath.row].Ques
        let answerText = cell.viewWithTag(2) as! UITextView
        answerText.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
        answerText.editable = false
        answerText.text = qas[indexPath.row].Ans
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Expand a cell when it is pressed and collapse when being pressed again
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return 160
        } else {
            return 45
        }
    }
}
