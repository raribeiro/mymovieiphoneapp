//
//  SetViewController.swift
//  MyMovie
//
//  Created by Rodnei Albuquerque on 19/03/23.
//

import UIKit

class SetViewController: UIViewController {

    
    @IBOutlet weak var playSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playSwitch.isOn = UserDefaults.standard.bool(forKey: "play")
    }
    
    @IBAction func playChange(_ sender: Any) {
        
        UserDefaults.standard.set(playSwitch.isOn, forKey: "play")
        
    }
}
