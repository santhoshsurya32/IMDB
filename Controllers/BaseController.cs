using IMDB.Models;

using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace IMDB.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BaseController : ControllerBase
    {
        public async Task<IActionResult> Success<T>(T result)
        {
            return await Task.FromResult(Ok(PrepareResult(result)));
        }
        private ResultModel<T> PrepareResult<T>(T obj=default(T),dynamic errors=default,string message = default)
        {
            return new ResultModel<T>()
            {
                Result = obj,
                Errors = errors,
                Message = message
            };
        }
        
 

    }
}