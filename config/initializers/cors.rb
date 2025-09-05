Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173",
            "https://census-frontend-ttbh.vercel.app", # ✅ Production Vercel domain
            "https://census-frontend-ttbh-git-main-jnvdurgas-projects.vercel.app", # Preview domain
            "https://buddhi-group-be.onrender.com"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
