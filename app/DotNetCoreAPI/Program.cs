var builder = WebApplication.CreateBuilder(args);

// Services
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Endpoints
app.MapGet("/health", () => Results.Ok(new
{
    status = "Healthy",
    timestamp = DateTime.UtcNow
}))
.WithOpenApi();

app.MapGet("/api/info", () => Results.Ok(new
{
    application = "Sample API",
    environment = app.Environment.EnvironmentName,
    version = "1.0.0"
}))
.WithOpenApi();

app.Run();