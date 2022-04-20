import UIKit


class CustomCell: UITableViewCell {
    
    enum CellState {
        case loading
        case loaded(image: UIImage)
        case failed
    }
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var customCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customCellView.backgroundColor = .lightGray
        customImageView.backgroundColor = .gray
        spinner.color = .white
    }
    
    override func prepareForReuse(){
        customImageView.image = nil
    }
    
    func setupCell(state: CellState){
        switch state {
            case .loading:
            self.spinner.startAnimating()
                self.spinner.isHidden = false

            case .failed:
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.customImageView.image = UIImage(named: "errorLoad.jpeg")
            
            case .loaded(let image):
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.customImageView.image = image
        }
    }
}
