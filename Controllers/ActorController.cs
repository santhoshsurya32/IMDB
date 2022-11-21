using IMDB.Interface;
using IMDB.Models;
using Microsoft.AspNetCore.Mvc;

namespace IMDB.Controllers
{
    public class ActorController : BaseController
    {
        private readonly IActor _actor;
        public ActorController(IActor actor)
        {
            _actor = actor;
        }

        /// <summary>
        /// API for add or update Actor and their details
        /// </summary>
        /// <param name="addActorRequest"></param>
        /// <returns>ActorId</returns>
        [HttpPost]
        [Route("AddOrUpdateActor")]
        public Task<IActionResult> AddOrUpdateActor(AddActorRequest addActorRequest)
        {
            
            return Success(_actor.AddOrUpdateActor(addActorRequest));
        }

        /// <summary>
        /// API to fetch list of Actors to Add in movie
        /// </summary>
        /// <param name="searchText"></param>
        /// <returns>Actors List</returns>
        [HttpGet]
        [Route("GetActorsList")]
        public Task<IActionResult> GetActorsList(string? searchText)
        {
            return Success(_actor.GetActorsList(searchText));
        }

        /// <summary>
        /// To Delete a Actor
        /// </summary>
        /// <param name="actorId"></param>
        /// <returns>StatusCode</returns>
        [Route("DeleteActor")]
        [HttpPut]
        public Task<IActionResult> DeleteActor(int actorId)
        {
            return Success(_actor.DeleteActor(actorId));
        }

        /// <summary>
        /// To Prepopulate Actor Detail For Editing
        /// </summary>
        /// <param name="actorId"></param>
        /// <returns>ActorDetails</returns>
        [Route("GetActorDetail")]
        [HttpGet]
        public Task<IActionResult> GetActorDetail(int actorId)
        {
            return Success(_actor.GetActorDetail(actorId));
        }
    }
}
