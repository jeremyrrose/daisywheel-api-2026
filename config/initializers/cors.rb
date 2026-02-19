Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    
    if Rails.env.development?
        origins 'http://localhost:5173', 'http://127.0.0.1:5173'
    else
        origins 'http://daisywheel.surge.sh', 'https://jeremy-rose.com'
    end

    resource '*', headers: :any, methods: [:get, :post, :patch, :put, :delete, :options]
  end
end