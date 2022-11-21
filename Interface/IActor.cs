using IMDB.Enums;
using IMDB.Models;

namespace IMDB.Interface
{
    public interface IActor
    {
        int AddOrUpdateActor(AddActorRequest addActorRequest);
        ActorsList GetActorsList(string? searchText);
        StatusCode DeleteActor(int actorId);
        ActorDetail GetActorDetail(int actorId);
    }
}
