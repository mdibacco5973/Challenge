using System;
using System.Collections.Generic;
using System.Text;

namespace WebApiChallenge
{
    public class DataControllerException : Exception
    {
        public DataControllerException()
        {
        }

        public DataControllerException(string message) : base(message)
        {
        }
    }
}
