require 'json'
require 'factory_bot'
require 'faker'

residents = (1..100).map do |index|
  {
    id: index, 
    name: Faker::Name.name
  }
end

def create_residency(index)
  {
    id: index,
    name: Faker::Company.name,
    address: {
      street: Faker::Address.street_address,
      zip: [Faker::Address.zip_code, Faker::Address.postcode].sample,
      city: Faker::Address.city,
      country: Faker::Address.country
    },
    capacity: Random.new.rand(100),
    residency_type: ["nursing", "retirement"].sample
  }
end

def create_staff_for(residency, role)
  {
    id: Random.new.rand(10000000),
    residency_id: residency[:id],
    full_name: Faker::Name.name,
    staff_role: role
  }
end

staff = []
residencies = []
(1..100).each do |index|
  new_residency = create_residency(index)
  staff << create_staff_for(new_residency, "manager")
  staff << create_staff_for(new_residency, "caregiver")
  staff << create_staff_for(new_residency, "cook")
  
  #if(residency[:residency_type] == "nursing") do
    (1..new_residency[:capacity]/15).each do |index|
      staff << create_staff_for(new_residency, "head nurse")
    end
  #end

  residencies << new_residency
end


File.open("generated/residents.json","w") do |f|
  f.write(JSON.pretty_generate(residents))
end

File.open("generated/residency.json","w") do |f|
  f.write(JSON.pretty_generate(residencies))
end

File.open("generated/staff.json","w") do |f|
  f.write(JSON.pretty_generate(staff))
end
