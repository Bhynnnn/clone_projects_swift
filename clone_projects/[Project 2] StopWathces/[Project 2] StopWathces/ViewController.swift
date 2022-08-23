//
//  ViewController.swift
//  [Project 2] StopWathces
//
//  Created by 강보현 on 2022/08/09.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    let mainStopwatch: StopWatch = StopWatch()
    let lapStopwatch: StopWatch = StopWatch()
    
    var laps:[String] = []
    var isPlay: Bool = false
    
    
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let initCircleButton: (UIButton) -> Void = { button in
            button.layer.cornerRadius = 0.2 * button.bounds.size.width
          button.backgroundColor = UIColor.white
        }
        
        lapButton.isEnabled = false
        
        initCircleButton(startButton)
        initCircleButton(lapButton)
        
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
        
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
      return UIStatusBarStyle.lightContent
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
      return UIInterfaceOrientationMask.portrait
    }
    
    @IBAction func playPauseTimer(_sender : AnyObject){
        lapButton.isEnabled = true
        
        changeButton(lapButton, title: "Lap", titleColor: UIColor.black)
        
        if !isPlay {
            unowned let weakSelf = self
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            changeButton(startButton, title: "Stop", titleColor: UIColor.red)
            
        }
        else{
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(startButton, title: "Start", titleColor: UIColor.green)
            changeButton(lapButton, title: "Reset", titleColor: UIColor.black)

        }
    }

    

    @IBAction func lapResetTimer(_sender: AnyObject){
        
        if !isPlay {
            restMainTimer()
            resetLapTimer()
            changeButton(lapButton, title: "Lap", titleColor: UIColor.lightGray)
            lapButton.isEnabled = false
        }
        else{
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
            }
            lapsTableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self

            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
        }
        
    }
    
    func changeButton(_ button:UIButton , title: String, titleColor: UIColor){
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    func resetLapTimer(){
        resetTImer(lapStopwatch, label: lapTimerLabel)
    }
    
    func restMainTimer(){
        resetTImer(mainStopwatch, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    func resetTImer(_ stopwatch: StopWatch, label:UILabel){
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc func updateMainTimer(){
        updateTimer(mainStopwatch, label: timerLabel)
    }
    
    @objc func updateLapTimer(){
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    func updateTimer(_ stopwatch: StopWatch, label: UILabel){
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\(Int(stopwatch.counter / 60))"
        if Int(stopwatch.counter / 60 ) < 10 {
            minutes = "0\(Int(stopwatch.counter / 60))"
        }
        var seconds: String = String(format: "%.2f", stopwatch.counter.truncatingRemainder(dividingBy: 60))
        
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
    
        label.text = minutes + ":" + seconds
    
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "lapCell"
        
        
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let labelNum = cell.viewWithTag(11) as? UILabel {
            labelNum.text = "Lap\(laps.count - (indexPath as NSIndexPath).row)"
        }
        if let labelTimer = cell.viewWithTag(12) as? UILabel {
            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        }
    
        return cell

    }
}

fileprivate extension Selector{
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
