import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Properties
    
    private var resultOfSearchTableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        initSearchController()
    }

    //MARK: setupView
    
    private func setupView() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        resultOfSearchTableView.register(nib, forCellReuseIdentifier: "CustomCell")
        resultOfSearchTableView.backgroundColor = .lightGray
        resultOfSearchTableView.delegate = self
        resultOfSearchTableView.dataSource = self
        resultOfSearchTableView.frame = view.bounds
        self.title = "Search"
        view.backgroundColor = .lightGray
        view.addSubview(resultOfSearchTableView)
    }
    
    private func initSearchController() {
        searchController.isActive = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundColor = .white
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}
    
//MARK: tableView Methods

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
        cell.setupCell(state: .loading)
            cell.customLabel.text = presenter.filteredPictures[indexPath.row].nameOfImage
            presenter.loadImage(urlString: presenter.filteredPictures[indexPath.row].urlOfImage) { result in
                DispatchQueue.main.async {
                switch result {
                case .success(let someImage):
                    if let image = someImage {
                    cell.setupCell(state: .loaded(image: image))
                    }
                case .failure(_):
                    cell.setupCell(state: .failed)
                }
                }
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.filteredPictures.count
    }
}
//MARK: search settings

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        presenter.filterContentForSearch(searchText: searchText)
        resultOfSearchTableView.reloadData()
    }
}
