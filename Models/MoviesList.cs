namespace IMDB.Models
{
    public class MoviesList
    {
        public int TotalCount { get; set; }
        public List<Movie> Movies { get; set;}
    }
    public class Movie
    {
        public int MovieId { get; set;}
        public string MovieName { get; set;}
        public DateTime ReleasedDate { get; set; }
        public string Plot{ get; set;}
        public string ProducerName { get; set;}
        public List<Actor> Actors { get; set;}
    }
    public class Actor
    {
        public int ActorId { get; set;}
        public string ActorName { get; set;}
    }
}
