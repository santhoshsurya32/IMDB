using IMDB.Interface;
using IMDB.Models;
using Microsoft.Data.SqlClient;
using System.Data;
using System;
using IMDB.Helpers;
using IMDB.Enums;

namespace IMDB.Implementation
{
    public class MovieDataAccess : IMovie
    {
        private readonly DBcontext _dbcontext;
        public MovieDataAccess(DBcontext dbcontext)
        {
            _dbcontext = dbcontext;
        }
        private readonly string SPAddOrUpdateMovie = "AddOrUpdateMovie";
        private readonly string SPGetMoviesList = "GetMoviesList";
        private readonly string SPDeleteMovie = "DeleteMovie";
        private readonly string SPGetMovieDetails="GetMovieDetails";

        public StatusCode AddOrUpdateMovie(AddMovie addMovie)
        {
            int result = 0;
            string actorIds = string.Empty;
            if (addMovie.ActorId.Any())
            {
                actorIds = string.Join(",", addMovie.ActorId);
            }
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPAddOrUpdateMovie, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@movieId", addMovie.movieId);
                    sqlCommand.Parameters.AddWithValue("@movieName", addMovie.Name);
                    sqlCommand.Parameters.AddWithValue("@producerId", addMovie.ProducerId);
                    sqlCommand.Parameters.AddWithValue("@actorId", actorIds);
                    sqlCommand.Parameters.AddWithValue("@releaseDate", addMovie.ReleaseDate);
                    sqlCommand.Parameters.AddWithValue("@plot", addMovie.Plot);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result = !DBNull.Value.Equals(reader["MOVIEID"]) ? Convert.ToInt32(reader["MOVIEID"]) : 0;
                        }
                    }


                }
                catch (Exception ex)
                {
                    throw ex;
                }
                sqlConnection.Dispose();
                if (result != 0)
                {
                    return StatusCode.Success;
                }
                return StatusCode.Failure;
            }
        }

        public MoviesList GetMoviesList(MovieListRequest moviesListRequest)
        {
            MoviesList moviesList = new MoviesList();
            moviesList.Movies= new List<Movie>();
            string actorsFilter = string.Empty;
            string producersFilter = string.Empty;
            if (moviesListRequest.actorsFilter.Any())
            {
                actorsFilter = string.Join(",", moviesListRequest.actorsFilter);
            }
            if (moviesListRequest.producersFilter.Any())
            {
                producersFilter = string.Join(",", moviesListRequest.producersFilter);
            }
            List<int> moviesId = new List<int>();
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPGetMoviesList, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@pageIndex", moviesListRequest.pageIndex);
                    sqlCommand.Parameters.AddWithValue("@pageSize", moviesListRequest.pageSize);
                    sqlCommand.Parameters.AddWithValue("@searchText", moviesListRequest.searchText);
                    sqlCommand.Parameters.AddWithValue("@actorsFilter", actorsFilter);
                    sqlCommand.Parameters.AddWithValue("@producersFilter", producersFilter);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Movie movie= new Movie();
                            movie.MovieId = !DBNull.Value.Equals(reader["MOVIEID"]) ? Convert.ToInt32(reader["MOVIEID"]) : 0;
                            movie.MovieName = !DBNull.Value.Equals(reader["name"]) ? Convert.ToString(reader["name"]) : string.Empty ;
                            movie.ReleasedDate = !DBNull.Value.Equals(reader["ReleasedDate"]) ? Convert.ToDateTime(reader["ReleasedDate"]) : System.DateTime.Now;
                            movie.Plot = !DBNull.Value.Equals(reader["Plot"]) ? Convert.ToString(reader["Plot"]) : string.Empty;
                            movie.ProducerName = !DBNull.Value.Equals(reader["ProducerName"]) ? Convert.ToString(reader["ProducerName"]) : string.Empty;
                            movie.Actors = new List<Actor>();
                            moviesList.Movies.Add(movie);
                            moviesId.Add(movie.MovieId);
                        }
                        reader.NextResult();
                        while (reader.Read())
                        {
                            Actor actor= new Actor();
                            actor.ActorId= !DBNull.Value.Equals(reader["actorId"]) ? Convert.ToInt32(reader["actorId"]) : 0;
                            actor.ActorName= !DBNull.Value.Equals(reader["actorName"]) ? Convert.ToString(reader["actorName"]) : string.Empty;
                            int movieId= !DBNull.Value.Equals(reader["MOVIEID"]) ? Convert.ToInt32(reader["MOVIEID"]) : 0;
                            for (int i = 0;i < moviesId.Count;i++)
                            {
                                if (movieId == moviesId[i])
                                {
                                    moviesList.Movies[i].Actors.Add(actor);
                                    break;
                                }
                            }
                        }
                        reader.NextResult();
                        while (reader.Read())
                        {
                            moviesList.TotalCount = !DBNull.Value.Equals(reader["TotalMovieCount"]) ? Convert.ToInt32(reader["TotalMovieCount"]):0;
                        }
                    }

                    sqlConnection.Dispose();
                    
                }
                
                catch (Exception ex)
                {
                    throw ex;
                }
                return moviesList;
            }
        }
        public StatusCode DeleteMovie(int movieId)
        {
            int result = 0;
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPDeleteMovie, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@movieId", movieId);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result = !DBNull.Value.Equals(reader["MOVIEID"]) ? Convert.ToInt32(reader["MOVIEID"]) : 0;
                        }
                    }


                }
                catch (Exception ex)
                {
                    throw ex;
                }
                sqlConnection.Dispose();
                if (result != 0)
                {
                    return StatusCode.Success;
                }
                return StatusCode.Failure;
            }

        }
        public Movie GetMovieDetail(int movieId)
        {
            Movie movie = new Movie();
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPGetMovieDetails, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@movieId", movieId);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            movie.MovieId = !DBNull.Value.Equals(reader["movieId"]) ? Convert.ToInt32(reader["movieId"]) : 0;
                            movie.MovieName = !DBNull.Value.Equals(reader["Name"]) ? Convert.ToString(reader["Name"]) : string.Empty;
                            movie.ProducerName = !DBNull.Value.Equals(reader["ProducerName"]) ? Convert.ToString(reader["ProducerName"]) : string.Empty;
                            movie.Plot = !DBNull.Value.Equals(reader["plot"]) ? Convert.ToString(reader["Plot"]) : string.Empty;
                            movie.ReleasedDate = !DBNull.Value.Equals(reader["ReleaseDate"]) ? Convert.ToDateTime(reader["ReleaseDate"]) : System.DateTime.MinValue;
                            movie.Actors = new List<Actor>();
                        }
                        reader.NextResult();
                        while (reader.Read())
                        {
                            Actor actor = new Actor();
                            actor.ActorId = !DBNull.Value.Equals(reader["actorId"]) ? Convert.ToInt32(reader["actorId"]) : 0;
                            actor.ActorName = !DBNull.Value.Equals(reader["actorName"]) ? Convert.ToString(reader["actorName"]) : string.Empty;
                            movie.Actors.Add(actor);
                        }
                    }
                    
                    sqlConnection.Dispose();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                return movie;
            }

        }
    }


}
