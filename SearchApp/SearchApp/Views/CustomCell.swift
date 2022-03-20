import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var customCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCellView.backgroundColor = .lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse(){
        customImageView.image = nil
    }
    
  
    func configure(with urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.customImageView?.image = image
                self?.spinner.stopAnimating()
                self?.spinner.isHidden = true
            }
        }.resume()
    }
    
}
