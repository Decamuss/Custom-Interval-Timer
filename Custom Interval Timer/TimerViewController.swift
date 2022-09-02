//
//  Timer.swift
//  Custom Interval Timer
//
//  Created by Rick Hsu on 8/17/22.
//

import UIKit
class TimerViewController: UIViewController {

    
    
    @IBOutlet var clock: UILabel!
    @IBOutlet var repCount: UILabel!
    @IBOutlet var name: UILabel!
    
    var interval = Global.interval
    var reps = Global.reps
    var rest = Global.rest
    var time = Global.interval
    var repCheck = Global.reps
    var presetName = Global.name
    var wasInterval: Bool = true
    
    var presetTimerSelected: PresetTimerModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interval = Global.interval
        reps = Global.reps
        rest = Global.rest
        presetName = Global.name
        
        presetTimerSelected = PresetTimerService.presetSelected;
        if let preset = presetTimerSelected {
            interval = preset.interval
            reps = preset.reps
            rest = preset.rest
            presetName = preset.name
            name.text = presetName
            time = preset.interval
            clock.text = String(interval)
            repCount.text = String(reps)
        } else {
            resetTimer()
        }
        resetTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        clock.text = String(interval)
        repCount.text = String(reps)
        resetTimer()
    }
    
    var timer = Timer()
        
    @IBAction func startButton(_ sender: Any) {
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.timerClass), userInfo: nil, repeats: true)
        
        
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
    }
    
    func resetTimer() {
        timer.invalidate()
        time = interval
        clock.text = String(time)
        repCount.text = String(reps)
        repCheck = reps
        wasInterval = true
        
        name.text = presetName
    }
    
    @IBAction func resetButton(_ sender: Any) {
        resetTimer()
    }
    
    @objc func timerClass()
    {
        time -= 1
        clock.text = String(time)
        
        
        //rest interval next
        if(time == 0 && repCheck != 1 && wasInterval)
        {
            time = rest + 1
            repCheck -= 1
            wasInterval = false
        }
        //normal interval next
        if (time == 0 && repCheck != 0 && wasInterval == false)
        {
            time = interval + 1
            wasInterval = true
        }
        if(time == 0 && repCheck == 1 && wasInterval)
        {
            timer.invalidate()
            repCheck -= 1
        }
        repCount.text = String(repCheck)
        
    }
    
}

