//
//  ViewController.swift
//  Counter
//
//  Created by Timur Tufatulin on 24/05/2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var historyTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    var count: UInt = 0
    
    func getDate () -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy (HH:mm)"
        let result = dateFormat.string(from: Date())
        return result
    }
    
    func addHistory (button: UIButton) {
        switch button {
        case minusButton:
            historyTextView.text += "・ \(getDate()): значение изменено на -1.\n"
        case plusButton:
            historyTextView.text += "・ \(getDate()): значение изменено на +1.\n"
        default:
            historyTextView.text += "・ \(getDate()): значение сброшено.\n"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTextView.layer.cornerRadius = 15
        historyTextView.contentInset = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        historyTextView.isScrollEnabled = true
        historyTextView.text = "История изменений:\n\n"
    }
    @IBAction func plusButtonDidTap(_ sender: Any) {
        count += 1
        countLabel.text = String(count)
        addHistory(button: plusButton)
    }
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        if count != 0 {
            count -= 1
            countLabel.text = String(count)
            addHistory(button: minusButton)
        } else {
            historyTextView.text += "・ \(getDate()): попытка уменьшить значение счётчика ниже 0.\n"
        }
    }
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        if count == 0 {
            let dialog = UIAlertController(title: "", message:"Счётчик уже сброшен", preferredStyle: .alert)
            let okAction = UIAlertAction(title:"OK", style: .default, handler: {(alert:UIAlertAction!)-> Void in})
            dialog.addAction(okAction)
            self.present(dialog, animated:false, completion:nil)
        } else {
            count = 0
            countLabel.text = String(count)
            addHistory(button: resetButton)
        }
    }
}
