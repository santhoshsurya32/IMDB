namespace IMDB.Models
{
    public class ResultModel<T>
    {
        public T Result { get; set; }
        public dynamic Errors { get; set; }
        public string Message { get; set; }
    }
}
