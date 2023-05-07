-- 1. Create the database (schema)
create schema Cocktails charset hebrew;

-- 2. Use the DB
use Cocktails;

-- 3. Create table Cocktail_Name
Create table Cocktail_Name(
	cocktail_name_id integer primary key auto_increment,
    cocktail_name varchar(50) not null
);

-- 4. Create table Ingredients
Create table Ingredients(
	ingredient_id integer primary key auto_increment,
    ingredient_name varchar(50) not null
);

-- 5. Create table Measurements 
Create table Measurements(
	measurement_id integer primary key auto_increment,
    measurement_name varchar(50) not null
);

-- 6. Create table Method
Create table Method(
	method_id integer primary key auto_increment,
    method_name varchar(50) not null
);

-- 7. Create table Garnish
Create table Garnish(
	garnish_id integer primary key auto_increment,
    garnish_name varchar(50) not null
);

-- 8. Create table Top_Up
Create table Top_Up(
	top_up_id integer primary key auto_increment,
    top_up_name varchar(50) not null
);

-- 9. Create table Drink_Type
Create table Drink_Type(
	drink_type_id integer primary key auto_increment,
    drink_type_name varchar(50) not null
);

-- 10. Create table Glass_Type
Create table Glass_Type(
	glass_type_id integer primary key auto_increment,
    glass_type_name varchar(50) not null
);

-- 11. Create table Relation table Cocktail_Name --> Drink_Type, Method, Glass_Type, Top_Up
Create table Cocktail_Details(
	CD_id integer primary key auto_increment,
	CD_cocktail_name_ID integer not null,
    CD_drink_type_ID int not null,
    CD_method_ID int,
    CD_glass_type_ID int,
    CD_top_up_ID int,
    foreign key (CD_cocktail_name_ID) references Cocktail_Name(cocktail_name_id),
    foreign key (CD_drink_type_ID) references Drink_Type(drink_type_ID),
    foreign key (CD_method_ID) references Method(method_ID),
    foreign key (CD_glass_type_ID) references Glass_Type(glass_type_ID),
    foreign key (CD_top_up_ID) references Top_Up(top_up_ID)
);

-- 12. Create table Relation table Cocktail_Name --> Garnish
Create table Cocktail_Garnish(
	CG_id integer primary key auto_increment,
	CG_cocktail_name_ID integer not null,
    CG_garnish_ID int,
    foreign key (CG_cocktail_name_ID) references Cocktail_Name(cocktail_name_id),
    foreign key (CG_garnish_ID) references Garnish(garnish_ID)
);

-- 13. Create table Relation table Cocktail_Name --> Measurements, Ingredients
Create table Cocktail_Recipe(
	CR_id integer primary key auto_increment,
	CR_cocktail_name_ID integer not null,
    Quantity float not null,
    CR_measurement_ID int not null,
    CR_ingredient_ID int not null,
    foreign key (CR_cocktail_name_ID) references Cocktail_Name(cocktail_name_id),
    foreign key (CR_measurement_ID) references Measurements(measurement_ID),
    foreign key (CR_ingredient_ID) references Ingredients(ingredient_ID)
);

-- 14. Create table City_or_State
Create table City_or_State(
	city_or_state_id integer primary key auto_increment,
    city_or_state_name varchar(50) not null
);

-- 15. Create table Country
Create table Country(
	country_id integer primary key auto_increment,
    country_name varchar(50) not null
);

-- 16. Create table person_or_bar
Create table person_or_bar(
	person_or_bar_id integer primary key auto_increment,
    person_or_bar_name varchar(100) not null
);

-- 16. Create table Relation table Cocktail_Name --> City_Or_State, Country
Create table Cocktail_Origin(
	CO_id integer primary key auto_increment,
	CO_cocktail_name_ID integer not null,
    CO_city_or_state_ID integer,
    CO_country_ID int,
    CO_person_or_bar_ID int,
    year_created varchar(4),
    foreign key (CO_cocktail_name_ID) references Cocktail_Name(cocktail_name_id),
    foreign key (CO_city_or_state_ID) references City_or_State(city_or_state_ID),
    foreign key (CO_country_ID) references Country(country_ID),
    foreign key (CO_person_or_bar_ID) references person_or_bar(person_or_bar_ID)
);