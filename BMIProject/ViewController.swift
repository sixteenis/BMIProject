//
//  ViewController.swift
//  BMIProject
//
//  Created by 박성민 on 5/21/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weighttextField: UITextField!
    
    @IBOutlet var secureButton: UIButton!
    @IBOutlet var randomSetButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    
    var secureBool = false
    var bmi = 0.0
    var resultTitle = ""
    var resultBackgroundColor: UIColor = .clear
    
    var resultButtnChange: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setImage()
        setTextField()
        setButton()
        
    }
    // MARK: - 뷰 세팅 구간
    func setLabel() {
        mainLabel.text = "BMI Calculator"
        mainLabel.textColor = .black
        mainLabel.textAlignment = .left
        mainLabel.font = .boldSystemFont(ofSize: 20)
        
        
        labelset(label: subLabel, text: "당신의 BMI 지수를 \n 알려드릴게요.")
        subLabel.numberOfLines = 0
        
        labelset(label: heightLabel, text: "키가 어떻게 되시나요?")
        
        labelset(label: weightLabel, text: "몸무게는 어떻게 되시나요?")
        
        resultLabel.textColor = .black
        resultLabel.font = .systemFont(ofSize: 20)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 2
        resultLabel.backgroundColor = .red
        resultLabel.isHidden = true
    }
    func setImage() {
        mainImage.image = UIImage(named: "image")
    }
    func setTextField() {
        setTextFields(textField: heightTextField, "cm단위로 키를 입력해주세요.")
        setTextFields(textField: weighttextField, "kg단위로 몸무게를 입력해주세요.")
        weighttextField.isSecureTextEntry = secureBool
    }
    func setButton() {
        secureButton.setTitle("", for: .normal)
        secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
        secureButton.tintColor = .gray
        
        randomSetButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomSetButton.tintColor = .red
        randomSetButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.layer.cornerRadius = 15
        resultButton.clipsToBounds = true // 깍을 때 불편하게 나오는거 해결
        resultButton.tintColor = .white
        resultButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }

    // MARK: - 함수 구간
    func labelset(label: UILabel, text: String) {
        label.text = text
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .left
    }
    func setTextFields(textField: UITextField, _ placeholder: String){
        textField.placeholder = placeholder
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true // 깍을 때 불편하게 나오는거 해결
        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 12.0, height: 0.0))
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        
    }
    
    // MARK: -BMI 계산 함수
    func bmiSet(_ height: Double, weight: Double){
        let cmHeight = height / 100
        bmi = weight / (cmHeight * cmHeight)
        bmi = Double(Int(bmi*10))/10
        switch bmi {
        case 0..<18.5:
            resultTitle = "저체중"
            resultBackgroundColor = .blue
        case 18.5...24.9:
            resultTitle = "정상체중"
            resultBackgroundColor = .green
        case 25...29.9:
            resultTitle = "과체중"
            resultBackgroundColor = .purple
        case 30...39.9:
            resultTitle = "비만1단계"
            resultBackgroundColor = .red
        case 40...100:
            resultTitle = "비만2단계"
            resultBackgroundColor = .red
        default:
            resultTitle = "비만3단계"
            resultBackgroundColor = .red
        }
    }
    
    
    // MARK: - output 구간
    
    
    @IBAction func heightButtonEnd(_ sender: UITextField) {
        
    }
    
    @IBAction func weightButtonEnd(_ sender: UITextField) {
        
    }
    
    @IBAction func heightButtonInputing(_ sender: UITextField) {
        
    }
    
    
    
    
    
    @IBAction func viewTappend(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func SecureButtonTapped(_ sender: UIButton) {
        secureBool.toggle()
        if secureBool{
            secureButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            weighttextField.isSecureTextEntry = secureBool
        }else{
            secureButton.setImage(UIImage(systemName: "eye"), for: .normal)
            weighttextField.isSecureTextEntry = secureBool
        }
    }
    
    
    
    
    // MARK: -랜덤 입력으로 BMI실행
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        let height = Double.random(in: 140...200)
        let weight = Double.random(in: 40...110)
        bmiSet(height, weight: weight)
        resultButtnChange.toggle()
        resultLabel.isHidden = false
        heightLabel.isHidden = true
        resultLabel.text = "BMI 결과는 : \(bmi)입니다. \n\(resultTitle)이십니다!"
        resultLabel.backgroundColor = resultBackgroundColor
        resultButton.setTitle("다시 측정하기", for: .normal)
        
    }
    
    // MARK: - 입력값으로 BMI실행
    @IBAction func restulButtonTapped(_ sender: UIButton) {
        if !resultButtnChange{
            resultButtnChange.toggle()
            guard let height = Double(heightTextField.text!) else {return}
            guard let weight = Double(weighttextField.text!) else {return}
            bmiSet(height, weight: weight)
            resultLabel.isHidden = false
            heightLabel.isHidden = true
            resultLabel.text = "BMI 결과는 : \(bmi)입니다. \n\(resultTitle)이십니다!"
            resultLabel.backgroundColor = resultBackgroundColor
            resultButton.setTitle("다시 측정하기", for: .normal)
        }else{
            resultButton.setTitle("결과 확인", for: .normal)
            heightTextField.text = ""
            weighttextField.text = ""
            resultButtnChange.toggle()
            resultLabel.isHidden = true
            heightLabel.isHidden = false
        }
        
        
        
    }
    

}

//var secureBool = false
//var bmi = 0.0
//var resultTitle = ""
//var resultBackgroundColor: UIColor = .clear
