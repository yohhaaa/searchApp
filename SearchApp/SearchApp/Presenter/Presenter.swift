
import Foundation
import UIKit

//MARK: Filter protocol

protocol FilterProtocol: AnyObject {
    func filterSearch(_ searchText: String)
}


class FilterClass: FilterProtocol {
    weak var view: SearchViewController?
    
    var filteredPictures = [ImageStruct]()
    
    func filterSearch(_ searchText: String) {
        filteredPictures = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
            return pic.nameOfImage
                .contains(searchText)})
    }
}

//Пытаюсь сделать PRESENTER по MVP паттерну (не получается :C ) мб я близок к ответу
//MARK: Experimental presenter

protocol MainViewProtocol:AnyObject {
    func success(image: UIImage?)
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {

    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func loadedimage()
    var someImage: UIImage? {get set}
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkService: NetworkServiceProtocol!
    var someImage: UIImage?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        loadedimage()
    }

    func loadedimage() {
        networkService.imageLoader(with: "https://wonder-day.com/wp-content/uploads/2020/04/wonder-day-images-rainbow-37-1024x576.jpg"){ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.someImage = image
                    self.view?.success(image: image)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}







