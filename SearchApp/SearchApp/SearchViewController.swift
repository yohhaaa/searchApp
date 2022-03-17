import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Properties
    var result: ImageStruct!
    
    let pictures = [
        ImageStruct(nameOfImage: "0", urlOfImage: "https://static.wikia.nocookie.net/naruto/images/d/dd/Naruto_Uzumaki%21%21.png/revision/latest?cb=20170816203155&path-prefix=ru"),
        ImageStruct(nameOfImage: "1", urlOfImage: "https://static.wikia.nocookie.net/naruto/images/0/09/Naruto_newshot.png/revision/latest?cb=20210213224703&path-prefix=ru"),
        ImageStruct(nameOfImage: "11", urlOfImage: "https://static.wikia.nocookie.net/naruto/images/3/36/Naruto_Uzumaki.png/revision/latest?cb=20210822183225&path-prefix=ru")
    ]
    
    @IBOutlet private weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredPictures = [ImageStruct]()
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
   
    //MARK: setup
    
    private func setup() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        view.backgroundColor = .lightGray
        tableView.register(nib, forCellReuseIdentifier: "CustomCell")
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = .lightGray
        
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
        
        
        var picture: ImageStruct
        
        if isFiltered{
            picture = filteredPictures[indexPath.row]
        }
        else{
            picture = pictures[indexPath.row]
        }
        
        cell.pictureName.text = picture.nameOfImage
        cell.picture.backgroundColor = .gray
        
        
        DispatchQueue.main.async {
            let url = URL(string: picture.urlOfImage)
            if let data = try? Data(contentsOf: url!)
            {
            cell.picture.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredPictures.count
        }
            return pictures.count
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchController.searchBar.text!)
    }
    
    func filterContentForSearch(_ searchText: String) {
        
        filteredPictures = pictures.filter({ (pic:ImageStruct) -> Bool in
            return pic.nameOfImage.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
        
        
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    }
}
