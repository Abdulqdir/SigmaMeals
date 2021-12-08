-- SQL Script RECIPES
-- TCSS 445 - Phase II
/*
 Group 1 (LiveSQL)
 This SQL script was tested on Oracle LiveSQL.
 To run follow these instructions:
 1. Open LiveSQL
 2. Go to "My Scripts"
 3. Upload the script
 4. Click run
 4a. Check the boxes for "Drop all database objects" and "Remove Session History"
 if there are any.
 5. Click "Perform Action(s)"
 */
--- Need this for LiveSQL
-- ALTER SESSION
-- SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--- Uncomment this when using MySQL ---
--DROP DATABASE IF EXISTS `sigmaMeals`;
--CREATE DATABASE IF NOT EXISTS `sigmaMeals`;
--USE `sigmaMeals`;
--- PART A ---
--- Creating Database Relations
-- -----------------------------------------------------
-- Table MEAL_TYPE
-- This stores the type of meal for a recipe. For example, a recipe can be of type Lunch or Dinner.
-- -----------------------------------------------------
DROP TABLE IF EXISTS MEAL_TYPE;
CREATE TABLE MEAL_TYPE (
  meal_id INT NOT NULL PRIMARY KEY,
  type_name VARCHAR(45) NOT NULL
);
-- -----------------------------------------------------
-- Table USER
-- This stores the relevant information about the users for login in as well as 
-- the first and last name of the user.
-- -----------------------------------------------------
DROP TABLE IF EXISTS USER;
CREATE TABLE USER (
  user_id SERIAL PRIMARY KEY,
  firstname VARCHAR(256) NOT NULL,
  lastname VARCHAR(256) NOT NULL,
  username VARCHAR(256) NOT NULL UNIQUE,
  email VARCHAR(256) DEFAULT 'Not Provided' NOT NULL UNIQUE,
  password VARCHAR(256) NOT NULL,
  CHECK (LENGTH(username) >= 4),
  CHECK (LENGTH(password) >= 8)
);
-- -----------------------------------------------------
-- Table RECIPE
-- This stores information that represent a recipe. Most notably
-- the title, cost, description, and the ID of the user that created it.
-- -----------------------------------------------------
DROP TABLE IF EXISTS RECIPE;
CREATE TABLE RECIPE (
  recipe_id INT NOT NULL,
  recipe_title VARCHAR(256) NOT NULL,
  meal_id INT,
  recipe_total_cost NUMERIC(5, 2) NOT NULL,
  prep_time VARCHAR(45) DEFAULT '5 minutes' NOT NULL,
  created_user_id INT DEFAULT 0 NOT NULL,
  recipe_description VARCHAR(10000) DEFAULT 'No description provided' NOT NULL,
  instructions VARCHAR(3000) DEFAULT 'No instruction provided',
  image_url VARCHAR(256) DEFAULT 'No image provided',
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (recipe_id),
  CONSTRAINT RECIPES_MEAL_TYPE FOREIGN KEY (meal_id) REFERENCES MEAL_TYPE(meal_id) ON DELETE
  SET NULL,
    CONSTRAINT RECIPE_USER FOREIGN KEY (created_user_id) REFERENCES USER(user_id) ON DELETE
  SET NULL
);
-- -----------------------------------------------------
-- Table INGREDIENT
-- This stores the relevant information to describe an ingredient.
-- -----------------------------------------------------
DROP TABLE IF EXISTS INGREDIENT;
CREATE TABLE INGREDIENT (
  ingredient_id INT NOT NULL,
  ing_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (ingredient_id)
);
-- -----------------------------------------------------
-- Table CONSISTS_OF
-- This is a joint table that stores the recipe_id and ingredient_id to link
-- the different ingredients that are assciated with a recipe.
-- -----------------------------------------------------
DROP TABLE IF EXISTS CONSISTS_OF;
CREATE TABLE CONSISTS_OF (
  recipe_id INT NOT NULL,
  ingredient_id INT NOT NULL,
  quantity FLOAT NOT NULL,
  measurement VARCHAR(45) NOT NULL,
  CHECK (quantity > 0),
  ---Defining compound PRIMARY KEY
  CONSTRAINT REC_INFO_PK PRIMARY KEY (recipe_id, ingredient_id),
  ---Defining FOREIGN KEYS
  CONSTRAINT INFO_RECIPE_FK FOREIGN KEY (recipe_id) REFERENCES RECIPE(recipe_id) ON DELETE CASCADE,
  CONSTRAINT INFO_INGREDIENT_FK FOREIGN KEY (ingredient_id) REFERENCES INGREDIENT(ingredient_id) ON DELETE
  SET NULL
);
-- -----------------------------------------------------
-- Table RATING
-- This stores the user ratings for a specific recipe.
-- -----------------------------------------------------
DROP TABLE IF EXISTS RATING;
CREATE TABLE RATING (
  recipe_id INT NOT NULL,
  user_id INT NOT NULL,
  rating INT DEFAULT 0 NOT NULL,
  PRIMARY KEY (recipe_id, user_id),
  CHECK (
    rating >= 0
    AND rating <= 5
  ),
  CONSTRAINT RATING_RECIPE FOREIGN KEY (recipe_id) REFERENCES RECIPE(recipe_id) ON DELETE CASCADE,
  CONSTRAINT RATING_USER FOREIGN KEY (user_id) REFERENCES USER(user_id) ON DELETE
  SET NULL
);
--- PART B ---
--- Sample Data
INSERT INTO MEAL_TYPE
VALUES (1, 'Breakfast');
INSERT INTO MEAL_TYPE
VALUES (2, 'Lunch');
INSERT INTO MEAL_TYPE
VALUES (3, 'Dinner');
INSERT INTO MEAL_TYPE
VALUES (4, 'Dessert');
INSERT INTO MEAL_TYPE
VALUES (5, 'Appetizer');
INSERT INTO MEAL_TYPE
VALUES (6, 'Main Course');
INSERT INTO MEAL_TYPE
VALUES (7, 'Main Dish');
INSERT INTO MEAL_TYPE
VALUES (8, 'Morning Meal');
INSERT INTO MEAL_TYPE
VALUES (9, 'Brunch');
INSERT INTO MEAL_TYPE
VALUES (10, 'Drink');
INSERT INTO USER
VALUES (
    'admin',
    'admin',
    'admin',
    'SigmaRecipe@gmail.com',
    '12345666'
  );
INSERT INTO USER
VALUES (
    'Lam',
    'Mai',
    'MaiL',
    'test1@gmail.com',
    '12345678'
  );
INSERT INTO USER
VALUES (
    'Abdulqadir',
    'Ibrahim',
    'IbraAb',
    'test2@gmail.com',
    '12343578'
  );
INSERT INTO USER
VALUES (
    'Ruchik',
    'Chaudhari',
    'ChaudhRu',
    'test3@gmail.com',
    '64345678'
  );
INSERT INTO USER
VALUES (
    'Artem',
    'Portfany',
    'PortArt',
    'test4@gmail.com',
    '12345958'
  );
INSERT INTO USER
VALUES (
    'Lam',
    'Jade',
    'JadeL',
    'test5@gmail.com',
    '12345607'
  );
INSERT INTO USER
VALUES (
    'Abdulqadir',
    'Cool',
    'CoolAb',
    'test6@gmail.com',
    '12385678'
  );
INSERT INTO USER
VALUES (
    'Ruchik',
    'Slayer',
    'SlayerU',
    'test7@gmail.com',
    '12345611'
  );
INSERT INTO USER
VALUES (
    'Artem',
    'TooCool',
    'TooCoolAr',
    'test8@gmail.com',
    '12345670'
  );
INSERT INTO USER
VALUES (
    'Lam',
    'Genius',
    'GeniusL',
    'test9@gmail.com',
    '01345678'
  );
INSERT INTO USER
VALUES (
    'Abdulqadir',
    'Solo',
    'SoloAb',
    'test10@gmail.com',
    '12345600'
  );
INSERT INTO INGREDIENT
VALUES(11233, 'kale');
INSERT INTO INGREDIENT
VALUES(11457, 'baby spinach');
INSERT INTO INGREDIENT
VALUES(9003, 'apple');
INSERT INTO INGREDIENT
VALUES(9252, 'pear');
INSERT INTO INGREDIENT
VALUES(12195, 'nut butter');
INSERT INTO INGREDIENT
VALUES(93607, 'almond milk');
INSERT INTO INGREDIENT
VALUES(14412, 'water');
INSERT INTO INGREDIENT
VALUES(10014412, 'ice');
INSERT INTO INGREDIENT
VALUES(20137, 'cooked quinoa');
INSERT INTO INGREDIENT
VALUES(11215, 'garlic');
INSERT INTO INGREDIENT
VALUES(1002030, 'black pepper');
INSERT INTO INGREDIENT
VALUES(4053, 'olive oil');
INSERT INTO INGREDIENT
VALUES(12014, 'pumpkin seeds');
INSERT INTO INGREDIENT
VALUES(1022068, 'red wine vinegar');
INSERT INTO INGREDIENT
VALUES(2047, 'salt');
INSERT INTO INGREDIENT
VALUES(9316, 'strawberries');
INSERT INTO INGREDIENT
VALUES(18371, 'low sodium baking powder');
INSERT INTO INGREDIENT
VALUES(2010, 'cinnamon');
INSERT INTO INGREDIENT
VALUES(1124, 'egg whites');
INSERT INTO INGREDIENT
VALUES(10811111, 'liquid stevia');
INSERT INTO INGREDIENT
VALUES(9302, 'raspberries');
INSERT INTO INGREDIENT
VALUES(8120, 'rolled oats');
INSERT INTO INGREDIENT
VALUES(1009016, 'apple cider');
INSERT INTO INGREDIENT
VALUES(2004, 'bay leaves');
INSERT INTO INGREDIENT
VALUES(1005091, 'bone in skin on chicken thighs');
INSERT INTO INGREDIENT
VALUES(19334, 'golden brown sugar');
INSERT INTO INGREDIENT
VALUES(11052, 'green beans');
INSERT INTO INGREDIENT
VALUES(2063, 'fresh rosemary');
INSERT INTO INGREDIENT
VALUES(1082047, 'kosher salt');
INSERT INTO INGREDIENT
VALUES(9150, 'lemon');
INSERT INTO INGREDIENT
VALUES(11282, 'onion');
INSERT INTO INGREDIENT
VALUES(2036, 'rosemary');
INSERT INTO INGREDIENT
VALUES(1029003, 'tart apple');
INSERT INTO INGREDIENT
VALUES(10111111, 'black tea bag');
INSERT INTO INGREDIENT
VALUES(1022030, 'black peppercorns');
INSERT INTO INGREDIENT
VALUES(13786, 'beef chuck roast');
INSERT INTO INGREDIENT
VALUES(14003, 'beer');
INSERT INTO INGREDIENT
VALUES(10211821, 'bell pepper');
INSERT INTO INGREDIENT
VALUES(1009, 'cheddar cheese');
INSERT INTO INGREDIENT
VALUES(11266, 'crimini mushrooms');
INSERT INTO INGREDIENT
VALUES(10711111, 'any color food color');
INSERT INTO INGREDIENT
VALUES(31015, 'green chili pepper');
INSERT INTO INGREDIENT
VALUES(18350, 'hamburger bun');
INSERT INTO INGREDIENT
VALUES(1053, 'cream');
INSERT INTO INGREDIENT
VALUES(1039195, 'oil cured black olives');
INSERT INTO INGREDIENT
VALUES(1145, 'unsalted butter');
INSERT INTO INGREDIENT
VALUES(4513, 'None');
INSERT INTO INGREDIENT
VALUES(93798, 'brine');
INSERT INTO INGREDIENT
VALUES(10218, 'pork tenderloin');
INSERT INTO INGREDIENT
VALUES(1102047, 'salt and pepper');
INSERT INTO INGREDIENT
VALUES(19335, 'sugar');
INSERT INTO INGREDIENT
VALUES(11124, 'carrot');
INSERT INTO INGREDIENT
VALUES(11352, 'potato');
INSERT INTO INGREDIENT
VALUES(1055062, 'boneless skinless chicken breast');
INSERT INTO INGREDIENT
VALUES(1012046, 'whole grain mustard');
INSERT INTO INGREDIENT
VALUES(11477, 'zucchini');
INSERT INTO INGREDIENT
VALUES(2069, 'balsamic vinegar');
INSERT INTO INGREDIENT
VALUES(1001, 'butter');
INSERT INTO INGREDIENT
VALUES(11156, 'chives');
INSERT INTO INGREDIENT
VALUES(2003, 'dried basil');
INSERT INTO INGREDIENT
VALUES(2023, 'marjoram');
INSERT INTO INGREDIENT
VALUES(2029, 'dried parsley');
INSERT INTO INGREDIENT
VALUES(2041, 'tarragon');
INSERT INTO INGREDIENT
VALUES(9206, 'orange juice');
INSERT INTO INGREDIENT
VALUES(5109, 'roasting chicken');
INSERT INTO INGREDIENT
VALUES(6971, 'worcestershire sauce');
INSERT INTO INGREDIENT
VALUES(11216, 'ginger');
INSERT INTO INGREDIENT
VALUES(1002044, 'lemon basil');
INSERT INTO INGREDIENT
VALUES(1012042, 'herbes de provence');
INSERT INTO INGREDIENT
VALUES(9265, 'persimmon');
INSERT INTO INGREDIENT
VALUES(93818, 'seeds');
INSERT INTO INGREDIENT
VALUES(98934, 'flax oil');
INSERT INTO INGREDIENT
VALUES(6615, 'vegetable stock');
INSERT INTO INGREDIENT
VALUES(10123, 'applewood smoked bacon');
INSERT INTO INGREDIENT
VALUES(6972, 'chili sauce');
INSERT INTO INGREDIENT
VALUES(1123, 'egg');
INSERT INTO INGREDIENT
VALUES(11291, 'spring onions');
INSERT INTO INGREDIENT
VALUES(11260, 'fresh mushrooms');
INSERT INTO INGREDIENT
VALUES(11304, 'petite peas');
INSERT INTO INGREDIENT
VALUES(4058, 'sesame oil');
INSERT INTO INGREDIENT
VALUES(16124, 'soy sauce');
INSERT INTO INGREDIENT
VALUES(10016124, 'kecap manis');
INSERT INTO RECIPE
VALUES(
    516705,
    'Kale Smoothie (Delicious, Healthy and Vegan!)',
    10,
    1.48,
    5,
    327,
    'If you want to add more <b>gluten free and dairy free</b> recipes to your recipe box, Kale Smoothie (Delicious, Healthy and Vegan!) might be a recipe you should try. For <b>$1.48 per serving</b>, this recipe <b>covers 28%</b> of your daily requirements of vitamins and minerals. One portion of this dish contains around <b>8g of protein</b>, <b>6g of fat</b>, and a total of <b>197 calories</b>. This recipe serves 2. 1748 people found this recipe to be scrumptious and satisfying. Several people really liked this breakfast. From preparation to the plate, this recipe takes roughly <b>5 minutes</b>. This recipe from Picky Eater Blog requires kale 1-2 cups, ice - optional, almond milk, and pear. Overall, this recipe earns a <b>very bad (but still fixable) spoonacular score of 0%</b>. <a href="https://spoonacular.com/recipes/healthy-and-delicious-leek-kale-and-mushroom-frittata-531081">Healthy and Delicious Leek, Kale and Mushroom Frittata</a>, <a href="https://spoonacular.com/recipes/banana-almond-paleo-smoothie-delicious-healthy-482086">Bananan Almond Paleo Smoothie – Delicious & Healthy</a>, and <a href="https://spoonacular.com/recipes/banana-almond-paleo-smoothie-delicious-healthy-1326365">Bananan Almond Paleo Smoothie – Delicious & Healthy</a> are very similar to this recipe.',
    'step 1 : Put all of the ingredients in a blender – blend until smooth. Drink and enjoy.
',
    'https://spoonacular.com/recipeImages/516705-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    955591,
    'Baby Kale Breakfast Salad with Quinoa & Strawberries',
    1,
    2.26,
    15,
    324,
    'Baby Kale Breakfast Salad with Quinoa & Strawberries is a main course that serves 1. One serving contains <b>419 calories</b>, <b>16g of protein</b>, and <b>23g of fat</b>. For <b>$2.32 per serving</b>, this recipe <b>covers 38%</b> of your daily requirements of vitamins and minerals. It is brought to you by Eating Well. Several people made this recipe, and 462 would say it hit the spot. A mixture of ground pepper, lightly baby kale, quinoa, and a handful of other ingredients are all it takes to make this recipe so delicious. To use up the olive oil you could follow this main course with the <a href="https://spoonacular.com/recipes/sauteed-banana-granola-and-yogurt-parfait-624619">Sauteed Banana, Granolan and Yogurt Parfait</a> as a dessert. It is a good option if you''re following a <b>gluten free, dairy free, lacto ovo vegetarian, and vegan</b> diet. From preparation to the plate, this recipe takes roughly <b>15 minutes</b>. With a spoonacular <b>score of 0%</b>, this dish is improvable. Similar recipes are <a href="https://spoonacular.com/recipes/baby-kale-salad-with-strawberries-goat-cheese-and-strawberry-mint-vinaigrette-512613">Baby Kale Salad with Strawberries, Goat Cheese, and Strawberry-Mint Vinaigrette</a>, <a href="https://spoonacular.com/recipes/baby-kale-breakfast-salad-622280">Baby Kale Breakfast Salad</a>, and <a href="https://spoonacular.com/recipes/strawberries-and-cream-breakfast-quinoa-582127">Strawberries and Cream Breakfast Quinoa</a>.',
    'step 1 : Mash garlic and salt together with the side of a chef''s knife or a fork to form a paste.
step 2 : Whisk the garlic paste, oil, vinegar and pepper together in a medium bowl.
step 3 : Add kale; toss to coat.
step 4 : Serve topped with quinoa, strawberries and pepitas.
',
    'https://spoonacular.com/recipeImages/955591-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    557456,
    'Oatmeal Berry Breakfast Cake [Dairy, Gluten & Sugar Free]',
    1,
    2.15,
    3,
    329,
    'Oatmeal Berry Breakfast Cake [Dairy, Gluten & Sugar Free] might be just the dessert you are searching for. One serving contains <b>270 calories</b>, <b>20g of protein</b>, and <b>5g of fat</b>. This recipe serves 1 and costs $2.15 per serving. This recipe is liked by 1189 foodies and cooks. If you have almond milk, baking powder, rolled oats, and a few other ingredients on hand, you can make it. From preparation to the plate, this recipe takes around <b>3 minutes</b>. It is a good option if you''re following a <b>gluten free, dairy free, and fodmap friendly</b> diet. All things considered, we decided this recipe <b>deserves a spoonacular score of 100%</b>. This score is awesome. Similar recipes include <a href="https://spoonacular.com/recipes/pumpkin-pie-bars-with-brown-sugar-oatmeal-crust-gluten-free-dairy-free-619060">Pumpkin Pie Bars with Brown Sugar Oatmeal Crust (gluten free & dairy free!)</a>, <a href="https://spoonacular.com/recipes/oat-fruit-breakfast-bars-dairy-egg-sugar-flour-nut-gluten-free-557231">Oat & Fruit Breakfast Bars: Dairy, Egg, Sugar, Flour, Nut & Gluten- Free</a>, and <a href="https://spoonacular.com/recipes/1-minute-sugar-free-chocolate-mug-cake-low-carb-dairy-gluten-free-557212">1 Minute Sugar-Free Chocolate Mug Cake {Low Carb, Dairy & Gluten Free}</a>.',
    'step 1 : Spray a large 16 ounce ramekin (or use two small ramekins) with nonstick cooking spray.
step 2 : Mix all ingredients together in the ramekin except the berries.Stir well to incorporate,
step 3 : Add berries.Save a few for topping if desired. Microwave for 3 minutes until puffed and no longer liquid-y in center.Or bake at 350 degrees for 25-30 minutes.
step 4 : Serve warm with additional toppings.
',
    'https://spoonacular.com/recipeImages/557456-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    381569,
    'Apple-Brined Chicken Thighs',
    2,
    105.88,
    85,
    0,
    'Apple-Brined Chicken Thighs is a <b>gluten free and dairy free</b> main course. For <b>$105.88 per serving</b>, this recipe <b>covers 27%</b> of your daily requirements of vitamins and minerals. One serving contains <b>787 calories</b>, <b>40g of protein</b>, and <b>42g of fat</b>. This recipe serves 5. Head to the store and pick up pepper, onion, garlic cloves, and a few other things to make it today. To use up the lemon you could follow this main course with the <a href="https://spoonacular.com/recipes/lemon-shortbread-cookies-with-lemon-icing-a-tribute-to-aunt-roxanne-487814">Lemon Shortbread Cookies with Lemon Icing {A Tribute to Aunt Roxanne}</a> as a dessert. 1 person has made this recipe and would make it again. All things considered, we decided this recipe <b>deserves a spoonacular score of 32%</b>. This score is rather bad. Try <a href="https://spoonacular.com/recipes/apple-cider-brined-chicken-287151">Apple Cider Brined Chicken</a>, <a href="https://spoonacular.com/recipes/apple-brined-and-smoked-turkey-75312">Apple-brined And Smoked Turkey</a>, and <a href="https://spoonacular.com/recipes/apple-cider-brined-turkey-breast-536739">Apple Cider Brined Turkey Breast</a> for similar recipes.',
    'step 1 : In a Dutch oven, combine the cider, onion, lemon, rosemary sprigs, salt, 1/4 cup brown sugar, garlic, bay leaf and peppercorns. Bring to a boil. Cook and stir until salt and brown sugar are dissolved.
step 2 : Remove from the heat; stir in water. Cool brine to room temperature.
step 3 : Place chicken in the 2-gallon resealable plastic bag. Carefully pour cooled brine into bag. Squeeze out as much air as possible; seal bag and turn to coat.
step 4 : Place in a roasting pan. Refrigerate for 2 hours, turning occasionally.
step 5 : Place beans and apples in a greased roasting pan.
step 6 : Drain chicken; place in prepared pan.
step 7 : Bake, uncovered, at 400° for 40 minutes.
step 8 : Combine the minced rosemary, oil, pepper and remaining brown sugar; sprinkle over chicken.
step 9 : Bake 15-25 minutes longer or until a thermometer reads 180° and beans are tender.
',
    'https://spoonacular.com/recipeImages/381569-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    353123,
    'The Det Burger',
    2,
    82.30,
    45,
    328,
    'The Det Burger might be just the main course you are searching for. This recipe serves 4 and costs $81.93 per serving. One portion of this dish contains roughly <b>56g of protein</b>, <b>71g of fat</b>, and a total of <b>963 calories</b>. This recipe is typical of American cuisine. 1 person has made this recipe and would make it again. Head to the store and pick up sauteed cremini mushrooms, cheddar cheese, pepper, and a few other things to make it today. To use up the onion you could follow this main course with the <a href="https://spoonacular.com/recipes/candy-corn-cupcakes-63881">Candy Corn Cupcakes</a> as a dessert. All things considered, we decided this recipe <b>deserves a spoonacular score of 46%</b>. This score is pretty good. Try <a href="https://spoonacular.com/recipes/burger-club-award-winning-logan-county-burger-patty-melt-477749">Burger Club: Award-Winning Logan County Burger Patty Melt</a>, <a href="https://spoonacular.com/recipes/beef-burger-recipe-elvis-burger-with-salad-gherkin-23359">Beef Burger Recipe (elvis Burger With Salad & Gherkin)</a>, and <a href="https://spoonacular.com/recipes/new-york-burger-week-pretzel-burger-with-beer-cheese-493632">New York Burger Week: Pretzel Burger with Beer Cheese</a> for similar recipes.',
    'step 1 : Make the Det
step 1 : Combine all the ingredients in a bowl.
step 1 : Heat the butter and oil in a large cast iron skillet over high heat.
step 2 : Add the hamburgers and cook halfway through and turn over. Cover each with about 1/4 cup of the Det
step 3 : Mix and top with the onion slices.
step 4 : Pour in the 1/4 cup beer and cover with a lid. Steam a couple of minutes until the onion is translucent. Re-steam with beer a couple of times. Top each hamburger with a slice of cheese and cover until melted.
step 5 : Transfer the hamburger to the buns and serve.
step 6 : Spread the meat out on a board and grate 2 to 3 tablespoons of onion into ituse a fairly fine grater so you get just the juice and very finely grated raw onion. Now mix in about a tablespoon of heavy cream and some freshly ground black pepper. Form into pattiesa 6 to 8-ounce patty for an average serving.
',
    'https://spoonacular.com/recipeImages/353123-556x370.jpeg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    574324,
    'How To Brine and Grill a Pork Tenderloin',
    2,
    68.25,
    165,
    321,
    'How To Brine and Grill a Pork Tenderloin might be just the main course you are searching for. This recipe makes 4 servings with <b>622 calories</b>, <b>94g of protein</b>, and <b>23g of fat</b> each. For <b>$68.25 per serving</b>, this recipe <b>covers 40%</b> of your daily requirements of vitamins and minerals. This recipe from 101 Cooking for Two has 1 fans. Head to the store and pick up brine, garlic, sugar, and a few other things to make it today. To use up the olive oil you could follow this main course with the <a href="https://spoonacular.com/recipes/sauteed-banana-granola-and-yogurt-parfait-624619">Sauteed Banana, Granolan and Yogurt Parfait</a> as a dessert. From preparation to the plate, this recipe takes around <b>2 hours and 45 minutes</b>. It is a good option if you''re following a <b>gluten free and dairy free</b> diet. All things considered, we decided this recipe <b>deserves a spoonacular score of 54%</b>. This score is solid. Try <a href="https://spoonacular.com/recipes/pork-brine-597140">Pork Brine</a>, <a href="https://spoonacular.com/recipes/brine-cured-pork-kabobs-with-molasses-glaze-jalapenos-and-papaya-253878">Brine-Cured Pork Kabobs with Molasses Glaze, Jalapenos and Papaya</a>, and <a href="https://spoonacular.com/recipes/grilled-pork-chops-with-brown-sugar-brine-and-onion-peach-marmalade-82107">Grilled Pork Chops with Brown-sugar Brine and Onion-Peach Marmalade</a> for similar recipes.',
    'step 1 : Trim the pork tenderloin well.
step 2 : Remove the “silver skin” and any trim-able fat.
step 3 : Mix brine in zip lock.
step 4 : Mix well and add tenderloin.
step 5 : Place in bowl so water is covering the meat.
step 6 : Place in refrigerator for 2 hours.
step 7 : Pre-heat grill on high for 15 minutes. Clean and oil grates.
step 8 : Pat dry the tenderloin and add pepper and a small amount (or none) of salt Rub in and let set for 15 minutes.
step 9 : Sear both sides of the tenderloin for 5 minutes per side.
step 10 : Add garlic to oil. Coat tenderloin with oil and garlic solution and continue to cook until 160 degrees internal temp. flipping about every 10 minutes.
step 11 : Let rest for 10 minutes prior to serving.
',
    'https://spoonacular.com/recipeImages/574324-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    17054,
    'Rosemary Chicken with Zucchini',
    3,
    67.44,
    45,
    328,
    'Rosemary Chicken with Zucchini is a <b>gluten free, dairy free, fodmap friendly, and whole 30</b> main course. This recipe makes 4 servings with <b>439 calories</b>, <b>40g of protein</b>, and <b>19g of fat</b> each. For <b>$67.55 per serving</b>, this recipe <b>covers 33%</b> of your daily requirements of vitamins and minerals. 1 person has made this recipe and would make it again. A mixture of carrots, zucchini, whole-grain mustard, and a handful of other ingredients are all it takes to make this recipe so scrumptious. To use up the zucchini you could follow this main course with the <a href="https://spoonacular.com/recipes/zucchini-dessert-squares-415963">Zucchini Dessert Squares</a> as a dessert. From preparation to the plate, this recipe takes around <b>45 minutes</b>. All things considered, we decided this recipe <b>deserves a spoonacular score of 58%</b>. This score is good. Try <a href="https://spoonacular.com/recipes/fresh-rosemary-chicken-and-zucchini-105265">Fresh Rosemary Chicken and Zucchini</a>, <a href="https://spoonacular.com/recipes/rosemary-zucchini-sticks-105372">Rosemary Zucchini Sticks</a>, and <a href="https://spoonacular.com/recipes/fragrant-rosemary-zucchini-105562">Fragrant Rosemary Zucchini</a> for similar recipes.',
    'step 1 : Freeze ItQuarter the potatoes. Peel the carrots.
step 2 : Cut the carrots and zucchini into 2-inch sticks.
step 3 : Mix them in a bowl with 2 tablespoons olive oil, 2 tablespoons mustard, 1 tablespoon rosemary, 1/2 teaspoon salt, and 1/4 teaspoon pepper. Season the chicken with 1 teaspoon salt and 1/4 teaspoon pepper. Divide everything among 4 bags. Freeze, until ready to cook, for up to 3 months. Cook It
step 4 : Heat oven to 400 F.
step 5 : Remove the bags from the freezer (you''ll need 1 bag for each serving). Empty the contents of the bags into a baking dish. Roast for 25 minutes. Toss the vegetables, turn the chicken, and continue roasting until the chicken is cooked through, 20 to 25 minutes more. Divide among individual plates.
',
    'https://spoonacular.com/recipeImages/17054-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    380984,
    'Herbed Roast Chicken',
    3,
    66.58,
    150,
    321,
    'Herbed Roast Chicken might be just the main course you are searching for. One serving contains <b>650 calories</b>, <b>43g of protein</b>, and <b>50g of fat</b>. For <b>$66.58 per serving</b>, this recipe <b>covers 24%</b> of your daily requirements of vitamins and minerals. This recipe serves 8. This recipe is liked by 1 foodies and cooks. If you have orange juice, olive oil, tarragon, and a few other ingredients on hand, you can make it. To use up the orange juice you could follow this main course with the <a href="https://spoonacular.com/recipes/plum-sherbert-with-orange-juice-and-plum-wine-80862">Plum Sherbert with Orange Juice and Plum Wine</a> as a dessert. From preparation to the plate, this recipe takes roughly <b>2 hours and 30 minutes</b>. All things considered, we decided this recipe <b>deserves a spoonacular score of 37%</b>. This score is rather bad. Try <a href="https://spoonacular.com/recipes/herbed-roast-chicken-246722">Herbed Roast Chicken</a>, <a href="https://spoonacular.com/recipes/roast-chicken-with-herbed-mushrooms-323939">Roast Chicken with Herbed Mushrooms</a>, and <a href="https://spoonacular.com/recipes/herbed-roast-chicken-legs-122664">Herbed Roast Chicken Legs</a> for similar recipes.',
    'step 1 : In the 2-gallon resealable plastic bag, combine the orange juice, oil, butter, vinegar, Worcestershire sauce, garlic, chives and seasonings.
step 2 : Add chicken; seal bag and turn to coat.
step 3 : Place bag in a pan. Refrigerate 8 hours or overnight, turning occasionally.
step 4 : Preheat oven to 350°.
step 5 : Drain and discard marinade.
step 6 : Place chicken on a rack in a shallow roasting pan.
step 7 : Bake, uncovered, 2-1/4 to 2-3/4 hours or until a thermometer inserted in thigh reads 180°. Cover loosely with foil if chicken browns too quickly.
step 8 : Remove chicken from oven; tent with foil.
step 9 : Let stand 15 minutes before carving.
',
    'https://spoonacular.com/recipeImages/380984-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    629500,
    'Wild Herbed Pumpkin and Persimmon Soup',
    3,
    53.49,
    50,
    329,
    'Wild Herbed Pumpkin and Persimmon Soup might be just the main course you are searching for. For <b>$53.56 per serving</b>, this recipe <b>covers 58%</b> of your daily requirements of vitamins and minerals. This recipe makes 6 servings with <b>724 calories</b>, <b>16g of protein</b>, and <b>40g of fat</b> each. 38 people were impressed by this recipe. It is perfect for <b>Autumn</b>. Head to the store and pick up vegetable stock, herbs, handful seeds, and a few other things to make it today. To use up the herbs you could follow this main course with the <a href="https://spoonacular.com/recipes/mint-chocolate-chip-cupcakes-46882">Mint Chocolate Chip Cupcakes</a> as a dessert. From preparation to the plate, this recipe takes approximately <b>50 minutes</b>. It is a good option if you''re following a <b>gluten free and vegetarian</b> diet. All things considered, we decided this recipe <b>deserves a spoonacular score of 94%</b>. This score is great. Try <a href="https://spoonacular.com/recipes/from-the-pantry-curried-pumpkin-and-wild-rice-soup-743257">From the Pantry: Curried Pumpkin and Wild Rice Soup</a>, <a href="https://spoonacular.com/recipes/paleo-pumpkin-persimmon-smoothie-or-pudding-542964">Paleo Pumpkin Persimmon Smoothie or Pudding</a>, and <a href="https://spoonacular.com/recipes/herbed-wild-rice-35980">Herbed Wild Rice</a> for similar recipes.',
    'step 1 : Heat half the olive oil in a large saucepan, then gently cook the onions and ginger for 5 minutes, until soft but not coloured.
step 2 : Add the pumpkin or squash to the pan, and then carry on cooking for with the lid on, stirring occasionally, until it starts to soften and turn golden, about 10 minutes.
step 3 : Add the persimmon, replace the lid and continue to cook for another 2 to 3 minutes.
step 4 : Pour the stock into the pan, turn up the heat and bring to the boil, and then lower the heat and simmer for 10 minutes until the pumpkin is very soft.
step 5 : Pour the cream into the pan, add the herbs, then pure with a hand blender. For an extra-velvety and smooth consistency push the soup through a fine sieve into another pan. Bring the soup to a slow simmer.
step 6 : Serve piping hot topped with sunflower seeds, a few drops of sunflower oil and a sprinkle of the wild herbs.
',
    'https://spoonacular.com/recipeImages/629500-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    470214,
    'Chicken Fried Cauliflower Rice',
    7,
    47.84,
    30,
    322,
    'Need a <b>dairy free side dish</b>? Chicken Fried Cauliflower Rice could be an outstanding recipe to try. One portion of this dish contains around <b>21g of protein</b>, <b>14g of fat</b>, and a total of <b>269 calories</b>. For <b>$47.86 per serving</b>, this recipe <b>covers 18%</b> of your daily requirements of vitamins and minerals. This recipe serves 4. Not a lot of people made this recipe, and 1 would say it hit the spot. From preparation to the plate, this recipe takes roughly <b>30 minutes</b>. If you have bacon, onion, chili sauce such as sambal oelek, and a few other ingredients on hand, you can make it. All things considered, we decided this recipe <b>deserves a spoonacular score of 36%</b>. This score is rather bad. Try <a href="https://spoonacular.com/recipes/cauliflower-chicken-fried-rice-855584">Cauliflower Chicken Fried "Rice</a>, <a href="https://spoonacular.com/recipes/lightened-fried-cauliflower-rice-with-chicken-568389">Lightened fried cauliflower rice with chicken</a>, and <a href="https://spoonacular.com/recipes/sriracha-chicken-cauliflower-fried-rice-483064">Sriracha Chicken Cauliflower “Fried Rice”</a> for similar recipes.',
    'step 1 : Heat the pan over medium-high heat, add the bacon and cook until crispy, about 3-5 minutes
step 2 : Add the chicken and stir-fry until cooked, about 5 minutes.
step 3 : Add the onion and mushrooms and stir-fry for 3 minutes before adding the carrot and peas and stir-frying for another 3 minutes.
step 4 : Add the garlic and ginger and stir-fry for 30 seconds.
step 5 : Add the cauliflower rice, mix everything up and stir-fry for 2 minutes.Make a well in the middle of the pan, add the eggs and let them sit for a minute before mixing them into everything and stir-frying for another 3 minutes.
step 6 : Mix in the mixture of the soy sauce, sweet soy sauce, chili sauce, sesame oil and green onions, remove from heat and enjoy.
',
    'https://spoonacular.com/recipeImages/470214-556x370.jpg',
    NOW()
  );
INSERT INTO CONSISTS_OF
VALUES(516705, 11233, 4.0, 'leaves');
INSERT INTO CONSISTS_OF
VALUES(516705, 11457, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(516705, 9003, 1.0, 'small');
INSERT INTO CONSISTS_OF
VALUES(516705, 9252, 1.0, 'small');
INSERT INTO CONSISTS_OF
VALUES(516705, 12195, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(516705, 93607, 4.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(516705, 14412, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(516705, 10014412, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(955591, 20137, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(955591, 11215, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(955591, 1002030, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(955591, 11233, 3.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(955591, 4053, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(955591, 12014, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(955591, 1022068, 2.0, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(955591, 2047, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(955591, 9316, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(557456, 93607, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(557456, 18371, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(557456, 2010, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(557456, 1124, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(557456, 10811111, 3.0, 'tsp');
INSERT INTO CONSISTS_OF
VALUES(557456, 9302, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(557456, 8120, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(557456, 2047, 1.0, 'dash');
INSERT INTO CONSISTS_OF
VALUES(381569, 1009016, 3.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(381569, 2004, 1.0, 'tsp');
INSERT INTO CONSISTS_OF
VALUES(381569, 1005091, 3.0, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(381569, 19334, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(381569, 11052, 1.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(381569, 2063, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(381569, 11215, 4.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(381569, 1082047, 0.3333333333333333, 'cups');
INSERT INTO CONSISTS_OF
VALUES(381569, 9150, 1.0, 'medium');
INSERT INTO CONSISTS_OF
VALUES(381569, 4053, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(381569, 11282, 1.0, 'medium');
INSERT INTO CONSISTS_OF
VALUES(381569, 1002030, 0.25, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(381569, 2036, 4.0, 'tsp');
INSERT INTO CONSISTS_OF
VALUES(381569, 1029003, 3.0, 'mediums');
INSERT INTO CONSISTS_OF
VALUES(381569, 10111111, 2.0, 'gallons');
INSERT INTO CONSISTS_OF
VALUES(381569, 14412, 2.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(381569, 1022030, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(353123, 13786, 2.0, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(353123, 14003, 0.25, 'cups');
INSERT INTO CONSISTS_OF
VALUES(353123, 10211821, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(353123, 1009, 4.0, 'slices');
INSERT INTO CONSISTS_OF
VALUES(353123, 11266, 0.3333333333333333, 'cups');
INSERT INTO CONSISTS_OF
VALUES(353123, 10711111, 2000.0, 'ounce');
INSERT INTO CONSISTS_OF
VALUES(353123, 31015, 0.3333333333333333, 'cups');
INSERT INTO CONSISTS_OF
VALUES(353123, 18350, 4.0, 'ounce');
INSERT INTO CONSISTS_OF
VALUES(353123, 1053, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(353123, 1082047, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(353123, 1039195, 0.3333333333333333, 'cups');
INSERT INTO CONSISTS_OF
VALUES(353123, 11282, 4.0, 'slices');
INSERT INTO CONSISTS_OF
VALUES(353123, 1145, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(353123, 4513, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(574324, 93798, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(574324, 11215, 4.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(574324, 4053, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(574324, 10218, 1.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(574324, 1102047, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(574324, 19335, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(574324, 2047, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(574324, 10111111, 1.0, 'gallon');
INSERT INTO CONSISTS_OF
VALUES(574324, 14412, 2.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(17054, 11124, 2.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(17054, 1082047, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(17054, 11352, 1.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(17054, 4053, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(17054, 2036, 1.0, 'bunch');
INSERT INTO CONSISTS_OF
VALUES(17054, 1055062, 24.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(17054, 10111111, 4.0, 'quarts');
INSERT INTO CONSISTS_OF
VALUES(17054, 1012046, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(17054, 11477, 2.0, 'smalls');
INSERT INTO CONSISTS_OF
VALUES(380984, 2069, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(380984, 1001, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(380984, 11156, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(380984, 2003, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(380984, 2023, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(380984, 2029, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(380984, 2036, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(380984, 2041, 0.25, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(380984, 11215, 6.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(380984, 4053, 0.3333333333333333, 'cups');
INSERT INTO CONSISTS_OF
VALUES(380984, 9206, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(380984, 1002030, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(380984, 5109, 6.0, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(380984, 2047, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(380984, 10111111, 2.0, 'gallons');
INSERT INTO CONSISTS_OF
VALUES(380984, 6971, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(629500, 1001, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(629500, 1053, 150.0, 'fl. ozs');
INSERT INTO CONSISTS_OF
VALUES(629500, 11216, 1.0, 'small piece');
INSERT INTO CONSISTS_OF
VALUES(629500, 1002044, 6.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(629500, 1012042, 1.0, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(629500, 4053, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(629500, 11282, 1.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(629500, 9265, 2.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(629500, 2047, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(629500, 93818, 1.0, 'Handful');
INSERT INTO CONSISTS_OF
VALUES(629500, 98934, 6.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(629500, 6615, 750.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(470214, 10123, 4.0, 'strips');
INSERT INTO CONSISTS_OF
VALUES(470214, 11124, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(470214, 6972, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(470214, 1123, 2.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(470214, 10711111, 5.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(470214, 11215, 2.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(470214, 11216, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(470214, 11291, 2.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(470214, 11260, 4.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(470214, 11282, 1.0, 'small');
INSERT INTO CONSISTS_OF
VALUES(470214, 11304, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(470214, 4058, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(470214, 1055062, 0.5, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(470214, 16124, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(470214, 10016124, 1.0, 'Tbsp');
INSERT INTO RATING
VALUES (516705, 320, 4);
INSERT INTO RATING
VALUES (955591, 321, 5);
INSERT INTO RATING
VALUES (557456, 322, 5);
INSERT INTO RATING
VALUES (381569, 323, 3);
INSERT INTO RATING
VALUES (353123, 324, 4);
INSERT INTO RATING
VALUES (574324, 325, 4);
INSERT INTO RATING
VALUES (17054, 326, 5);
INSERT INTO RATING
VALUES (380984, 327, 2);
INSERT INTO RATING
VALUES (629500, 328, 1);
INSERT INTO RATING
VALUES (470214, 329, 0);
--- PART C ---
--- Designing SQL Queries
/*
 Query 1
 
 Purpose: To view every user review along with what they reviewed.
 Summary: Every email of everyone that reviewed a recipe and the corresponding recipe name and review number.
 
 */
SELECT U.email,
  R.recipe_title,
  RT.rating
FROM USER U
  JOIN RATING RT ON U.user_id = RT.user_id
  JOIN RECIPE R ON R.recipe_id = RT.recipe_id;
/*
 Query 2
 
 Purpose: To view the count of the recipes which have strawberry, lemon and apple.
 Summary: There are a lot of recipes in the database and here we are interested in 
 getting all the recipes which has strawberry, mango and apple
 
 */
SELECT ing_name,
  COUNT(ing_name)
FROM INGREDIENT,
  CONSISTS_OF
WHERE INGREDIENT.ingredient_id IN (
    SELECT ingredient_id
    FROM INGREDIENT
    WHERE ingredient_id = 9150
      OR ingredient_id = 9316
      OR ingredient_id = 9003
  )
  AND CONSISTS_OF.ingredient_id = INGREDIENT.ingredient_id
GROUP BY ing_name;
/*
 Query 3
 
 Purpose: Get all recipes which cost less than the average cost for their meal type.
 Summary:
 --The expected result should show 4 recipes and their costs, which cost less than the average for their meal type
 --"Oatmeal Berry Breakfast Cake"
 --"The Det Burger"
 --"Brine and Grill Pork Tenderloin"
 --"Wild Herbed Pumpkin and Persimmon Soup"
 
 */
SELECT recipe_title,
  recipe_total_cost
FROM RECIPE R
WHERE recipe_total_cost < (
    SELECT AVG(recipe_total_cost)
    FROM RECIPE
    WHERE meal_id = R.meal_id
  );
/*
 Query 4
 
 Purpose: Get the ratings of all the recipes
 Summary: Here we get the ratings of all the recipes regardless if we have the ratings or
 not in the rating table for a specific recipe
 
 */
SELECT recipe_title,
  rating
FROM RECIPE
  FULL OUTER JOIN RATING ON RECIPE.recipe_id = RATING.recipe_id;
/*
 Query 5
 
 Purpose: Find recipes with 4 and 5 stars that cost under a certain price, in this case $10.
 Summary:
 --The expected result for recipes with 4 and 5 stars that cost less than $10 should be:
 --Baby Kale Breakfast Salad with Quinoa Strawberries
 --Kale Smoothie (Delicious, Healthy and Vegan!)
 --Oatmeal Berry Breakfast Cake
 
 */
SELECT RECIPE_TITLE,
  recipe_total_cost
FROM (
    SELECT RECIPE_TITLE,
      recipe_total_cost
    FROM RECIPE,
      RATING
    WHERE RATING = 5
    UNION
    SELECT RECIPE_TITLE,
      recipe_total_cost
    FROM RECIPE,
      RATING
    WHERE RATING = 4
  ) AS subquery
WHERE recipe_total_cost < 10.0;
/*
 Query 6
 
 Purpose: To select all users who left 5 star reviews
 Summary: Selects every user who has left a perfect 5 star review and how many they have left in total
 
 */
SELECT USER.firstname,
  USER.lastname,
  C.Rating_Count
FROM USER,
  (
    SELECT R.user_id,
      COUNT(R.user_id) Rating_Count
    FROM (
        SELECT *
        FROM RATING
        WHERE RATING.rating = 5
      ) R
    GROUP BY R.user_id
  ) C
WHERE USER.user_id = C.user_id;
/*
 Query 7
 
 Purpose: Get the most costly recipe with its title, cost, prep time and ratings.
 Summary: Here we are getting the info of the most expensive recipe in the database
 
 */
SELECT recipe_title AS "Most Expensive Recipe Name",
  rating AS "Rating",
  recipe_total_cost AS "Estimated Cost",
  prep_time AS "Prep Time In Minutes"
FROM RECIPE,
  RATING
WHERE RECIPE.recipe_id = RATING.recipe_id
  AND recipe_total_cost = (
    SELECT MAX(recipe_total_cost)
    FROM RECIPE
  );
/*
 Query 8
 
 Purpose: To get the recipes which are posted by the users and their full name (non-admin users) and order them by the first name.
 Summary: In this query we get all the recipes which are posted by user's which are not admin
 
 */
SELECT firstname AS "First Name",
  lastname AS "Last Name",
  recipe_title AS "Recipe Name"
FROM USER,
  RECIPE
WHERE created_user_id = user_id
  AND firstname <> 'admin'
ORDER BY firstname;
/*
 Query 9
 
 Purpose: To get the recipe info for all the main courses.
 Summary: Here the query will get the recipe info of all the recipes which are of meal type which start with "Main"
 
 */
SELECT R.recipe_title AS "Recipe Name",
  R.recipe_description AS "Description",
  R.prep_time AS "Prep Time",
  R.recipe_total_cost AS "Cost",
  RA.rating AS "Rating"
FROM RECIPE R,
  RATING RA,
  MEAL_TYPE M
WHERE M.type_name LIKE 'Main%'
  AND R.recipe_id = RA.recipe_id
  AND R.meal_id = M.meal_id;
/*
 Query 10
 
 Purpose: To get every ingredient that a user has used and the associated recipe.
 Summary: Get every ingredient used in a recipe and the person who used that ingredient along with which recipe it was used in.
 */
SELECT USER.firstname,
  USER.lastname,
  R.recipe_title,
  ING.ing_name
FROM USER,
  RECIPE R,
  CONSISTS_OF,
  INGREDIENT ING
WHERE R.recipe_id = CONSISTS_OF.recipe_id
  AND CONSISTS_OF.ingredient_id = ING.ingredient_id
  AND USER.user_id = R.created_user_id;