//
//  DisplayUsersGithubTableViewCell.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import UIKit

class DisplayUsersGithubTableViewCell: UITableViewCell {

    @IBOutlet weak var avaterImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var viewDisplayUsers: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        avaterImg.makeRounded()
        viewDisplayUsers.backgroundColor = .white

        viewDisplayUsers.layer.cornerRadius = 5

        viewDisplayUsers.layer.shadowColor = UIColor.gray.cgColor

        viewDisplayUsers.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        viewDisplayUsers.layer.shadowRadius = 6.0

        viewDisplayUsers.layer.shadowOpacity = 0.7


    }
    override func layoutSubviews() {
        avaterImg.layer.cornerRadius = avaterImg.bounds.height / 2
        avaterImg.clipsToBounds = true
    }
    func configure(userGithub: UsersModel) {
      
        if InternetConnectionManager.isConnectedToNetwork() {
            ImageService.downloadImage(withURL: URL(string: userGithub.avatarURL!)!) { (imageUser) in
                self.avaterImg.image = imageUser
            }
            self.userName.text = userGithub.login

        } else {
            ImageService.getImage(withURL: URL(string: userGithub.avatarURL!)!) { (imageUser) in
                self.avaterImg.image = imageUser
            }
            self.userName.text = "f"
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
