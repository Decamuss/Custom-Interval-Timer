//
//  DescriptionViewController.swift
//  Custom Interval Timer
//
//  Created by Rick Hsu on 8/21/22.
//

import UIKit

class DescriptionViewController: UIViewController {

    
    @IBOutlet var label: UILabel!
    
    var preset: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = preset
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deletePreset))
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func selectPreset(_ sender: Any) {
        
    }
    
    
    
    @objc func deletePreset(){
        
  //      let newCount = count - 1
  //      UserDefaults().setValue(newCount, forKey: "count")
  //      UserDefaults().setValue(nil, forKey: "preset_\(currentPosition)")
        
        
    }

}
