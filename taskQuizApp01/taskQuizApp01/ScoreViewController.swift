//
//  ScoreViewController.swift
//  taskQuizApp01
//
//  Created by 福島悠樹 on 2020/05/30.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, TimerDelegate {

    @IBOutlet weak var MinutesCounter: UILabel!
    @IBOutlet weak var secondCounter: UILabel!
    @IBOutlet weak var msCounter: UILabel!
    @IBOutlet weak var finalResultComment: UILabel!
    var counterMinutes:Int = 0
    var counterSecond:Int = 0
    
    /* デリゲート(TimerDelegate)メソッド群Call */
    func getTimeCounter()->Int{
        return ScoreCountMgr.sharedInstance.totalTimeCounter
    }
    func getMinuteInstance()->UILabel!{
        return MinutesCounter
    }
    func getSecondInstance()->UILabel!{
        return secondCounter
    }
    func getMsInstance()->UILabel!{
        return msCounter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimerMgr.sharedInstance.delegate = self
        printFinalResult()
        printFinalComment()

        // Do any additional setup after loading the view.
    }
    
    /* 最終時間の表示 */
    func printFinalResult(){
        TimerMgr.sharedInstance.printTime()
    }
    /* 最終判定の表示 */
    func printFinalComment(){
        counterMinutes = TimerMgr.sharedInstance.counterMinutes
        counterSecond = TimerMgr.sharedInstance.counterSecond
        if counterMinutes > 0 {
            finalResultComment.text = "Googleで調べて、チャレンジしてみてね"
        }else{
            if counterSecond < 31{
                finalResultComment.text = "達人です！"
            }else if counterSecond > 30
            &&       counterSecond < 61 {
                finalResultComment.text = "普通です"
            }else{
                finalResultComment.text = "Googleで調べて、チャレンジしてみてね"
            }
        }
    }
    
    @IBAction func tappedStartView(_ sender: Any) {
        /* ScoreCountMgr変数初期化 */
        ScoreCountMgr.sharedInstance.totalTimeCounter = 0
        for i in 0 ..< ScoreCountMgr.sharedInstance.questionTimeCounter.count{
            ScoreCountMgr.sharedInstance.questionTimeCounter[i] = 0
        }
        
        /* TimerMgr変数初期化 */
        TimerMgr.sharedInstance.counterMinutes = 0
        TimerMgr.sharedInstance.counterMs = 0
        TimerMgr.sharedInstance.counterSecond = 0
        TimerMgr.sharedInstance.hour_check = 0
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
