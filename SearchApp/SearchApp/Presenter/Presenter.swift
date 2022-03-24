
import Foundation
import UIKit

//MARK: PRESENTER PROTOCOL
protocol ViewProtocol: AnyObject {
    func success ()
    func failure ()
}

protocol ViewPresentProtocol: AnyObject {
    init(view: ViewProtocol, fetchImage: FetchImagesProtocol)
}

class Presenter: ViewPresentProtocol {
    weak var view: ViewProtocol?
    let fetchImage: FetchImagesProtocol
    
    required init(view: ViewProtocol, fetchImage: FetchImagesProtocol) {
        self.view = view
        self.fetchImage = fetchImage
    }
    
    
}


//MARK: LOAD IMAGE PROTOCOL
protocol FetchImagesProtocol {
    func fetchImages(urlString:String, completion: @escaping (Result<UIImage?,Error>)-> Void)
}

class FetchImages: FetchImagesProtocol {
    func fetchImages(urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
                else if let error = error {
                    completion(.failure(error))
                    return
                }
            }.resume()
    }
}
