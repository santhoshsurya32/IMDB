namespace IMDB.Models
{
    public class AddProducerRequest
    {
        public int ProducerId { get; set; }
        public string ProducerName { get; set; }
        public string Bio { get; set; }
        public DateTime DOB { get; set; }
        public string Gender { get; set; }
        public string Company { get; set; }
    }
}
