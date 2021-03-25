using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using System;

namespace WebApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            if (Environment.GetEnvironmentVariable("PORT") != null
                && Environment.GetEnvironmentVariable("PORT") != ""
                && Environment.GetEnvironmentVariable("PORT") != "80")
            {
                BuildWebHostPort(args).Run();
            }
            else
            {
                BuildWebHost(args).Run();
            }
        }

        public static IWebHost BuildWebHostPort(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseKestrel()
                .UseIISIntegration()
                .UseUrls("http://*:" + Environment.GetEnvironmentVariable("PORT"))
                .UseStartup<Startup>()
                .Build();

        public static IWebHost BuildWebHost(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .Build();
    }
}
