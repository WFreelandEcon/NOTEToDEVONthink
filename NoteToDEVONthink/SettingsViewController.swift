//
//  SettingsViewController.swift
//  NoteToDEVONthink
//
//  Created by Adam Fallon on 28/04/2018.
//  Copyright © 2018 Adam Fallon. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    @IBOutlet weak var tableView: UITableView!    
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    @IBAction func changeToDarkTheme() {
        Themer.sharedInstance.theme = Themer.sharedInstance.Dark()
    }
    
    @IBAction func changeToLightTheme() {
        Themer.sharedInstance.theme = Themer.sharedInstance.Light()
    }
    
    @IBAction func createCustomTheme() {
        // TODO: Implement this screen
    }
    
    @IBAction func createCustomTemplate() {
        // TODO: Implement this screen
    }
    
    @IBAction func addTemplate() {
        
    }
    
    @IBAction func closeSettings() {
        self.navigationController?.popViewController(animated: true)
    }
}
