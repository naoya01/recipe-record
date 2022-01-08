json.extract! meal, :id, :title, :meal_description, :date, :mealtime,:start_date,:end_date, :created_at, :updated_at
json.url meal_url(meal, format: :json)