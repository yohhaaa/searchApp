import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet private weak var resultOfSearchTableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredPictures = [ImageStruct]()
    private var isFiltered: Bool { return searchController.isActive && !searchBarIsEmpty }
    private var allPictures = ImageStruct.pictures
    
    private var searchBarIsEmpty: Bool { guard let text = searchController.searchBar.text else { return false }
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
        
        searchController.searchBar.delegate = self
        searchController.isActive = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundColor = .white
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
}
    
//MARK: tableView Methods

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        
        var pictureForCell: ImageStruct
        
        if isFiltered{
            pictureForCell = filteredPictures[indexPath.row]
            
            cell.customLabel.text = pictureForCell.nameOfImage
            cell.loadImageConfigure(with: pictureForCell.urlOfImage)
        } else {
            cell.customLabel.text = allPictures[indexPath.row].nameOfImage
            cell.loadImageConfigure(with: allPictures[indexPath.row].urlOfImage) }
        
        cell.spinner.isHidden = false
        cell.spinner.color = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered { return filteredPictures.count }
        
        return allPictures.count
    }
}

//MARK: search settings

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchController.searchBar.text!)
       
    }
    
    private func filterContentForSearch(_ searchText: String) {
        filteredPictures = ImageStruct.pictures.filter({ (pic: ImageStruct) -> Bool in
            return pic.nameOfImage
                .contains(searchText)})
        if !searchBarIsEmpty {
            resultOfSearchTableView.reloadData()
        }
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultOfSearchTableView.reloadData()
    }
}
