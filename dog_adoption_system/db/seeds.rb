require 'net/http'
require 'json'

puts "Clearing existing data..."
Adoption.destroy_all
Dog.destroy_all
Owner.destroy_all

puts "Starting to seed data..."

puts "Fetching dog breeds from Dog API..."

def fetch_dog_breeds
  uri = URI('https://dog.ceo/api/breeds/list/all')
  response = Net::HTTP.get_response(uri)
  
  if response.code == '200'
    data = JSON.parse(response.body)
    data['message'].keys
  else
    puts "Failed to fetch breeds, using fallback list"
    ['golden retriever', 'labrador', 'poodle', 'bulldog', 'beagle']
  end
rescue => e
  puts "Error fetching breeds: #{e.message}, using fallback list"
  ['golden retriever', 'labrador', 'poodle', 'bulldog', 'beagle']
end

def fetch_dog_image(breed)
  formatted_breed = breed.downcase.gsub(' ', '')
  uri = URI("https://dog.ceo/api/breed/#{formatted_breed}/images/random")
  response = Net::HTTP.get_response(uri)
  
  if response.code == '200'
    data = JSON.parse(response.body)
    data['message']
  else
    "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg" # fallback image
  end
rescue => e
  puts "Error fetching image for #{breed}: #{e.message}"
  "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg" # fallback image
end

breeds = fetch_dog_breeds
puts "Found #{breeds.length} breeds"

dogs_created = 0
60.times do |i|
  breed = breeds.sample
  
  image_url = fetch_dog_image(breed)
  
  dog = Dog.create!(
    breed: breed.titleize,
    name: Faker::Creature::Dog.name,
    age: rand(1..12),
    image_url: image_url,
    description: "#{Faker::Lorem.sentence(word_count: 8)} This #{breed} is #{Faker::Creature::Dog.age} and loves #{Faker::Hobby.activity.downcase}.",
    available_for_adoption: [true, false].sample
  )
  
  dogs_created += 1
  print "." if (i + 1) % 10 == 0
end

puts "\nCreated #{dogs_created} dogs from Dog API data"

puts "Creating owners using Faker gem..."

owners_created = 0
40.times do
  owner = Owner.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    phone: "(#{rand(200..999)}) #{rand(200..999)}-#{rand(1000..9999)}",
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip_code
  )
  owners_created += 1
end

puts "Created #{owners_created} owners using Faker"

puts "Creating adoption records using Faker gem..."

available_dogs = Dog.where(available_for_adoption: true).to_a
all_owners = Owner.all.to_a

adoptions_created = 0
[30, available_dogs.length].min.times do
  dog_to_adopt = available_dogs.sample
  break if dog_to_adopt.nil?
  
  random_owner = all_owners.sample
  
  adoption = Adoption.create!(
    dog: dog_to_adopt,
    owner: random_owner,
    adoption_date: Faker::Date.between(from: 1.year.ago, to: Date.current),
    adoption_fee: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    notes: Faker::Lorem.paragraph(sentence_count: 2)
  )
  
  dog_to_adopt.update_column(:available_for_adoption, false)
  available_dogs.delete(dog_to_adopt)
  
  adoptions_created += 1
end

puts "Created #{adoptions_created} adoption records using Faker"

puts "\n" + "="*50
puts "SEEDING COMPLETED!"
puts "="*50
puts "Total Dogs: #{Dog.count}"
puts "  - Available for adoption: #{Dog.available.count}"
puts "  - Already adopted: #{Dog.adopted.count}"
puts "Total Owners: #{Owner.count}"
puts "Total Adoptions: #{Adoption.count}"
puts "Total Records: #{Dog.count + Owner.count + Adoption.count}"
puts "="*50

Faker::Internet.unique.clear