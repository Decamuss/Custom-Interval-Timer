//
//  EntryViewController.swift
//  Custom Interval Timer
//
//  Created by Rick Hsu on 8/21/22.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var field: UITextField!
    @IBOutlet weak var intervalTextField: UITextField!
    @IBOutlet weak var restTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    
    var presets: [PresetTimerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        field.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(savePreset))
        
        presets = PresetTimerService.getAllObjects;
    }
    
    @objc func savePreset()
    {
        guard let name = field.text, !name.isEmpty else {
            return
        }
        
        guard let intervalString = intervalTextField.text, let interval = Int(intervalString) else {
            return
        }
        
        guard let restString = restTextField.text, let rest = Int(restString) else {
            return
        }
        
        guard let repsString = repsTextField.text, let reps = Int(repsString) else {
            return
        }
                
        let presetTimerModel = PresetTimerModel(timerId: Int(NSDate().timeIntervalSince1970), interval: interval, rest: rest, reps: reps, name: name)
        
        presets.append(presetTimerModel);
        PresetTimerService.saveAllObjects(allObjects: presets);
        navigationController?.popViewController(animated: true)
    }
}
