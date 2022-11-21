using IMDB.Interface;
using IMDB.Models;
using Microsoft.AspNetCore.Mvc;

namespace IMDB.Controllers
{
    public class MovieController : BaseController
    {
        private readonly IMovie _movie;
        public MovieController(IMovie movie)
        {
            _movie = movie;
        }
        /// <summary>
        /// To Add or Update Movie and their details
        /// </summary>
        /// <param name="movieRequest"></param>
        /// <returns>SuccessMessage</returns>

        [Route("AddOrUpdateMovie")]
        [HttpPost]
        public Task<IActionResult> AddOrUpdateMovie(AddMovie addMovie)
        {
            return Success(_movie.AddOrUpdateMovie(addMovie));
        }

        /// <summary>
        /// To fetch Movies list
        /// </summary>
        /// <param name="movieListRequest"></param>
        /// <returns></returns>
        [Route("GetMoviesList")]
        [HttpPost]
        public Task<IActionResult> GetMoviesList(MovieListRequest moviesListRequest)
        {
            return Success(_movie.GetMoviesList(moviesListRequest));
        }

        /// <summary>
        /// To Delete Movie
        /// </summary>
        /// <param name="movieId"></param>
        /// <returns>StatusCode</returns>
        [Route("DeleteMovie")]
        [HttpPut]
        public Task<IActionResult>DeleteMovie(int movieId)
        {
            return Success(_movie.DeleteMovie(movieId));
        }

        /// <summary>
        /// To Prepopulate Movie Detail For Editing
        /// </summary>
        /// <param name="movieId"></param>
        /// <returns>Movie Details</returns>
        [Route("GetMovieDetail")]
        [HttpGet]
        public Task<IActionResult> GetMovieDetail(int movieId)
        {
            return Success(_movie.GetMovieDetail(movieId));
        }
    }
}
