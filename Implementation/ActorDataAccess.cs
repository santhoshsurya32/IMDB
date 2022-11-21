using IMDB.Enums;
using IMDB.Interface;
using IMDB.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace IMDB.Implementation
{
    public class ActorDataAccess:IActor
    {
        private readonly DBcontext _dbcontext;

        private readonly string SPAddOrUpdateActor = "AddOrUpdateActor";
        private readonly string SPGetActorList = "GetActorList";
        private readonly string SPDeleteActor = "DeleteActor";
        private readonly string SPGetActorDetails = "GetActorDetails";
        public ActorDataAccess(DBcontext dBcontext)
        {
            _dbcontext= dBcontext;
        }
        public int AddOrUpdateActor(AddActorRequest addActorRequest)
        {
            int result = 0;
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPAddOrUpdateActor, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@ActorId", addActorRequest.ActorId );
                    sqlCommand.Parameters.AddWithValue("@ActorName", addActorRequest.ActorName);
                    sqlCommand.Parameters.AddWithValue("@Bio", addActorRequest.Bio);
                    sqlCommand.Parameters.AddWithValue("@DOB", addActorRequest.DOB);
                    sqlCommand.Parameters.AddWithValue("@Gender", addActorRequest.Gender);
                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result = !DBNull.Value.Equals(reader["ActorId"]) ? Convert.ToInt32(reader["ActorId"]) : 0;
                        }
                    }
                    
      
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                sqlConnection.Dispose();
                return result;
                
            }

        }
        public ActorsList GetActorsList(string? searchText)
        {
            ActorsList actorslist = new ActorsList
            {
                Name = "ActorsList",
                Actors = new List<Response>()
            };
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPGetActorList, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@SearchText", searchText);
                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Response response = new Response();
                            response.Value = !DBNull.Value.Equals(reader["value"]) ? Convert.ToInt32(reader["value"]) : 0;
                            response.Name = !DBNull.Value.Equals(reader["Name"]) ? Convert.ToString(reader["Name"]) : string.Empty;
                            actorslist.Actors.Add(response);
                        }

                    }
                    sqlCommand.Dispose();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return actorslist;
        }
        public StatusCode DeleteActor(int actorId)
        {
            int result = 0;
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPDeleteActor, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@actorId", actorId);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result = !DBNull.Value.Equals(reader["actorId"]) ? Convert.ToInt32(reader["actorId"]) : 0;
                        }
                    }


                }
                catch (Exception ex)
                {
                    throw ex;
                }
                sqlConnection.Dispose();
                if (result != 0)
                {
                    return StatusCode.Success;
                }
                return StatusCode.Failure;
            }

        }
        public ActorDetail GetActorDetail(int actorId)
        {
            ActorDetail actorDetail= new ActorDetail();
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPGetActorDetails, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@actorId", actorId);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            actorDetail.ActorId = !DBNull.Value.Equals(reader["actorId"]) ? Convert.ToInt32(reader["actorId"]) : 0;
                            actorDetail.ActorName = !DBNull.Value.Equals(reader["ActorName"]) ? Convert.ToString(reader["ActorName"]) : string.Empty;
                            actorDetail.Gender = !DBNull.Value.Equals(reader["Gender"]) ? Convert.ToString(reader["Gender"]) : string.Empty;
                            actorDetail.Bio = !DBNull.Value.Equals(reader["Bio"]) ? Convert.ToString(reader["Bio"]) : string.Empty;
                            actorDetail.DOB = !DBNull.Value.Equals(reader["DOB"]) ? Convert.ToDateTime(reader["DOB"]):System.DateTime.MinValue;
                        }
                    }
                    sqlConnection.Dispose();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                return actorDetail;
            }

        }
    }
}
