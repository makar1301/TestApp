//
//  DevExamViewController.swift
//  TestApp
//
//  Created by mac on 03.05.2021.
//
import Foundation
import UIKit

protocol DevExamDisplayLogic: class {
    func displayData(data: [News])
}

class DevExamViewController: UIViewController {
    
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    // MARK: - External vars
    private(set) var router: DevExamRoutingLogic?
    
    
    // MARK: - Internal vars
    private var interactor: DevExamBusinessLogic?
    private var tableData = [News]()
    
    
    
    
    
    
    
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
        let presenter = DevExamPresenter()
        let interactor = DevExamInteractor()
        let router = DevExamRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchNews()
        setupTableView()
        setupTimer()
    }
    
    @IBAction func switchSegContr(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0 : interactor?.sendIndex(index: 0, data: tableData)
        case 1 : interactor?.sendIndex(index: 1, data: tableData)
            
        default:
            break
        }
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        interactor?.fetchNews()
        segControl.selectedSegmentIndex = 0
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DevExamTableViewCell", bundle: nil), forCellReuseIdentifier: DevExamTableViewCell.cellIdentifare)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true) { (timer) in
            self.interactor?.fetchNews()
            self.segControl.selectedSegmentIndex = 0
            print("Данные обновлены")
        }
    }
    
    
    
}

// MARK: - Display logic

extension DevExamViewController: DevExamDisplayLogic {
    
    func displayData(data: [News]) {
        tableData.removeAll()
        tableData = data
        tableView.reloadData()
        
    }
    
    
}



// MARK: - TableViewDelegate & Datasourse

extension DevExamViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DevExamTableViewCell.cellIdentifare, for: indexPath) as! DevExamTableViewCell
        
        cell.setupCell(data: tableData, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let id = tableData[indexPath.row]
        router?.navigateToDevExamDetail(id: id)
        
    }
    
    
}
