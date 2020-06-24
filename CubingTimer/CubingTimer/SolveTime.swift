//
//  SolveTime.swift
//  CubingTimer
//
//  Created by test on 24/06/2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class SolveTime: NSObject {
    var value: Double
    var asText: String

    init(value: Double) {
        self.value = value
        
        let seconds = value/100
        var text = "\(seconds)"
        if value.truncatingRemainder(dividingBy: 10.0) == 0 {
            text += "0"
        }
        asText = text
    }
}
