//
//  Presets.swift
//  Custom Interval Timer
//
//  Created by Rick Hsu on 8/17/22.
//

import UIKit
class Presets: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var presets = [String]()
    
    func updatePresets(){
        
        presets.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        for x in 0..<count{
            if let preset = UserDefaults().value(forKey: "preset_\(x+1)") as? String{
                presets.append(preset)
            }
            
            
        }
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd()
    {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Preset"
        vc.update = {
            DispatchQueue.main.async{
            self.updatePresets()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Presets"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        updatePresets()
    }


}

extension Presets: UITableViewDelegate {
    
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
    
        cell.textLabel?.text = presets[indexPath.row]
        
        return cell
    }
}

