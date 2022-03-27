
import Foundation
import UIKit

//MARK: PRESENTER PROTOCOL





protocol PresenterProtocol: AnyObject {
    func filterSearch(_ searchText: String)
}


class PresenterClass: PresenterProtocol {
    weak var view: SearchViewController?
    
    var filteredPictures = [ImageStruct]()
    func filterSearch(_ searchText: String) {
        filteredPictures = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
            return pic.nameOfImage
                .contains(searchText)})
        
    }
    
}


protocol NetworkServiceProtocol: AnyObject {
    func imageLoader(with urlString: String, completion: @escaping ((UIImage?) -> Void))
}

class NetworkService:NetworkServiceProtocol {
    
    func imageLoader(with urlString: String, completion: @escaping ((UIImage?) -> Void)) {
    guard let url = URL(string: urlString) else { return }
    
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                
            } //TO DO: добавить дефолтную картинку если не загрузилось
            else {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    completion(image)
                    }
                }
            }.resume()
        }
    }
}

//MARK: LOAD IMAGE PROTOCOL


