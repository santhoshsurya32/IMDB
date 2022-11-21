namespace IMDB.Models
{
    public class MovieListRequest
    {
        public int pageIndex { get; set; }
        public int pageSize { get; set; }
        public string searchText { get; set; }
        public List<int> actorsFilter { get; set; }
        public List<int> producersFilter { get; set; }
    }
}
