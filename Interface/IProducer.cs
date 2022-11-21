using IMDB.Enums;
using IMDB.Models;

namespace IMDB.Interface
{
    public interface IProducer
    {
        StatusCode AddOrUpdateProducer(AddProducerRequest addProducerRequest);
        ProducerList GetProducerList(string searchText);
        StatusCode DeleteProducer(int producerId);
        ProducerDetail GetProducerDetail(int producerId);
    }
}
