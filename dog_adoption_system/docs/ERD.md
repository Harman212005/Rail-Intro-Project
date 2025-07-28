# Database ERD - Dog Adoption System

## Tables

### Dogs Table
- id (Primary Key)
- breed (string)
- name (string)
- age (integer) 
- image_url (string)
- description (text)
- available_for_adoption (boolean)
- created_at, updated_at (timestamps)

### Owners Table  
- id (Primary Key)
- name (string)
- email (string)
- phone (string)
- address (string)
- city (string)
- state (string)
- zip_code (string)
- created_at, updated_at (timestamps)

### Adoptions Table (Join Table)
- id (Primary Key)
- dog_id (Foreign Key to Dogs)
- owner_id (Foreign Key to Owners)
- adoption_date (date)
- adoption_fee (decimal)
- notes (text)
- created_at, updated_at (timestamps)

## Relationships
- Dogs have many Adoptions
- Owners have many Adoptions  
- Dogs have many Owners through Adoptions (many-to-many)
- Owners have many Dogs through Adoptions (many-to-many)