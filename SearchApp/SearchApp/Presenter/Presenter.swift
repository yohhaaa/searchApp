
import Foundation
import UIKit

//MARK: PRESENTER

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

//MARK: LOAD IMAGE PROTOCOL

protocol NetworkServiceProtocol: AnyObject {
    func imageLoader(with urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void)
}

class NetworkService:NetworkServiceProtocol {
    
    func imageLoader(with urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
    guard let url = URL(string: urlString) else { return }
    
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
            if let error = error {
                completion(.failure(error))
                return
            } //TO DO: добавить дефолтную картинку если не загрузилось
            else {
                let image = UIImage(data: data!)
                    completion(.success(image))
                }
            }
            }.resume()
        }
    }
}




