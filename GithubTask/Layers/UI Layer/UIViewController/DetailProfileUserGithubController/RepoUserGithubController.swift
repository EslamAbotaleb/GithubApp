//
//  RepoUserGithubController.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//



import UIKit

protocol GetUserNameProfileGithub {
    var userName: String? { get }
    
}
class RepoUserGithubController: BaseViewController {
    var delegate: GetUserNameProfileGithub?
   
    @IBOutlet weak var tableView: UITableView!
    var viewModel: GithubViewModel?
    var repoUserGithubCoreDataModel = [RepoUserGithub]()
    let context = PersistanceService.shared.persistentContainer.viewContext
    let persistence = PersistanceService.shared
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
         self.initializeNavigationBarAppearanceWithoutMenu(checkflag: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if delegate != nil {
            viewModel = GithubViewModel()

            viewModel?.registTableViewCellSpesficRepoUserGithub(nibName: "RepoProfileUserTableViewCell", tableView: tableView)
            NotificationCenter.default.addObserver(forName: NSNotification.Name("PersistedDataUpdated"), object: nil, queue: .main) { (_) in
                
            }
//            //MARK:- Online Mode
//            if InternetConnectionManager.isConnectedToNetwork() {

                viewModel?.repoSpesficUserFromGithub(userName:(delegate?.userName)!, completionHandler: { (repoUserGithub) in
                self.viewModel?.repoUserGithubList = repoUserGithub
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            viewModel?.retreiveRepoUserGithubFromCoreData(userName: (delegate?.userName)!, tableView: self.tableView)
            persistence.fetch(RepoUserGithub.self) { [weak self] (repoUserGithub) in
                self?.repoUserGithubCoreDataModel = repoUserGithub
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
//            } else {
//                //MARK:- offlineMode
//
//            }
        } else {
        }

    }
}

