import UIKit.UIImage
import Foundation

//MARK: NetworkService PROTOCOL with cache

protocol NetworkServiceProtocol: AnyObject {
    func imageLoader(with urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void)
    
}

class NetworkService:NetworkServiceProtocol {
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func imageLoader(with urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {

        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(.success(cachedImage))
        } else {
        
    guard let url = URL(string: urlString) else { return }

        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
            if let error = error {
                completion(.failure(error))
            }
            else {
                let image = UIImage(data: data!)
                completion(.success(image))
                self.imageCache.setObject(image!, forKey: urlString as NSString)
            }
                }
                }.resume()
            }
        }
    }
}
