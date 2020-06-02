//
//  FirstQuestionViewController.swift
//  taskQuizApp01
//
//  Created by 福島悠樹 on 2020/05/30.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class FirstQuestionViewController: UIViewController, TimerDelegate, TimeCounterDelegate {

    @IBOutlet weak var questOneResultView: UIImageView!
    @IBOutlet weak var questOneResultComment: UILabel!
    @IBOutlet weak var MinutesCounter: UILabel!
    @IBOutlet weak var SecondCounter: UILabel!
    @IBOutlet weak var MsCounter: UILabel!
    
    var timer:Timer? = nil
    var counter:Int = 0
    
    /* デリゲート(TimerDelegate)メソッド群Call */
    func getTimeCounter()->Int{
        return counter
    }
    func getMinuteInstance()->UILabel!{
        return MinutesCounter
    }
    func getSecondInstance()->UILabel!{
        return SecondCounter
    }
    func getMsInstance()->UILabel!{
        return MsCounter
    }
    
    /* デリゲート(TimeCounterDelegate)メソッド群Call */
    func getQuestionNumber() -> Int{
        return 0
    }
    func getquestionTimeCounter() -> Int{
        return counter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerMgr.sharedInstance.delegate = self         /* 己をセット */
        ScoreCountMgr.sharedInstance.delegate = self    /* 己をセット */
        startTimer()                                    /* タイマー開始 */

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    /* 沖縄の海選択 */
    @IBAction func tappedQuestOneThirdChoice(_ sender: Any) {
        showFalse()
    }
    
    /* 湘南の海選択(正解) */
    @IBAction func tappedQuestOneSecondChoice(_ sender: Any) {
        showTrue()
        resetTimer()
        moveToSecondQuestion()
    }
    
    /* 日本海選択 */
    @IBAction func tappedQuestOneFirstChoice(_ sender: Any) {
        showFalse()
    }
    
    /* 正解時のアクション関数 */
    func showTrue(){
        self.questOneResultView.image = UIImage(named: "circle")
        self.questOneResultComment.text = "正解です！"
        ScoreCountMgr.sharedInstance.addScore()
    }
    
    /* 不正解時のアクション関数 */
    func showFalse(){
        self.questOneResultView.image = UIImage(named: "x")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){  /* 2秒後にmsg消灯*/
            self.questOneResultView.image = nil
        }
        self.questOneResultComment.text = "おしい！"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){  /* 2秒後にmsg消灯*/
            self.questOneResultComment.text = ""
        }
    }
    
    /* 画面ジャンプのアクション関数 */
    func moveToSecondQuestion(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            let vc = SecondQuestionViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true,completion: nil)
        }
    }
    
    /* タイマー開始関数 */
    func startTimer(){
        /* 既にタイマーが生成済みなら何もしないようにする */
        guard timer == nil else{ return }
        
        /* タイマー生成&開始*/
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: timerCBR)
    }
    
    /* タイマー停止関数 */
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    /* タイマー時間満了時(100ms経過時)にコールされる関数 */
    func timerCBR(timer:Timer){
        //counter += timer.timeInterval
        counter += 1
        
        printTime()
    }
    
    /* タイマーリセット関数 */
    func resetTimer(){
        counter = 0
        stopTimer()
    }
    
    /* 出力関数 */
    func printTime(){
        /* 表示関数Call */
        TimerMgr.sharedInstance.printTime()
    }
}
