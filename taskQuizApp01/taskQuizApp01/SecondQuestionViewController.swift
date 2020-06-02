//
//  SecondQuestionViewController.swift
//  taskQuizApp01
//
//  Created by 福島悠樹 on 2020/05/30.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class SecondQuestionViewController: UIViewController, TimerDelegate, TimeCounterDelegate, UITextFieldDelegate {

    @IBOutlet weak var questTwoResultView: UIImageView!
    @IBOutlet weak var questTwoResultComment: UILabel!
    @IBOutlet weak var questTwoAnswer: UITextField!
    var retryCount:Int = 0
    
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
        return 1
    }
    func getquestionTimeCounter() -> Int{
        return counter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerMgr.sharedInstance.delegate = self         /* 己をセット */
        ScoreCountMgr.sharedInstance.delegate = self    /* 己をセット */
        questTwoAnswer.delegate = self                  /* 己をセット */
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
    
    /* 正解判定 */
    @IBAction func tappedDecideQuestTwoBtn(_ sender: Any) {
        if self.questTwoAnswer.text=="ウルトラセブン" {
            showTrue()
            resetTimer()
            moveToThirdQuestion()
        }else{
            showFalse()
        }
    }
    
    /* 正解時のアクション関数 */
    func showTrue(){
        self.questTwoResultView.image = UIImage(named: "circle")
        self.questTwoResultComment.text = "正解です！"
        ScoreCountMgr.sharedInstance.addScore()
    }
    
    /* 不正解時のアクション関数 */
    func showFalse(){
        retryCount += 1                                            /* リトライ回数カウントアップ*/
        self.questTwoResultView.image = UIImage(named: "x")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){  /* 2秒後にmsg消灯 */
            self.questTwoResultView.image = nil
        }
        retryMsg(retryCounter:retryCount)                       /* ヒントmsg */
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){  /* 2秒後にmsg消灯 */
            self.questTwoResultComment.text = ""
        }
    }
    
    /* 不正解時のヒントメッセージ通知関数 */
    func retryMsg(retryCounter:Int){
        if retryCount==1 {
            self.questTwoResultComment.text = "おしい！"
        }else if retryCount==2{
            self.questTwoResultComment.text = "ウルトラマンシリーズの第二作です"
        }else{
            self.questTwoResultComment.text = "ウルトラ○○○です"
        }
    }
    
    /* 画面ジャンプのアクション関数 */
    func moveToThirdQuestion(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            let vc = ThirdQuestionViewController()
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
    
    /* textに答えを入力した時にキーボードを消す(textFieldのprotocolに用意されているメソッド) */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    /* タッチした時にキーボードを消す(UIViewControllerに用意されているメソッド) */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
