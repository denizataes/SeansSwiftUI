import Foundation
import TMDBSwift


class AllFilmViewModel: ObservableObject{
    
    let service = FilmService()
    
    @Published var popularMovies = [Movie]()
    @Published var nowPlayingMovies = [Movie]()
    @Published var upComingMovies = [Movie]()
    @Published var topRatedMovies = [Movie]()
    
    init()
    {
        fetchPopularMovies()
        fetchNowPlayingMovies()
        fetchUpComingMovies()
        fetchTopRatedMovies()
    }
    
    func fetchPopularMovies()
    {
        service.fetchPopularMovies { movies in
            self.popularMovies = movies
        }
    }
    
    func fetchNowPlayingMovies()
    {
        service.fetchNowPlaying { movies in
            self.nowPlayingMovies = movies
        }
    }
    
    func fetchUpComingMovies()
    {
        service.fetchUpComing { movies in
            self.upComingMovies = movies
        }
    }
    
    func fetchTopRatedMovies()
    {
        service.fetchTopRated { movies in
            self.topRatedMovies = movies
        }
    }
}
