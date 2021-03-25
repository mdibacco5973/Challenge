using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace WebApiChallenge
{
    public class DataSet : List<Dictionary<string, object>>
    {
        public DataSet()
        {
            Columns = new List<string>();
        }

        public DataSet(IDataReader datareader) : this()
        {
            FromDataReader(datareader);
        }
        public new void Clear()
        {
            base.Clear();
            Columns.Clear();
        }

        public void FromDataReader(IDataReader datareader)
        {
            while (datareader.Read())
            {
                Dictionary<string, object> values = new Dictionary<string, object>();

                for (int t = 0; t < datareader.FieldCount; t++)
                {
                    if (values.ContainsKey(datareader.GetName(t)))
                        continue;

                    if (Count == 0)
                    {
                        Columns.Add(datareader.GetName(t));
                    }

                    values.Add(datareader.GetName(t), datareader.IsDBNull(t) ? null : datareader.GetValue(t));
                }

                this.Add(values);
            }

            datareader.Close();
        }
               

        public List<string> Columns { get; protected set; }
    }
}
