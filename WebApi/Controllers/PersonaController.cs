using System;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using WebApi;
using WebApiChallenge.Services;
using System.Text.Json;
using System.Text.Json.Serialization;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.Data;

namespace WebApiChallenge.Controllers
{

    [Route("[controller]")]
    [Produces("application/json")]
    public class PersonaController : Controller
    {
        private readonly ILogger<PersonaController> _logger;

        public PersonaController(ILogger<PersonaController> logger)
        {
            _logger = logger;
        }


        [HttpPost]
        public dynamic Post([FromBody] dynamic json)
        {
            try
            {
                dynamic oJsonRequest = JsonConvert.DeserializeObject(json.ToString());

                string metodo = oJsonRequest.Metodo.ToString();
                Persona oData = new Persona();
                oData = JsonConvert.DeserializeObject<Persona>(oJsonRequest.Data.ToString());

                DataService dbService = DataService.NewDataService("User ID=Prueba;Password=Temporal01;Persist Security Info=False;Initial Catalog=Challenge;Data Source=DESKTOP-F8OQPIA\\TEW_SQLEXPRESS;");

                Array parameters = new SqlParameter[] {
                    new SqlParameter("@id", oData.Id),
                    new SqlParameter("@FirstName", oData.FirstName),
                    new SqlParameter("@LastName", oData.LastName),
                    new SqlParameter("@Company", oData.Company),
                    new SqlParameter("@Email", oData.Email),
                    new SqlParameter("@PhoneNumber", oData.PhoneNumber)
                };

                string sp = "";
                if (metodo == "GET")
                {
                    sp = "Persona_g";
                }
                if (metodo == "INS")
                {
                    sp = "Persona_i";
                }
                if (metodo == "UPD")
                {
                    sp = "Persona_u";
                }
                if (metodo == "DEL")
                {
                    sp = "Persona_d";
                }

                WebApiChallenge.DataSet ds = dbService.Execute(sp, CommandType.StoredProcedure, parameters);
                if (ds.Count == 0)
                {
                    return null;
                }

                return JsonConvert.SerializeObject(ds);
            }
            catch (DataControllerException e)
            {
                return null;
            }
            catch (Exception e)
            {
                return null;
            }
        }

    }
}
