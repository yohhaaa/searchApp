import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet private weak var resultOfSearchTableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltered: Bool { return searchController.isActive && !searchBarIsEmpty }
    private var allPictures = ImageStruct.pictures
    
    
    let network = NetworkService()
    let presenter = PresenterClass()
    
    private var searchBarIsEmpty: Bool { guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        if isFiltered{

            cell.customLabel.text = presenter.filteredPictures[indexPath.row].nameOfImage
            network.imageLoader(with: presenter.filteredPictures[indexPath.row].urlOfImage ) { image in
                switch image {
                case .success( let images):
                    cell.customImageView.image = images
                case .failure(let error):
                    cell.customImageView.image = UIImage(named: "errorLoad.jpeg")
                }
            }
        } else {
            cell.customLabel.text = allPictures[indexPath.row].nameOfImage

            network.imageLoader(with: allPictures[indexPath.row].urlOfImage ) { image in
                switch image {
                case .success( let images):
                    cell.customImageView.image = images
                case .failure(let error):
                    cell.customImageView.image = UIImage(named: "errorLoad.jpeg")
                }
            }
        }
        
        
        cell.spinner.isHidden = false
        cell.spinner.color = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered { return presenter.filteredPictures.count}
        
        return allPictures.count
    }
}

//MARK: search settings

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchController.searchBar.text!)
       
    }
    
    private func filterContentForSearch(_ searchText: String) {
        presenter.filterSearch(searchText)
        
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
