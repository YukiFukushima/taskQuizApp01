//
//  ThirdQuestionViewController.swift
//  taskQuizApp01
//
//  Created by 福島悠樹 on 2020/05/30.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class ThirdQuestionViewController: UIViewController, TimerDelegate, TimeCounterDelegate {

    @IBOutlet weak var questThirdResultView: UIImageView!
    @IBOutlet weak var questThirdResultComment: UILabel!
    
    @IBOutlet weak var firstChoiceImg: UIImageView!
    @IBOutlet weak var secondChoiceImg: UIImageView!
    @IBOutlet weak var thirdChoiceImg: UIImageView!
    
    @IBOutlet weak var MinuteCounter: UILabel!
    @IBOutlet weak var SecondCounter: UILabel!
    @IBOutlet weak var MsCounter: UILabel!
    
    var timer:Timer? = nil
    var counter:Int = 0
    
    /* 要素1(1stChoice), 要素2(2ndChoice), 要素3(3rdChoice) */
    var thirdQuestionAnserCounter:[Int] = [0, 0, 0]
    
    /* デリゲート(TimerDelegate)メソッド群Call */
    func getTimeCounter()->Int{
        return counter
    }
    func getMinuteInstance()->UILabel!{
        return MinuteCounter
    }
    func getSecondInstance()->UILabel!{
        return SecondCounter
    }
    func getMsInstance()->UILabel!{
        return MsCounter
    }
    
    /* デリゲート(TimeCounterDelegate)メソッド群Call */
    func getQuestionNumber() -> Int{
        return 2
    }
    func getquestionTimeCounter() -> Int{
        return counter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerMgr.sharedInstance.delegate = self     /* 己をセット */
        ScoreCountMgr.sharedInstance.delegate = self    /* 己をセット */
        startTimer()                                /* タイマー開始 */
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

    /* 斜陽選択(正解) */
    @IBAction func tappedQuestThirdFirstChoice(_ sender: Any) {
        thirdQuestionAnserCounter[0] = 1
        firstChoiceImg.image = UIImage(named: "チェックマーク")
    }
    
    /* 走れメロス選択(正解) */
    @IBAction func tappedQuestThirdSecondChoice(_ sender: Any) {
        thirdQuestionAnserCounter[1] = 1
        secondChoiceImg.image = UIImage(named: "チェックマーク")
    }
    
    /* 峠選択 */
    @IBAction func tappedQuestThirdThirdChoice(_ sender: Any) {
        thirdQuestionAnserCounter[2] = 1
        thirdChoiceImg.image = UIImage(named: "チェックマーク")
    }
    
    /* 正解判定 */
    @IBAction func tappedDecideQuestThirdBtn(_ sender: Any) {
        if thirdQuestionAnserCounter[0]==1
        && thirdQuestionAnserCounter[1]==1
        && thirdQuestionAnserCounter[2]==0{
            showTrue()
            resetTimer()
            moveToScoreView()
        }else{
            showFalse()
        }
        
    }
    
    /* 正解時のアクション関数 */
    func showTrue(){
        self.questThirdResultView.image = UIImage(named: "circle")
        self.questThirdResultComment.text = "正解です！"
        ScoreCountMgr.sharedInstance.addScore()
    }
    
    /* 不正解時のアクション関数 */
    func showFalse(){
        self.questThirdResultView.image = UIImage(named: "x")   /* x表示 */
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){  /* 2秒後にmsg消灯 */
            self.questThirdResultView.image = nil
        }
        
        self.questThirdResultComment.text = "おしい！"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){  /* 2秒後にmsg消灯 */
            self.questThirdResultComment.text = ""
        }
        
        for i in 0 ..< 3 {                                      /* 正誤カウンタクリア */
            thirdQuestionAnserCounter[i]=0
        }
        
        firstChoiceImg.image = UIImage(named: "斜陽")
        secondChoiceImg.image = UIImage(named: "走れメロス")
        thirdChoiceImg.image = UIImage(named: "峠")
    }
    
    /* 画面ジャンプのアクション関数 */
    func moveToScoreView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            let vc = ScoreViewController()
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
