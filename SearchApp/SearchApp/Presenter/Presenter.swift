
import Foundation
import UIKit

//MARK: Experimental presenter

protocol MainViewProtocol:AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    
    var filteredPicturesName: [ImageStruct] {get set}
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func filterContentForSearch(searchText: String)
    func loadedImage(urlString: String)
    var someImage: UIImage? {get set}
}

class MainPresenter: MainViewPresenterProtocol {
    var filteredPicturesName = [ImageStruct]()
    let networkService: NetworkServiceProtocol!
    weak var view: MainViewProtocol?
    var someImage: UIImage?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func loadedImage(urlString: String) {
        networkService.imageLoader(with: urlString){ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.someImage = image
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    func filterContentForSearch(searchText: String) {
        filteredPicturesName = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
                    return pic.nameOfImage.contains(searchText)})
        self.view?.success()
        }
    }
    






//func filterContentForSearch(searchText: String) {
//    filteredPictures = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
//            return pic.nameOfImage.contains(searchText)})
//}
//
