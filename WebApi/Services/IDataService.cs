using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace WebApiChallenge.Services
{
    public interface IDataService
    {
        DataSet Execute(string sqlcommand, CommandType type = CommandType.Text, Array parameters = null, int timeout = 30);
    }
}
