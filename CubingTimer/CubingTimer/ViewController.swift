//
//  ViewController.swift
//  CubingTimer
//
//  Created by test on 23/06/2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var score: UILabel!
    @IBOutlet var scrambleLabel: UILabel!
    @IBOutlet var warmupButton: UIButton!
    @IBOutlet var buttonsView: UIView!
    var isSolving: Bool = false {
        didSet {
            if isSolving {
                solveStarted()
            } else {
                solveEnded()
            }
        }
    }
    var isReady: Bool = false {
        didSet {
            if isReady {
                view.backgroundColor = .systemOrange
                if !isWarmingUp {
                    score.text = "READY"
                }
            }
        }
    }
    var solveTimer = Timer()
    var duration: Double = 0.0
    var warmupDuration: Int = 0 {
        didSet {
            switch warmupDuration {
            case 0..<15:
                break
            case 15..<17:
                score.textColor = .systemRed
            default:
                score.textColor = .systemGray
            }
        }
    }
    var warmupActivated: Bool = false
    var isWarmingUp: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrambleLabel.text = randomScramble()
        score.text = "START"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSolving {
            isSolving = false
        } else {
            isReady = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isReady {
            //if theres "ready" on the screen
            if warmupActivated {
                if isWarmingUp {
                    //if there "preinspection" counting on the screen
                    solveTimer.invalidate()
                    isWarmingUp = false
                    //start solve
                    isSolving = true
                    isReady = false
                } else {
                    //start warmup
                    warmingUp()
                }
            } else {
                //start solve
                isSolving = true
                isReady = false
            }
        }
    }
    
    func solveStarted() {
        duration = 0.0
        score.text = String(duration)
        score.textColor = .label
        view.backgroundColor = .systemTeal
        scrambleLabel.isHidden = true
            
        buttonsView.isHidden = true
            
        solveTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                
            if let strongSelf = self {
                strongSelf.duration += 1.0
                strongSelf.score.text = String(strongSelf.textFromTime(strongSelf.duration))
            }
        }
    }
    
    func solveEnded() {
        view.backgroundColor = .systemBackground
        solveTimer.invalidate()
        scrambleLabel.isHidden = false
        scrambleLabel.text = randomScramble()
        
        buttonsView.isHidden = false
        
        switch warmupDuration {
        case 0..<15:
            break
        case 15..<17:
            score.text = textFromTime(duration+200.0)
        default:
            score.text = "DNF (\(textFromTime(duration)))"
        }
        
        print(score.text!)
    }
    
    func warmingUp() {
        view.backgroundColor = .systemBackground
        scrambleLabel.text = "PREINSPECTION"
        warmupDuration = 0
        score.text = String(warmupDuration)
        buttonsView.isHidden = true
        isWarmingUp = true
        
        solveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if let strongSelf = self {
                strongSelf.warmupDuration += 1
                strongSelf.score.text = String(strongSelf.warmupDuration)
            }
        }
    }
    
    @IBAction func warmupTapped(_ sender: Any) {
        if warmupButton.tintColor == score.textColor {
            warmupButton.tintColor = .systemOrange
            warmupActivated = true
        } else {
            warmupButton.tintColor = score.textColor
            warmupActivated = false
        }
    }
    
    func randomScramble() -> String {
        let moves: [String] = ["U","U'","D'","D","R","R'","L","L'","F","F'","B","B'","U2","F2","D2","R2","L2","B2"]
        var scrambleText = String()
        
        guard let firstMove = moves.randomElement() else { return "Error on generating a scramble" }
        var movesArray: [String] = [firstMove]
        
        for _ in 1...24{
            var move = String()
            
            repeat {
                guard let random = moves.randomElement() else { continue }
                move = random
            } while movesArray.last?.first == move.first
            
            movesArray.append(move)
            scrambleText += " \(move) "
        }
        
        return scrambleText
    }
    
    func textFromTime(_ time: Double) -> String {
        let seconds = time/100
        var text = "\(seconds)"
        if time.truncatingRemainder(dividingBy: 10.0) == 0 {
            text += "0"
        }
        return text
    }
}

