# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#   allow do
#     origins '*' # Разрешить доступ к ресурсам с любых доменов
#     resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
#   end
# end