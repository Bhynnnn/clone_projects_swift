//
//  StopWatch.swift
//  [Project 2] StopWathces
//
//  Created by 강보현 on 2022/08/22.
//

import Foundation

class StopWatch: NSObject {
    var timer: Timer
    var counter: Double
    
    override init(){
        timer = Timer()
        counter = 0.0
    }
}
