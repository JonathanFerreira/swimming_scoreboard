# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


user = User.create!(email: 'admin@example.com', password: 'password')

competition = Competition.create!(
  name: 'Competição 1',
  event_initial_date: Date.today,
  event_final_date: Date.today + 1.day,
  address: 'Endereço 1',
  description: 'Descrição 1'
)

teams = []
['Time 1', 'Time 2', 'Time 3'].each do |team_name|
  teams << Team.create!(name: team_name)
end

categories = []
[
  { name: 'Categoria 0 - 1', age_min: 0, age_max: 10 },
  { name: 'Categoria 10 - 15', age_min: 11, age_max: 15 },
  { name: 'Categoria 16 - 20', age_min: 16, age_max: 20 },
  { name: 'Categoria 21 - 25', age_min: 21, age_max: 25 },
  { name: 'Categoria 26 - 30', age_min: 26, age_max: 30 },
  { name: 'Categoria 31 - 35', age_min: 31, age_max: 35 },
  { name: 'Categoria 36 - 40', age_min: 36, age_max: 40 },
  { name: 'Categoria 41 - 45', age_min: 41, age_max: 45 },
  { name: 'Categoria 46 - 50', age_min: 46, age_max: 50 },
  { name: 'Categoria 51 - 55', age_min: 51, age_max: 55 },
  { name: 'Categoria 56 - 60', age_min: 56, age_max: 60 },
].each do |category_data|
  categories << Category.create!(category_data)
end

proofs = []
[
  { name: '25 Livre', slug: 'prova-1', competition_id: competition.id },
  { name: '25 Peito', slug: 'prova-2', competition_id: competition.id },
  { name: '25 Costas', slug: 'prova-3', competition_id: competition.id },
  { name: '25 Borboleta', slug: 'prova-3', competition_id: competition.id },
].each do |proof_data|
  proofs << Proof.create!(proof_data)
end

swimmers = []
[
  { name: 'Nadador 1', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 2', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 3', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 4', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 5', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 6', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 7', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 8', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 9', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 10', phone_number: '1234567890', birthdate: Date.today - 10.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 11', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 12', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 13', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 14', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 15', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 16', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 17', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 18', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 19', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 20', phone_number: '1234567890', birthdate: Date.today - 16.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 21', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 22', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 23', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 24', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 25', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 26', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 27', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 28', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 29', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 30', phone_number: '1234567890', birthdate: Date.today - 21.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 31', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 32', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 33', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 34', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 35', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 36', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 37', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 38', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 39', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 40', phone_number: '1234567890', birthdate: Date.today - 26.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 41', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 42', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 43', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 44', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 45', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 46', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 47', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 48', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 49', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 50', phone_number: '1234567890', birthdate: Date.today - 31.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 51', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 52', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 53', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 54', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 55', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 56', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 57', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 58', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 59', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 60', phone_number: '1234567890', birthdate: Date.today - 36.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 61', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 62', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 63', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 64', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 65', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 66', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 67', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 68', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 69', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 70', phone_number: '1234567890', birthdate: Date.today - 41.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 71', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 72', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 73', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 74', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 75', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 76', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 77', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 78', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 79', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 80', phone_number: '1234567890', birthdate: Date.today - 46.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 81', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 82', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 83', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 84', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 85', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 86', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 87', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 88', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 89', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 90', phone_number: '1234567890', birthdate: Date.today - 51.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },

  { name: 'Nadador 91', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 92', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 93', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 94', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 95', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 96', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 97', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 98', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 99', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id },
  { name: 'Nadador 100', phone_number: '1234567890', birthdate: Date.today - 56.years, gender: Swimmer.genders.keys.sample, team_id: teams.sample.id }

].each do |swimmer_data|
  swimmers << Swimmer.create!(swimmer_data)
end

puts 'Swimmers created successfully'
puts "Total swimmers: #{Swimmer.count}"
puts "Total teams: #{Team.count}"
puts "Total categories: #{Category.count}"
puts "Total proofs: #{Proof.count}"
puts "Total competitions: #{Competition.count}"
