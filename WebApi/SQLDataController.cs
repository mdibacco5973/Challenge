using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Text;

namespace WebApiChallenge
{
    public class SQLDataController
    {
        public SQLDataController(string connectionString)
        {
            m_connectionString = connectionString;
        }

        protected void Connect()
        {
            if (m_dbconnection != null)
            {
                if (m_dbconnection.State == System.Data.ConnectionState.Open)
                    return;

                m_dbconnection.Close();
                m_dbconnection = null;
            }

            try
            {
                m_dbconnection = new SqlConnection(m_connectionString);
                m_dbconnection.Open();
            }
            catch (Exception e)
            {
                throw (new DataControllerException(e.Message));
            }
        }

        public DataSet Execute(string sqlcommand, CommandType type = CommandType.Text, Array parameters = null, int timeout = 30)
        {
            Connect();

            SqlCommand command = new SqlCommand(sqlcommand, m_dbconnection);
            command.CommandType = type;

            try
            {
                command.CommandTimeout = timeout;

                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }

                SqlDataReader reader = command.ExecuteReader();

                return (new DataSet(reader));
            }
            catch (SqlException ex)
            {
                throw (new DataControllerException(ex.Message + " [" + sqlcommand + "]"));
            }
            catch (Exception e)
            {
                throw (new DataControllerException(e.Message + " [" + sqlcommand + "]"));
            }
            finally
            {
                m_dbconnection.Close();
                m_dbconnection = null;
            }
        }

        string m_connectionString = null;
        SqlConnection m_dbconnection = null;
    }
}
