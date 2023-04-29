using Azure.Data.Tables;
using BadAdvisor.Mvc.Data;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;

namespace BadAdvisor.Mvc
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddScoped<IMessagesRepository, MessagesRepository>();
            var storageAccountUrl = Configuration.GetValue<string>("StorageAccountUrl");
            var storageAccountAccessKey = Configuration.GetValue<string>("StorageAccountAccessKey");
            //var storageAccountUrl = Environment.GetEnvironmentVariable("StorageAccountUrl");
            //var storageAccountAccessKey = Environment.GetEnvironmentVariable("StorageAccountAccessKey");
            services.AddSingleton(_ =>
            {
                var tableClient = new TableClient(
                    new Uri(storageAccountUrl),
                    "commitmessage",
                    new TableSharedKeyCredential("mytrdevmiseastus", storageAccountAccessKey));

                return tableClient;
            });

            services.AddControllersWithViews();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
            });
        }
    }
}
