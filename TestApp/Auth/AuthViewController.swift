//
//  AuthViewController.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import UIKit
import InputMask


protocol AuthDisplayLogic: class {
    func displayData(mask: String)
    func displayCode(code: Int)
    func updateTF(phone: String, password: String)
}


class AuthViewController: UIViewController, MaskedTextFieldDelegateListener {
    
    @IBOutlet var listener: MaskedTextFieldDelegate!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private(set) var router: AuthRoutingLogic?
    
    
    private var interactor: AuthBusinessLogic?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let presenter = AuthPresenter()
        let interactor = AuthInteractor()
        let router = AuthRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadFromKeychain()
        interactor?.fetchMask()
        
        
    }
    

    @IBAction func signInButton(_ sender: Any) {
        guard let phone = phoneTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        interactor?.fetchRequest(phone: phone, password: password)
        
    }


}

extension AuthViewController: AuthDisplayLogic {
    func updateTF(phone: String, password: String) {
        phoneTextField.text = phone
        passwordTextField.text = password
    }
    
    func displayCode(code: Int) {
        if code == 200 {
            let phone = phoneTextField.text
            let password = passwordTextField.text
            interactor?.saveData(phone: phone!, password: password!)
            router?.navigateToDevExam()
        } else if code == 400 {
            let alert = UIAlertController(title: "Sorry!", message: "Please enter data", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if code == 403 {
            let alert = UIAlertController(title: "Sorry!", message: "This data not found, please try again", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    func displayData(mask: String) {
        listener.primaryMaskFormat = mask
    }
    
}
