//
//  ViewController.swift
//  MarubatuApp
//
//  Created by nowall on 2018/10/27.
//  Copyright © 2018 鈴木貴大. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBAction func returnToMe (segue: UIStoryboardSegue) {}
    var resultQuestions : [[String : Any]] = []
    // 表示中の問題番号を格納
    var currentQuestionNum: Int = 0
    

    
    //画面表示されたとき発動
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showQuestion()
    }
    
    
    
    // 問題を表示する関数
    func showQuestion() {
        resultQuestions = UserDefaults.standard.object(forKey: "questions") as! [[String : Any]]
        //nil対策で入れたif文
        if currentQuestionNum < resultQuestions.count {
            let resultQuestion = resultQuestions[currentQuestionNum]
            let que = resultQuestion["question"]
            questionLabel.text = que as? String
        } else {
            //もし問題が入っていなかったら
                questionLabel.text = "問題文がありません、問題を作りましょう！！！"
        }
    }
    
    
    
    // 回答をチェックする関数
    // 正解なら次の問題を表示します
    func checkAnswer(yourAnswer: Int) {
        //nil対策で入れたif文
        if currentQuestionNum < resultQuestions.count {
            
            let resultQuestion = resultQuestions[currentQuestionNum]
            
            if let ans = resultQuestion["answer"] as? Int {
                if yourAnswer == ans {
                    // 正解
                    // currentQuestionNumを1足して次の問題に進む
                    currentQuestionNum += 1
                    showAlert(message: "正解！")
                } else {
                    // 不正解
                    showAlert(message: "不正解！")
                }
            }
            
            if currentQuestionNum >= resultQuestions.count {
                currentQuestionNum = 0
            }
            // 問題を表示します。
            // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
            showQuestion()
        }
    }
    
    
    
    //Alert機能
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        alert.addAction(close)
        present(alert,animated: true,completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //✖ボタン
    @IBAction func noButton(_ sender: Any) {
        checkAnswer(yourAnswer: 0)
    }
    
    //◯ボタン
    @IBAction func yesButton(_ sender: Any) {
        checkAnswer(yourAnswer: 1)
    }
    
    
}

