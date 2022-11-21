using IMDB.Enums;
using IMDB.Models;

namespace IMDB.Interface
{
    public interface IMovie
    {
        StatusCode AddOrUpdateMovie(AddMovie addMovie);
        MoviesList GetMoviesList(MovieListRequest moviesListRequest);
        StatusCode DeleteMovie(int movieId);
        Movie GetMovieDetail(int movieId);
    }
}
