//
//  RepoProfileUserTableViewCell.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit

 class RepoProfileUserTableViewCell: UITableViewCell {

    @IBOutlet weak var repoView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionRepoLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var createDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        repoView.backgroundColor = .white

        repoView.layer.cornerRadius = 5

        repoView.layer.shadowColor = UIColor.gray.cgColor

        repoView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        repoView.layer.shadowRadius = 6.0

        repoView.layer.shadowOpacity = 0.7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(repoUserGithub: RepoUserGithubModel) {
        self.repoNameLabel.text = repoUserGithub.name
        self.descriptionRepoLabel.text = repoUserGithub.repoUserGithubModelDescription
        self.forksCountLabel.text = "\(repoUserGithub.forksCount!) Fork"
        self.createDate.text = HelperUtils.shared.getFormatedDate(formatDate: repoUserGithub.createdAt!)
    }
    
}

