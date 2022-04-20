import Foundation
import UIKit.UIImage

protocol MainViewPresenterProtocol: AnyObject {
    var filteredPictures: [ImageStruct] { get set }
    init(view: SearchViewController, networkService: NetworkServiceProtocol)
    func filterContentForSearch(searchText: String)
    func loadImage(urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: SearchViewController?
    var filteredPictures = ImageStruct.pictures
    let networkService: NetworkServiceProtocol!
    
    required init(view: SearchViewController, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func loadImage(urlString: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
        networkService.loadImageService(with: urlString){ result in
        DispatchQueue.main.async {
        switch result {
        case .success(let image):
            completion(.success(image))
        case .failure(let error):
            completion(.failure(error))
        }
        }
        }
    }
    
    func filterContentForSearch(searchText: String) {
        if searchText.isEmpty {
            filteredPictures = ImageStruct.pictures
        }
        else {
            filteredPictures = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
            return pic.nameOfImage.contains(searchText)})
        }
    }
}
