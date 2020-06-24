//
//  Solve.swift
//  CubingTimer
//
//  Created by test on 24/06/2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class Solve: NSObject {
    var time: Double
    var date: Date
    var scramble: String
    
    init(time: Double, date: Date, scramble: String) {
        self.time = time
        self.date = date
        self.scramble = scramble
    }
}
