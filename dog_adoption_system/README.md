# Dog Adoption Management System

## Project Description

This Ruby on Rails application manages a dog adoption system using data from multiple sources.

### Data Sources

1. **Dog API** (https://dog.ceo/dog-api/) 
   - Provides dog breed information and images
   - Used to populate the Dogs table with breed data and photos

2. **Faker Gem**
   - Generates realistic owner information (names, emails, addresses, phone numbers)
   - Creates adoption records with dates and fees

### Database Structure

- **Dogs**: breed, name, age, image_url, description, available_for_adoption
- **Owners**: name, email, phone, address  
- **Adoptions**: dog_id, owner_id, adoption_date, adoption_fee

### Relationships

- Dogs and Owners have a many-to-many relationship through Adoptions
- Each adoption record tracks when a dog was adopted, by whom, and for what fee
- Dogs can be available for adoption or already adopted

### Features

This application will allow users to:
- Browse available dogs for adoption
- View detailed information about each dog including photos
- Search dogs by breed, age, or availability
- View adoption history and owner information
- Navigate through paginated lists of dogs and owners.
