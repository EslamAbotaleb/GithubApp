//
//  RepoUserGithub+CoreDataProperties.swift
//  
//
//  Created by Islam Abotaleb on 1/6/21.
//
//

import Foundation
import CoreData


extension RepoUserGithub {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepoUserGithub> {
        return NSFetchRequest<RepoUserGithub>(entityName: "RepoUserGithub")
    }

    @NSManaged public var reponame: String?
    @NSManaged public var forkcount: Int16
    @NSManaged public var createdate: String?
    @NSManaged public var descriptionrepo: String?

    
    
}
