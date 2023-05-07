select * from Cocktail_Name;

select * from ingredients;

select * from measurements;

select * from method;

select * from garnish;

select * from top_up;

select * from drink_type;

select * from glass_type;

select *
from cocktail_details;

select 
	 cocktail_name,
   drink_type_name,
	method_name,
	 glass_type_name,
	 top_up_name	
from cocktail_details
	join cocktail_name
		on cocktail_details.CD_cocktail_name_ID = cocktail_name.cocktail_name_id
	left join drink_type 
		on cocktail_details.CD_drink_type_ID = drink_type.drink_type_id
	left join method
		on cocktail_details.CD_method_ID = method.method_id
	left join glass_type
		on cocktail_details.CD_glass_type_ID = glass_type.glass_type_id
	left join top_up
		on cocktail_details.CD_top_up_ID = top_up.top_up_id
order by cocktail_name;

select 
	cocktail_name,
	garnish_name
from 
	cocktail_garnish
    join cocktail_name on 
		cocktail_garnish.CG_cocktail_name_ID = cocktail_name.cocktail_name_id
	join garnish on 
		cocktail_garnish.CG_garnish_ID = garnish.garnish_ID;

    
select * from cocktail_recipe;

select
	cocktail_name,
    quantity,
    measurement_name,
    ingredient_name
from cocktail_recipe
	join cocktail_name
		on cocktail_recipe.CR_cocktail_name_ID = cocktail_name.cocktail_name_id
	join measurements
		on cocktail_recipe.CR_measurement_ID = measurements.measurement_id
	join ingredients
		on cocktail_recipe.CR_ingredient_ID = ingredients.ingredient_id
order by 
	cocktail_name;
	
select * from city_or_state;

select * from country;

select * from person_or_bar;

select * from cocktail_origin;

select 
	cocktail_name,
    person_or_bar_name,
    year_created,
    city_or_state_name,
    country_name
from cocktail_origin
	join cocktail_name
		on cocktail_origin.CO_cocktail_name_ID = cocktail_name.cocktail_name_id
	join person_or_bar
		on cocktail_origin.CO_person_or_bar_ID = person_or_bar.person_or_bar_ID
    join city_or_state
		on cocktail_origin.CO_city_or_state_ID = city_or_state.city_or_state_id
	join country
		on cocktail_origin.CO_country_ID = country.country_id
order by 
	cocktail_name;