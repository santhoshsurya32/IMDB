namespace IMDB.Models
{
    public class AddActorRequest
    {
        public int ActorId { get; set; }
        public string ActorName { get; set; }
        public string Bio { get; set; }
        public DateTime DOB { get; set; }
        public string Gender { get; set; }

    }
}
