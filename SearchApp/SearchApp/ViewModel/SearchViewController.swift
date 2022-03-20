import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet private weak var resultOfSearchTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPictures = [ImageStruct]()
    var isFiltered: Bool { return searchController.isActive && !searchBarIsEmpty }
    var searchBarIsEmpty: Bool { guard let text = searchController.searchBar.text else {return false}
        
        return text.isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    //MARK: setup
    
    private func setup() {
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        view.backgroundColor = .lightGray
        
        resultOfSearchTableView.register(nib, forCellReuseIdentifier: "CustomCell")
        resultOfSearchTableView.backgroundColor = .lightGray
        resultOfSearchTableView.delegate = self
        resultOfSearchTableView.dataSource = self
        
        searchController.isActive = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    
}
    
//MARK: tableView Methods

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {return UITableViewCell()}
        
        var pictureForCell: ImageStruct
        cell.spinner.color = .white
        cell.spinner.startAnimating()
        
        
        if isFiltered{
            pictureForCell = filteredPictures[indexPath.row]
            cell.customLabel.text = pictureForCell.nameOfImage
            cell.customImageView.backgroundColor = .gray
            cell.configure(with: pictureForCell.urlOfImage)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered { return filteredPictures.count }
        else {return 0}
    }
    
    
}
//MARK: search settings
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearch(searchController.searchBar.text!)
        
    }
    
    func filterContentForSearch(_ searchText: String) {
        
        filteredPictures = ImageStruct.pictures.filter({ (pic:ImageStruct) -> Bool in
            
            return pic.nameOfImage.lowercased().contains(searchText.lowercased())
        })
        
        self.resultOfSearchTableView.reloadData()
    }
}

//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

