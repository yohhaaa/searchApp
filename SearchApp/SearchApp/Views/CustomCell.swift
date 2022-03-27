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
  
}
