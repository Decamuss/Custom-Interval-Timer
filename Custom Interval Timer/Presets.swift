//
//  Presets.swift
//  Custom Interval Timer
//
//  Created by Rick Hsu on 8/17/22.
//

import UIKit
class Presets: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var presets = [PresetTimerModel]()
    var presetSelected: PresetTimerModel?
    var presetSelectedIndex: Int?

    @IBAction func didTapAdd()
    {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Preset"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Presets"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presets = PresetTimerService.getAllObjects
        presetSelected = PresetTimerService.presetSelected;
        tableView.reloadData()
    }
}

extension Presets: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            presets.remove(at: indexPath.row)
            if (presetSelectedIndex == indexPath.row) {
                PresetTimerService.removePresetSelected()
            }
            PresetTimerService.saveAllObjects(allObjects: presets)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = storyboard?.instantiateViewController(identifier: "description") as! DescriptionViewController
        vc.title = "New Preset"
        vc.preset = presets[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
    

extension Presets: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presets[indexPath.row].name
        
        if (presets[indexPath.row].timerId == presetSelected?.timerId) {
            cell.accessoryType = .checkmark
            presetSelectedIndex = indexPath.row
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}

