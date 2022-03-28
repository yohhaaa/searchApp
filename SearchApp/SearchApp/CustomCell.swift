import UIKit


enum CellState {
   case loading
   case loaded
   case failed
}

class CustomCell: UITableViewCell {
    
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
    func setupCell(state: CellState){
        switch state {
        case .loading:
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        case .loaded:
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        case .failed:
            self.spinner.isHidden = true
        }
    }
    
    override func prepareForReuse(){
        customImageView.image = nil
    }
  
}
