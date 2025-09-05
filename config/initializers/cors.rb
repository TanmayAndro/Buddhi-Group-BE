Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173",
            "https://census-frontend-ttbh-git-main-jnvdurgas-projects.vercel.app",
            "https://buddhi-group-be.onrender.com"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
