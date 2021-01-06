//
//  Extenstion + ImageView.swift
//  GithubTask
//
//  Created by Islam Abotaleb on 1/5/21.
//

import Foundation
import Kingfisher

class ImageService {
    static let cache = NSCache<NSString, UIImage>()
     
     static func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
         let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
             var downloadedImage:UIImage?
             
             if let data = data {
                 downloadedImage = UIImage(data: data)
             }
             
             if downloadedImage != nil {
                 cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
             }
             
             DispatchQueue.main.async {
                 completion(downloadedImage)
             }
             
         }
         
         dataTask.resume()
     }
     
     static func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
         if let image = cache.object(forKey: url.absoluteString as NSString) {
             completion(image)
         } else {
             downloadImage(withURL: url, completion: completion)
         }
     }
}
extension UIImageView {
    func imageFromURL(urlString: String) {

       let activityIndicator = UIActivityIndicatorView(style: .gray)
          activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
          activityIndicator.startAnimating()
          if self.image == nil{
              self.addSubview(activityIndicator)
          }

          URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

              if error != nil {
                  print(error ?? "No Error")
                  return
              }
              DispatchQueue.main.async(execute: { () -> Void in
                  let image = UIImage(data: data!)
                  activityIndicator.removeFromSuperview()
                  self.image = image
              })

          }).resume()
      }
       private func getEncodedUrl(from urlString: String) -> URL? {
   
           let urlEncoded = ((urlString).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
           if let url =  URL(string: urlEncoded) {
               print("DisplayGetImageGetEnclode\(url)")
               return url
           }
           return nil
       }
    
    
    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
