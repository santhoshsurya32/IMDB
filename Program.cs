using IMDB;
using IMDB.Implementation;
using IMDB.Interface;

var builder = WebApplication.CreateBuilder(args);

var connection = builder.Configuration.GetSection("ConnectionStrings").Get<DBcontext>();
builder.Services.AddSingleton(connection);
builder.Services.AddScoped<IProducer, ProducerDataAccess>();
builder.Services.AddScoped<IActor, ActorDataAccess>();
builder.Services.AddScoped<IMovie, MovieDataAccess>();

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
