json.extract! meal, :id, :title, :date, :mealtime, :start_date,:end_date, :created_at, :updated_at
json.url meal_url(meal, format: :json)