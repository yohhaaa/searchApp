import Foundation
import UIKit

//MARK: Experimental presenter

protocol PresentViewProtocol: AnyObject {
    func filteredText()
    func imageLoaded()
    func loadFailed(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var filteredPicturesName: [ImageStruct] {get set}
    var someText: String? {get set}
    var someImage: UIImage? {get set}
    init(view: PresentViewProtocol, networkService: NetworkServiceProtocol)
    
    func filterContentForSearch(searchText: String)
    func loadImage(urlString: String)
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: PresentViewProtocol?
    var filteredPicturesName = [ImageStruct]()
    let networkService: NetworkServiceProtocol!
    var someImage: UIImage?
    var someText: String?
    
    required init(view: PresentViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        loadImage(urlString: ImageStruct.pictures[3].urlOfImage)
    }
    
    func loadImage(urlString: String) {
        networkService.imageLoader(with: urlString){ [weak self] result in
        guard let self = self else { return }
        DispatchQueue.main.async {
        switch result {
            case .success(let image):
                self.someImage = image
                self.view?.imageLoaded()
            case .failure(let error):
                self.someImage = UIImage(named: "errorLoad.jpeg")
                self.view?.loadFailed(error: error)
                }
            }
        }
    }
    func filterContentForSearch(searchText: String) {
        filteredPicturesName = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
        return pic.nameOfImage.contains(searchText)})
        self.view?.filteredText()
        }
    }
