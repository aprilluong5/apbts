import UIKit

class HomeViewController: UITableViewController {
    private var movies: [Movie] = []
    private let movieAPI = MovieAPI()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            fetchTrendingMovies()
        }
        
        private func setupUI() {
            title = "Trending Movies"
        }
        
        private func fetchTrendingMovies() {
            Task {
                do {
                    movies = try await movieAPI.fetchTrendingMovies()
                    tableView.reloadData()
                } catch {
                    print("Error fetching movies: \(error)")
                }
            }
        }
        
        // TableView methods
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
            let movie = movies[indexPath.row]
            cell.configure(with: movie)
            
            return cell
            
        }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MovieDetailViewController {
            let movie = movies[indexPath.row]
            detailVC.movie = movie
            navigationController?.pushViewController(detailVC, animated: true)
            
        }
    }
    
       
    }
