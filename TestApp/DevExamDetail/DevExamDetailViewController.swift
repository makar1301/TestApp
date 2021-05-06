//
//  DevExamDetailViewController.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//

import UIKit

protocol DevExamDetailDisplayLogic: class {
    func displayDetail(data: News, image: UIImage)
}

class DevExamDetailViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var detailDetailLabel: UILabel!
    
    // MARK: - External vars
    
    private(set) var router: (DevExamDetailRoutingLogic & DevExamDetailDataPassingProtocol)?
    
    // MARK: - Internal vars
     private var interactor: (DevExamDetailBusinessLogic & DevExamDetailStoreProtocol)?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchDetails()
     
    }
    
    private func setup() {
        let viewController = self
        let router = DevExamDetailRouter()
        let interactor = DevExamDetailInteractor()
        let presenter = DevExamDetailPresenter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
    }

    

}

extension DevExamDetailViewController: DevExamDetailDisplayLogic {
    func displayDetail(data: News, image: UIImage) {
        navigationItem.title = data.title
        detailTitleLabel.text = data.title
        detailDetailLabel.text = data.text
        imageView.image = image
        
    }
    
    
    
}
