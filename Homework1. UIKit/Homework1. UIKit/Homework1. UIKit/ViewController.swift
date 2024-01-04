//
//  ViewController.swift
//  Homework1. UIKit
//
//  Created by Максим Бобков on 04.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // Добавляем лого
    private var logo: UIImageView = {
        let logo = UIImageView(image: UIImage(named: "logo"))
        return logo
    }()
    
    // Добавляем заголовок
    private var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.textColor = .black
        //label.backgroundColor = .blue
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    // Добавляем текстовые поля
    private var loginInput: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.placeholder = "Login"
        input.font = UIFont.systemFont(ofSize: 22)
        input.textColor = .black
        input.backgroundColor = .white
        return input
    }()
    private var passwordInput: UITextField = {
        let input = UITextField()
        input.isSecureTextEntry = true
        input.borderStyle = .roundedRect
        input.placeholder = "Password"
        input.font = UIFont.systemFont(ofSize: 22)
        input.textColor = .black
        input.backgroundColor = .white
        return input
    }()
    
    // Добавляем кнопку
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.yellow, for: .highlighted)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        //button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "ViewController"
        setupUI()
    }

    private func setupUI() {
        view.addSubview(logo)
        view.addSubview(headingLabel)
        view.addSubview(loginInput)
        view.addSubview(passwordInput)
        view.addSubview(loginButton)
        сonstraints()
    }
    
    private func сonstraints() {
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        loginInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // logo
            
            // Отступаем от "чёлки" 40 поинтов
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            // Располагаем центр х картинки по центру х вью
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Задаём ширину
            logo.widthAnchor.constraint(equalToConstant: 150),
            // Высоту подстраиваем атоматически пропорционально ширине
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor, multiplier: (logo.image?.size.height ?? 1) / (logo.image?.size.width ?? 1)),
            
            // headingLabel
            
            // Отступаем от logo 40 поинтов
            headingLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 40),
            // Располагаем центр х лейбла по центру х вью
            headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            headingLabel.heightAnchor.constraint(equalToConstant: 60),
            
            // login input
            
            // Отступаем от заголовка 40 поинтов
            loginInput.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 40),
            // Располагаем центр х лейбла по центру х вью
            loginInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginInput.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            loginInput.heightAnchor.constraint(equalToConstant: 50),
            
            // password input
            
            // Отступаем от поля для ввода логина 20 поинтов
            passwordInput.topAnchor.constraint(equalTo: loginInput.bottomAnchor, constant: 20),
            // Располагаем центр х лейбла по центру х вью
            passwordInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInput.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            passwordInput.heightAnchor.constraint(equalToConstant: 50),
            
            // button
            
            // Отступаем от поля для ввода пароля 30 поинтов
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 30),
            // Располагаем центр х лейбла по центру х вью
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

// Чтобы сбоку интерактивно отображалась визуализация данного представления
#Preview {
    ViewController()
}
