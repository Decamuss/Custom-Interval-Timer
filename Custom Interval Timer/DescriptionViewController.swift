//
//  DescriptionViewController.swift
//  Custom Interval Timer
//
//  Created by Rick Hsu on 8/21/22.
//

import UIKit

class DescriptionViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    
    var preset: PresetTimerModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let preset = preset {
            nameLabel.text = preset.name
            intervalLabel.text = String(describing: preset.interval)
            restLabel.text = String(describing: preset.rest)
            repsLabel.text = String(describing: preset.reps)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deletePreset))
    }
    
    
    @IBAction func selectPreset(_ sender: Any) {
        PresetTimerService.savePresetSelected(preset: preset ?? PresetTimerModel(timerId: Int(NSDate().timeIntervalSince1970), interval: Global.interval, rest: Global.rest, reps: Global.reps, name: Global.name))
    }
    
    @objc func deletePreset(){
        if let selected = PresetTimerService.presetSelected {
            if (selected.timerId == preset?.timerId) {
                PresetTimerService.removePresetSelected()
            }
        }
        
        var presets = PresetTimerService.getAllObjects;
        presets = presets.filter({$0.timerId != preset?.timerId })
        PresetTimerService.saveAllObjects(allObjects: presets)
        self.navigationController?.popViewController(animated: true)
    }

}
