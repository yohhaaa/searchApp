
import Foundation
import UIKit

//MARK: Experimental presenter

protocol MainViewProtocol:AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    
    func filterSearch(_ searchText: String)
    func loadedimage(urlString: String)
    
    var filteredPictures: [ImageStruct] {get set}
    var someImage: UIImage? {get set}
}

class MainPresenter: MainViewPresenterProtocol {

    let networkService: NetworkServiceProtocol!
    weak var view: MainViewProtocol?
    var pictures = ImageStruct.pictures
    var filteredPictures = [ImageStruct]()
    var someImage: UIImage?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        loadedimage(urlString: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP5VKFOTn-2IxmSp9pcNC_B0PHDDvNQSAeVQ&usqp=CAU")
    }
    
    func loadedimage(urlString: String) {
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
    
    func filterSearch(_ searchText: String) {
        filteredPictures = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
            return pic.nameOfImage
                .contains(searchText)})
    }
}







