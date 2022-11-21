using IMDB.Enums;
using IMDB.Interface;
using IMDB.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace IMDB.Implementation
{
    public class ProducerDataAccess:IProducer
    {
        private readonly DBcontext _dbcontext;

        private readonly string SPAddOrUpdateProducer = "AddOrUpdateProducer";
        private readonly string SPGetProducerList = "GetProducerList";
        private readonly string SPDeleteProducer= "DeleteProducer";
        private readonly string SPGetProducerDetails = "GetProducerDetails";
        public ProducerDataAccess(DBcontext dBcontext)
        {
            _dbcontext = dBcontext;
        }

        public StatusCode AddOrUpdateProducer(AddProducerRequest addProducerRequest)
        {
            int result = 0;
            using(SqlConnection sqlConnection =new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPAddOrUpdateProducer, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@ProducerId", addProducerRequest.ProducerId);
                    sqlCommand.Parameters.AddWithValue("@ProducerName",addProducerRequest.ProducerName);
                    sqlCommand.Parameters.AddWithValue("@Bio",addProducerRequest.Bio);
                    sqlCommand.Parameters.AddWithValue("@DOB",addProducerRequest.DOB);
                    sqlCommand.Parameters.AddWithValue("@Gender",addProducerRequest.Gender);
                    sqlCommand.Parameters.AddWithValue("@Company",addProducerRequest.Company);
                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result = !DBNull.Value.Equals(reader["ProducerId"]) ? Convert.ToInt32(reader["ProducerId"]) : 0;
                        }
                    }
                    sqlCommand.Dispose();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                if (result != 0)
                {
                    return StatusCode.Success;
                }
                return StatusCode.Failure;
            }

        }
        public ProducerList GetProducerList(string? searchText)
        {
            ProducerList producerlist = new ProducerList
            {
                Name = "ProducersList",
                Producers = new List<Response>()
            };
            using (SqlConnection sqlConnection=new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPGetProducerList, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@SearchText", searchText);
                    using(SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Response response =new Response();
                            response.Value = !DBNull.Value.Equals(reader["value"]) ? Convert.ToInt32(reader["value"]) : 0;
                            response.Name = !DBNull.Value.Equals(reader["Name"]) ? Convert.ToString(reader["Name"]) : string.Empty;
                            producerlist.Producers.Add(response);
                        }

                    }
                    sqlCommand.Dispose();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return producerlist;
        }
        public StatusCode DeleteProducer(int producerId)
        {
            int result = 0;
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPDeleteProducer, sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@producerId", producerId);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result = !DBNull.Value.Equals(reader["producerId"]) ? Convert.ToInt32(reader["producerId"]) : 0;
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
        public ProducerDetail GetProducerDetail(int producerId )
        {
            ProducerDetail producerDetail = new ProducerDetail();
            using (SqlConnection sqlConnection = new SqlConnection(_dbcontext.IMDB))
            {
                try
                {
                    SqlCommand sqlCommand = new SqlCommand(SPGetProducerDetails , sqlConnection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    sqlConnection.Open();
                    sqlCommand.Parameters.AddWithValue("@producerId", producerId);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            producerDetail.ProducerId = !DBNull.Value.Equals(reader["ProducerId"]) ? Convert.ToInt32(reader["ProducerId"]) : 0;
                            producerDetail.ProducerName = !DBNull.Value.Equals(reader["ProducerName"]) ? Convert.ToString(reader["ProducerName"]) : string.Empty;
                            producerDetail.Gender = !DBNull.Value.Equals(reader["Gender"]) ? Convert.ToString(reader["Gender"]) : string.Empty;
                            producerDetail.Bio = !DBNull.Value.Equals(reader["Bio"]) ? Convert.ToString(reader["Bio"]) : string.Empty;
                            producerDetail.DOB = !DBNull.Value.Equals(reader["DOB"]) ? Convert.ToDateTime(reader["DOB"]) : System.DateTime.MinValue;
                            producerDetail.Company= !DBNull.Value.Equals(reader["Company"]) ? Convert.ToString(reader["Company"]) : string.Empty;
                        }
                    }
                    sqlConnection.Dispose();

                }
                catch (Exception ex)
                {
                    throw ex;
                }
                return producerDetail;
            }

        }
    }
}
