
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




