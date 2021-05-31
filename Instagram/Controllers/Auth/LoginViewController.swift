//
//  LoginViewController.swift
//  Instagram
//
//  Created by Andre Luis Barbosa Coutinho on 30/05/21.
//

import UIKit

fileprivate let CORNER_RADIUS: CGFloat = 8.0
fileprivate let X: CGFloat = 24.0
fileprivate let FIELD_WIDTH: CGFloat = 10.0
fileprivate let BORDER_WIDTH: CGFloat = 1.0

class LoginViewController: UIViewController {
    
    private let nameOrEmail: UITextField = {
        let field = UITextField();
        field.placeholder = "Username or Email";
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: FIELD_WIDTH, height: 0));
        field.autocapitalizationType = .none;
        field.autocorrectionType = .no;
        field.layer.masksToBounds = true;
        field.layer.cornerRadius = CORNER_RADIUS;
        field.backgroundColor = .secondarySystemBackground;
        field.layer.borderWidth = BORDER_WIDTH;
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field;
    }()
    
    private let password: UITextField = {
        let field = UITextField();
        field.placeholder = "Password";
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: FIELD_WIDTH, height: 0));
        field.autocapitalizationType = .none;
        field.autocorrectionType = .no;
        field.layer.masksToBounds = true;
        field.layer.cornerRadius = CORNER_RADIUS;
        field.backgroundColor = .secondarySystemBackground;
        field.layer.borderWidth = BORDER_WIDTH;
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field;
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton();
        button.setTitle("Log In", for: .normal);
        button.layer.masksToBounds = true;
        button.layer.cornerRadius = CORNER_RADIUS;
        button.backgroundColor = .systemBlue
        return button;
    }()
    
    override func viewDidLoad() {
        loginButton.addTarget(self, action: #selector(onLoginPress), for: .touchUpInside)
        
        super.viewDidLoad()
        nameOrEmail.delegate = self;
        password.delegate = self;
        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let width: CGFloat = view.width - 48;
        let height: CGFloat = view.height/10.0
        
        nameOrEmail.frame = CGRect(x: X, y: view.height/3.0, width: width, height: height)
        password.frame = CGRect(x: X, y: nameOrEmail.bottom + 8, width: width, height: height)
        loginButton.frame = CGRect(x: X, y: password.bottom + 8, width: width, height: height)
        
    }
    
    private func addSubViews(){
        view.addSubview(nameOrEmail)
        view.addSubview(password)
        view.addSubview(loginButton)
    }
    
    @objc private func onLoginPress(){
        password.resignFirstResponder();
        nameOrEmail.resignFirstResponder();
        
        guard let user = nameOrEmail.text, !user.isEmpty,
              let pass = password.text, !pass.isEmpty else {
            
            let alert = UIAlertController(title: "Log In Error", message: "Invalid user or password.", preferredStyle: .alert);
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil));
            
            self.present(alert, animated: true);
            
            return;
        }
        UserDefaults.standard.set(true, forKey: "userIsLoggedIn") // Keep User Logged In
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameOrEmail {
            password.becomeFirstResponder();
        }
        else if textField == password {
            onLoginPress()
        }
        return true;
    }
}
