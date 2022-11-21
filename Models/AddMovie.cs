namespace IMDB.Models
{
    public class AddMovie
    {
        public int movieId { get; set; }
        public string Name { get; set; }
        public string Plot { get; set; }
        public DateTime ReleaseDate { get; set; }
        public int ProducerId { get; set; }
        public List<int> ActorId { get; set; }
    }
}
