using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace WebApiChallenge.Services
{
    public class DataService : IDataService
    {
        public static DataService NewDataService(string connectionstring)
        {
            return new DataService(connectionstring);
        }

        public DataService()
        {
        }

        public DataService(string connectionstring)
        {
            ConnectionString = connectionstring;
        }

        protected string ConnectionString { get; set; }

        public DataSet Execute(string sqlcommand, CommandType type = CommandType.Text, Array parameters = null, int timeout = 30)
        {
            SQLDataController sql = new SQLDataController(ConnectionString);
            return (sql.Execute(sqlcommand, type, parameters, timeout));
        }
    }
}
