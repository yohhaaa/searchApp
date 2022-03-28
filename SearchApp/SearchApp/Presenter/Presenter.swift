
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

//Пытаюсь сделать PRESENTER по MVP паттерну (не получается :C ) мб я близок к ответу
//MARK: Experimental presenter
//
//protocol MainViewProtocol: AnyObject {
//    func success()
//    func failure(error: Error)
//}

//protocol MainViewPresenterProtocol: AnyObject {
//    func filterSearch(_ searchText: String)
//
//    init(view: SearchViewController, networkService: NetworkServiceProtocol)
////    func loadedimage()
//}
//
//class MainPresenter: MainViewPresenterProtocol {
//
//    var filteredPictures = [ImageStruct]()
//
//    func filterSearch(_ searchText: String) {
//        filteredPictures = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
//            return pic.nameOfImage
//                .contains(searchText)})
//
//    }
//
//    var view: SearchViewController
//    let networkService: NetworkServiceProtocol!
//
//    required init(view: SearchViewController, networkService: NetworkServiceProtocol) {
//        self.view = view
//        self.networkService = networkService
//
//    }
//
//    func loadedimage(urlString: String, name: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
//        networkService.imageLoader(with: "http://kakoy-smysl.ru/wp-content/uploads/2020/02/grus-kart-so-sm-1.jpg") {result in
//
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let image):
//                        completion(.success(image))
//                case .failure(let error):
//                        completion(.failure(error))
//                }
//            }
//        }
//    }
//}







