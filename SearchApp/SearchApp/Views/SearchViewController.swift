import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Properties
    
    var resultOfSearchTableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var isFiltered: Bool { return searchController.isActive && !searchBarIsEmpty }
    
    
    var present: MainViewPresenterProtocol!
    
    private var searchBarIsEmpty: Bool { guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        initSearchController()
        present.loadedImage(urlString: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP5VKFOTn-2IxmSp9pcNC_B0PHDDvNQSAeVQ&usqp=CAU")
    }
    
    //MARK: setup
    
    private func setupView() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        view.backgroundColor = .lightGray
        resultOfSearchTableView.register(nib, forCellReuseIdentifier: "CustomCell")
        resultOfSearchTableView.backgroundColor = .lightGray
        resultOfSearchTableView.delegate = self
        resultOfSearchTableView.dataSource = self
        resultOfSearchTableView.frame = view.bounds
        title = "Search"
        view.addSubview(resultOfSearchTableView)
    }
    private func initSearchController() {
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
        
        cell.setupCell(state: .loading)
        cell.customImageView.image = present?.someImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltered { return present.filteredPicturesName.count}
        
        return ImageStruct.pictures.count
    }
}

//MARK: search settings

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        present.filterContentForSearch(searchText: searchText)
        resultOfSearchTableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultOfSearchTableView.reloadData()
    }
}

//MARK: MainViewProtocol

extension SearchViewController: MainViewProtocol {
    func success() {
        resultOfSearchTableView.reloadData()
    }
    func failure(error: Error) {
        print("error")
    }
}
