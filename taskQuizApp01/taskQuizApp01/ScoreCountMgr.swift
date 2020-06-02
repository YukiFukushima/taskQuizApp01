//
//  ScoreCountMgr.swift
//  taskQuizApp01
//
//  Created by 福島悠樹 on 2020/05/31.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import Foundation
import UIKit

protocol TimeCounterDelegate:class {
    func getQuestionNumber() -> Int
    func getquestionTimeCounter() -> Int
}

class ScoreCountMgr {
    static let sharedInstance = ScoreCountMgr()
    
    var totalTimeCounter:Int = 0
    var questionTimeCounter:[Int] = [0, 0, 0]
    
    weak var delegate:TimeCounterDelegate?
    
    func addScore(){
        if let qustionNumber=self.delegate?.getQuestionNumber(){
            if let timeCounter=self.delegate?.getquestionTimeCounter(){
                self.questionTimeCounter[qustionNumber] = timeCounter
                self.totalTimeCounter += timeCounter
            }else{
                self.questionTimeCounter[qustionNumber]=0               /* ばかよけ */
            }
        }
    }
}		

protocol TimerDelegate:class {
    func getTimeCounter()->Int
    func getMinuteInstance()->UILabel!
    func getSecondInstance()->UILabel!
    func getMsInstance()->UILabel!
}

class TimerMgr{
    static let sharedInstance = TimerMgr()
    
    var counterMinutes:Int = 0
    var counterSecond:Int = 0
    var counterMs:Int = 0
    var hour_check:Int = 0
    
    weak var delegate:TimerDelegate?
    
    func printTime(){
        if let minutePrintInstance=delegate?.getMinuteInstance(){
            if let secondPrintInstance=delegate?.getSecondInstance(){
                if let msPrintInstance=delegate?.getMsInstance(){
                    if let counter=delegate?.getTimeCounter(){
                        self.counterMs = counter % 100
                        self.counterSecond = counter / 100
                        self.counterSecond %= 60
                        
                        self.counterMinutes = counter / 6000
                        self.hour_check = self.counterMinutes / 60
                        if self.hour_check>=1 {
                            self.counterMinutes = 99     /* Errの意味で99 */
                        }
                        
                        /*
                        let fontSize: CGFloat = 38.0
                        minutePrintInstance.font = .monospacedSystemFont(ofSize: fontSize, weight: .regular)
                        secondPrintInstance.font = .monospacedSystemFont(ofSize: fontSize, weight: .regular)
                        */
                        
                        // 文字列を2桁固定の数字でLabelに反映
                        msPrintInstance.text = String(format: "%02d", self.counterMs)
                        secondPrintInstance.text = String(format: "%02d", self.counterSecond)
                        minutePrintInstance.text = String(format: "%02d", self.counterMinutes)
                        
                        /*
                        msPrintInstance.text = String(self.counterMs)
                        secondPrintInstance.text = String(self.counterSecond)
                        minutePrintInstance.text = String(self.counterMinutes)
                        */
                    }
                }
            }
        }
    }
}
