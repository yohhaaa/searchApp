import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var customCellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customCellView.backgroundColor = .lightGray
        customImageView.backgroundColor = .gray
    }

    override func prepareForReuse(){
        customImageView.image = nil
    }
  
    func loadImageConfigure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        spinner.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    self?.errorLoad()
                    return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.customImageView?.image = image
                    self?.spinner.stopAnimating()
                    self?.spinner.isHidden = true
                }
            }.resume()
        }
    }
    
    func errorLoad (){
        DispatchQueue.main.async {
            let errorImage = UIImage(named: "errorLoad.jpeg")
            self.customImageView?.image = errorImage
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
}
