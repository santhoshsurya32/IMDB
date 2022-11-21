using IMDB.Implementation;
using IMDB.Interface;
using IMDB.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Numerics;

namespace IMDB.Controllers
{
    public class ProducerController : BaseController
    {
        private readonly IProducer _producer;

        public ProducerController(IProducer producer)
        {
            _producer = producer;
        }

        /// <summary>
        /// API for add or update producer and their details
        /// </summary>
        /// <param name="addProducerRequest"></param>
        /// <returns>StatusCode</returns>
        [HttpPost]
        [Route("AddOrUpdateProducer")]
        public Task<IActionResult> AddOrUpdateProducer(AddProducerRequest addProducerRequest) {
            return Success(_producer.AddOrUpdateProducer(addProducerRequest));
        }

        /// <summary>
        /// API to fetch list of Producers to Add in movie
        /// </summary>
        /// <param name="searchText"></param>
        /// <returns>Producers List</returns>
        [HttpGet]
        [Route("GetProducersList")]
        public Task<IActionResult> GetProducersList(string? searchText)
        {
            return Success(_producer.GetProducerList(searchText));
        }

        /// <summary>
        /// To delete Producer
        /// </summary>
        /// <param name="producerId"></param>
        /// <returns>StatusCode</returns>
        [Route("DeleteProducer")]
        [HttpPut]
        public Task<IActionResult> DeleteProducer(int producerId)
        {
            return Success(_producer.DeleteProducer(producerId));
        }

        /// <summary>
        /// To Prepopulate Producer Detail For Editing
        /// </summary>
        /// <param name="producerId"></param>
        /// <returns>Producer Details</returns>
        [Route("GetProducerDetail")]
        [HttpGet]
        public Task<IActionResult> GetProducerDetail(int producerId)
        {
            return Success(_producer.GetProducerDetail(producerId));
        }
    }
}
