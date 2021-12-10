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
-- Table USERS
-- This stores the relevant information about the users for login in as well as 
-- the first and last name of the user.
-- -----------------------------------------------------
DROP TABLE IF EXISTS USERS;
CREATE TABLE USERS (
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
    CONSTRAINT RECIPE_USERS FOREIGN KEY (created_user_id) REFERENCES USERS(user_id) ON DELETE
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
  CONSTRAINT RATING_USERS FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE
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
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'admin',
    'admin',
    'admin',
    'SigmaRecipe@gmail.com',
    '12345666'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Lam',
    'Mai',
    'MaiL',
    'test1@gmail.com',
    '12345678'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Abdulqadir',
    'Ibrahim',
    'IbraAb',
    'test2@gmail.com',
    '12343578'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Ruchik',
    'Chaudhari',
    'ChaudhRu',
    'test3@gmail.com',
    '64345678'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Artem',
    'Portfany',
    'PortArt',
    'test4@gmail.com',
    '12345958'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Lam',
    'Jade',
    'JadeL',
    'test5@gmail.com',
    '12345607'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Abdulqadir',
    'Cool',
    'CoolAb',
    'test6@gmail.com',
    '12385678'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Ruchik',
    'Slayer',
    'SlayerU',
    'test7@gmail.com',
    '12345611'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Artem',
    'TooCool',
    'TooCoolAr',
    'test8@gmail.com',
    '12345670'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
VALUES (
    'Lam',
    'Genius',
    'GeniusL',
    'test9@gmail.com',
    '01345678'
  );
INSERT INTO USERS(firstname, lastname,username,email,password)
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
    1,
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
    2,
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
    3,
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
    4,
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
    5,
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
    6,
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
    7,
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
    8,
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
    9,
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
    2,
    47.84,
    30,
    10,
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
VALUES (516705, 1, 4);
INSERT INTO RATING
VALUES (955591, 2, 5);
INSERT INTO RATING
VALUES (557456, 3, 5);
INSERT INTO RATING
VALUES (381569, 4, 3);
INSERT INTO RATING
VALUES (353123, 5, 4);
INSERT INTO RATING
VALUES (574324, 6, 4);
INSERT INTO RATING
VALUES (17054, 7, 5);
INSERT INTO RATING
VALUES (380984, 8, 2);
INSERT INTO RATING
VALUES (629500, 9, 1);
INSERT INTO RATING
VALUES (470214, 10, 0);
INSERT INTO INGREDIENT
VALUES(5006, 'whole chicken');
INSERT INTO INGREDIENT
VALUES(1002010, 'cinnamon stick');
INSERT INTO INGREDIENT
VALUES(12118, 'coconut milk');
INSERT INTO INGREDIENT
VALUES(93604, 'curry leaves');
INSERT INTO INGREDIENT
VALUES(11165, 'cilantro');
INSERT INTO INGREDIENT
VALUES(93663, 'garam masala');
INSERT INTO INGREDIENT
VALUES(10093754, 'ginger garlic paste');
INSERT INTO INGREDIENT
VALUES(1052009, 'ground chipotle chile pepper');
INSERT INTO INGREDIENT
VALUES(1002013, 'ground coriander');
INSERT INTO INGREDIENT
VALUES(2043, 'turmeric');
INSERT INTO INGREDIENT
VALUES(9152, 'lemon juice');
INSERT INTO INGREDIENT
VALUES(1062047, 'garlic salt');
INSERT INTO INGREDIENT
VALUES(1001009, 'shredded cheddar cheese');
INSERT INTO INGREDIENT
VALUES(1001026, 'shredded mozzarella');
INSERT INTO INGREDIENT
VALUES(6599, 'green enchilada sauce');
INSERT INTO INGREDIENT
VALUES(18363, 'white corn tortilla');
INSERT INTO INGREDIENT
VALUES(1056, 'sour cream');
INSERT INTO INGREDIENT
VALUES(1009037, 'guacamole');
INSERT INTO INGREDIENT
VALUES(11529, 'tomato');
INSERT INTO INGREDIENT
VALUES(19911, 'maple syrup');
INSERT INTO INGREDIENT
VALUES(1077, 'milk');
INSERT INTO INGREDIENT
VALUES(1012047, 'coarse sea salt');
INSERT INTO INGREDIENT
VALUES(93824, 'white whole wheat flour');
INSERT INTO INGREDIENT
VALUES(5157, 'quail');
INSERT INTO INGREDIENT
VALUES(11677, 'shallot');
INSERT INTO INGREDIENT
VALUES(9200, 'orange');
INSERT INTO INGREDIENT
VALUES(2049, 'thyme');
INSERT INTO INGREDIENT
VALUES(20035, 'quinoa');
INSERT INTO INGREDIENT
VALUES(6172, 'chicken stock');
INSERT INTO INGREDIENT
VALUES(12020420, 'tricolor pasta');
INSERT INTO INGREDIENT
VALUES(11485, 'butternut squash');
INSERT INTO INGREDIENT
VALUES(10011457, 'spinach');
INSERT INTO INGREDIENT
VALUES(14106, 'dry white wine');
INSERT INTO INGREDIENT
VALUES(9040, 'ripe banana');
INSERT INTO INGREDIENT
VALUES(4582, 'cooking oil');
INSERT INTO INGREDIENT
VALUES(1017, 'cream cheese');
INSERT INTO INGREDIENT
VALUES(20081, 'wheat flour');
INSERT INTO INGREDIENT
VALUES(2025, 'nutmeg');
INSERT INTO INGREDIENT
VALUES(19296, 'honey');
INSERT INTO INGREDIENT
VALUES(18069, 'gluten free white sandwich bread');
INSERT INTO INGREDIENT
VALUES(1034053, 'extra virgin olive oil');
INSERT INTO INGREDIENT
VALUES(1019, 'feta cheese');
INSERT INTO INGREDIENT
VALUES(10111529, 'grape tomato');
INSERT INTO INGREDIENT
VALUES(10011205, 'persian cucumber');
INSERT INTO INGREDIENT
VALUES(10011282, 'red onion');
INSERT INTO INGREDIENT
VALUES(12061, 'almonds');
INSERT INTO INGREDIENT
VALUES(9050, 'blueberries');
INSERT INTO INGREDIENT
VALUES(93740, 'almond meal');
INSERT INTO INGREDIENT
VALUES(9156, 'lemon peel');
INSERT INTO INGREDIENT
VALUES(19336, 'powdered sugar');
INSERT INTO INGREDIENT
VALUES(2050, 'vanilla extract');
INSERT INTO INGREDIENT
VALUES(93622, 'vanilla bean');
INSERT INTO INGREDIENT
VALUES(10319335, 'vanilla sugar');
INSERT INTO INGREDIENT
VALUES(1054, 'whipped cream');
INSERT INTO INGREDIENT
VALUES(1006, 'brie');
INSERT INTO INGREDIENT
VALUES(9079, 'dried cranberries');
INSERT INTO INGREDIENT
VALUES(19904, 'dark chocolate');
INSERT INTO INGREDIENT
VALUES(1125, 'egg yolk');
INSERT INTO INGREDIENT
VALUES(14037, 'alcohol');
INSERT INTO INGREDIENT
VALUES(18079, 'breadcrumbs');
INSERT INTO INGREDIENT
VALUES(1022020, 'garlic powder');
INSERT INTO INGREDIENT
VALUES(1022027, 'italian seasoning');
INSERT INTO INGREDIENT
VALUES(10011549, 'pasta sauce');
INSERT INTO INGREDIENT
VALUES(98970, 'string cheese');
INSERT INTO INGREDIENT
VALUES(11207, 'dandelion greens');
INSERT INTO INGREDIENT
VALUES(2044, 'fresh basil');
INSERT INTO INGREDIENT
VALUES(11416, 'squash blossoms');
INSERT INTO INGREDIENT
VALUES(12147, 'pine nuts');
INSERT INTO INGREDIENT
VALUES(12131, 'macadamia nuts');
INSERT INTO INGREDIENT
VALUES(93690, 'nutritional yeast flakes');
INSERT INTO INGREDIENT
VALUES(18372, 'baking soda');
INSERT INTO INGREDIENT
VALUES(1230, 'buttermilk');
INSERT INTO INGREDIENT
VALUES(9216, 'orange zest');
INSERT INTO INGREDIENT
VALUES(1095, 'sweetened condensed milk');
INSERT INTO INGREDIENT
VALUES(10018166, 'oreo cookies');
INSERT INTO INGREDIENT
VALUES(1012050, 'artificial vanilla');
INSERT INTO INGREDIENT
VALUES(19165, 'hersheys cocoa');
INSERT INTO INGREDIENT
VALUES(19903, 'semisweet chocolate');
INSERT INTO INGREDIENT
VALUES(14209, 'coffee');
INSERT INTO INGREDIENT
VALUES(19348, 'fudge ice cream topping');
INSERT INTO INGREDIENT
VALUES(19177, 'gelatin');
INSERT INTO INGREDIENT
VALUES(1016973, 'gochujang');
INSERT INTO INGREDIENT
VALUES(19172, 'lemon flavored gelatin');
INSERT INTO INGREDIENT
VALUES(10018173, 'marie biscuits');
INSERT INTO INGREDIENT
VALUES(11011, 'asparagus');
INSERT INTO INGREDIENT
VALUES(10011268, 'dried porcini mushrooms');
INSERT INTO INGREDIENT
VALUES(10020005, 'farro');
INSERT INTO INGREDIENT
VALUES(1012068, 'sherry vinegar');
INSERT INTO INGREDIENT
VALUES(10014214, 'instant espresso');
INSERT INTO INGREDIENT
VALUES(10023572, 'ground chuck');
INSERT INTO INGREDIENT
VALUES(1036, 'ricotta cheese');
INSERT INTO INGREDIENT
VALUES(2027, 'oregano');
INSERT INTO INGREDIENT
VALUES(1033, 'parmesan');
INSERT INTO INGREDIENT
VALUES(11549, 'canned tomato sauce');
INSERT INTO INGREDIENT
VALUES(1032009, 'red pepper flakes');
INSERT INTO INGREDIENT
VALUES(7057, 'pepperoni');
INSERT INTO INGREDIENT
VALUES(1035, 'provolone');
INSERT INTO INGREDIENT
VALUES(18010, 'baking mix');
INSERT INTO INGREDIENT
VALUES(10619297, 'cherry jam');
INSERT INTO INGREDIENT
VALUES(1001053, 'whipping cream');
INSERT INTO INGREDIENT
VALUES(10225, 'boneless pork roast');
INSERT INTO INGREDIENT
VALUES(1089003, 'granny smith apple');
INSERT INTO INGREDIENT
VALUES(2048, 'apple cider vinegar');
INSERT INTO INGREDIENT
VALUES(1002002, 'chinese five spice');
INSERT INTO RECIPE
VALUES(
    638343,
    'Chicken Stew For The Soul',
    2,
    1.43,
    45,
    6,
    'Chicken Stew For The Soul might be just the main course you are searching for. Watching your figure? This gluten free, dairy free, and whole 30 recipe has <b>497 calories</b>, <b>34g of protein</b>, and <b>33g of fat</b> per serving. For <b>$1.81 per serving</b>, this recipe <b>covers 23%</b> of your daily requirements of vitamins and minerals. It will be a hit at your <b>Autumn</b> event. If you have cardamoms, salt, ground tumeric, and a few other ingredients on hand, you can make it. To use up the onion you could follow this main course with the <a href="https://spoonacular.com/recipes/candy-corn-cupcakes-63881">Candy Corn Cupcakes</a> as a dessert. Only a few people made this recipe, and 9 would say it hit the spot. From preparation to the plate, this recipe takes roughly <b>45 minutes</b>. All things considered, we decided this recipe <b>deserves a spoonacular score of 57%</b>. This score is good. Try <a href="https://spoonacular.com/recipes/chicken-for-babies-soul-543682">Chicken For Babies Soul</a>, <a href="https://spoonacular.com/recipes/chicken-soup-for-the-soul-101305">Chicken Soup for the Soul</a>, and <a href="https://spoonacular.com/recipes/chicken-riggies-and-scarole-with-soul-334500">Chicken Riggies and ''Scarole with Soul</a> for similar recipes.',
    'step 1 : Slice the onions, slit the chillies, cube the potatoes and keep aside.
step 2 : Heat oil in a heavy bottomed pan or pressure cooker, splutter mustard seeds.
step 3 : Add the whole spices and stir till you begin to get the aroma of the spices.
step 4 : Add sliced onions,curry leaves and green chillies and saute.Stir in the ground coriander and add the marinaded chicken. Stir so that the chicken is covered well in the sauteed mixture.Cover and let it cook. When it is half done add the cubed potatoes.When the chicken is almost done add the garam masala,salt and coconut milk and stir.When done put off the heat and garnish with chopped fresh coriander.Have I forgotten the most important ingredient? Stir it with lots of love for the family and friends who will partake of the meal.
step 5 : Serve hot chicken stew with freshly made appams.
',
    'https://spoonacular.com/recipeImages/638343-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    638409,
    'Chicken Verde Enchilada Casserole',
    2,
    2.27,
    45,
    5,
    'Chicken Verde Enchilada Casserole is a <b>gluten free</b> main course. This recipe serves 6. One serving contains <b>486 calories</b>, <b>34g of protein</b>, and <b>24g of fat</b>. For <b>$2.27 per serving</b>, this recipe <b>covers 21%</b> of your daily requirements of vitamins and minerals. This recipe from Foodista has 13 fans. It is a <b>reasonably priced</b> recipe for fans of Mexican food. If you have chicken breasts, cream, cheddar cheese, and a few other ingredients on hand, you can make it. <b>Autumn</b> will be even more special with this recipe. From preparation to the plate, this recipe takes about <b>about 45 minutes</b>. Taking all factors into account, this recipe <b>earns a spoonacular score of 56%</b>, which is solid. Similar recipes are <a href="https://spoonacular.com/recipes/verde-chicken-enchilada-casserole-1031653">Verde Chicken Enchilada Casserole</a>, <a href="https://spoonacular.com/recipes/chicken-enchilada-verde-dip-604535">Chicken Enchilada Verde Dip</a>, and <a href="https://spoonacular.com/recipes/verde-chicken-enchilada-pizza-567511">Verde Chicken Enchilada Pizza</a>.',
    'step 1 : Preheat oven to 350 degrees.
step 2 : In a large skillet, heat olive oil.
step 3 : Sprinkle both sides of chicken breasts with seasoning to taste.
step 4 : Brown chicken in olive oil.  Cook 10 minutes. (chicken will cook more later)
step 5 : Cut/Shred cooked chicken into small pieces, set aside in small bowl.
step 6 : Combine shredded cheeses into a small bowl, set aside.
step 7 : Empty enchilada sauce into large bowl, set aside.
step 8 : Wrap tortillas in a moist paper towel and microwave for 1 minute to steam.
step 9 : Dip one warm corn tortilla into the enchilada sauce, coat both sides.
step 10 : Cover the bottom of a 13 x 9 baking dish with dipped tortillas (approx 4).
step 11 : Layer in the shredded/diced chicken on top of the tortillas.
step 12 : Layer in the cheeses on top of the chicken.
step 13 : Repeat layering dipped tortillas, chicken and cheese until baking dish is full.
step 14 : Finish with a layer of dipped tortillas topped with a layer of cheese.
step 15 : Bake at 350 degrees for 30-40 minutes or until cheese is melted.
step 16 : Top with your choice of sour cream, guacamole, diced tomatoes and/or chopped green onions.
',
    'https://spoonacular.com/recipeImages/638409-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    716407,
    'Simple Whole Wheat Crepes',
    1,
    0.54,
    45,
    6,
    'You can never have too many Mediterranean recipes, so give Simple Whole Wheat Crepes a try. This morn meal has <b>273 calories</b>, <b>10g of protein</b>, and <b>14g of fat</b> per serving. This recipe serves 4 and costs 54 cents per serving. It is brought to you by fullbellysisters.blogspot.com. A mixture of sea salt, eggs, white whole wheat flour, and a handful of other ingredients are all it takes to make this recipe so yummy. This recipe is liked by 110 foodies and cooks. From preparation to the plate, this recipe takes around <b>45 minutes</b>. It is a good option if you''re following a <b>lacto ovo vegetarian</b> diet. All things considered, we decided this recipe <b>deserves a spoonacular score of 46%</b>. This score is pretty good. If you like this recipe, take a look at these similar recipes: <a href="https://spoonacular.com/recipes/whole-wheat-crepes-882970">Whole Wheat Crepes</a>, <a href="https://spoonacular.com/recipes/whole-wheat-crpes-665280">Whole Wheat Crêpes</a>, and <a href="https://spoonacular.com/recipes/whole-wheat-crpes-520226">Whole Wheat Crêpes</a>.',
    'step 1 : Place all ingredients in a blender and mix until smooth. The batter should be thin.
step 2 : Let it sit at least 30 minutes—or even overnight.When it comes time to cook your crêpes you can do it the traditional way, in a crêpe pan, or you can use an electric crêpe maker.
',
    'https://spoonacular.com/recipeImages/716407-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    633096,
    'Autumn Harvest Quail',
    3,
    16.19,
    45,
    1,
    'Autumn Harvest Quail takes around <b>about 45 minutes</b> from beginning to end. For <b>$16.19 per serving</b>, this recipe <b>covers 48%</b> of your daily requirements of vitamins and minerals. One portion of this dish contains roughly <b>42g of protein</b>, <b>34g of fat</b>, and a total of <b>858 calories</b>. This recipe serves 4. If you have spinach, butter, quinoa, and a few other ingredients on hand, you can make it. 11 person have tried and liked this recipe. It is brought to you by Foodista. With a spoonacular <b>score of 82%</b>, this dish is awesome. Try <a href="https://spoonacular.com/recipes/autumn-harvest-cobbler-418019">Autumn Harvest Cobbler</a>, <a href="https://spoonacular.com/recipes/autumn-harvest-minestrone-21038">Autumn Harvest Minestrone</a>, and <a href="https://spoonacular.com/recipes/autumn-harvest-chowder-101727">Autumn Harvest Chowder</a> for similar recipes.',
    ' step 1: Separate raisins
        from nuts
            and seeds in Tropical Foods Diet Delight.step 2: QUAIL step 3: Preheat oven to 400 degrees;
stuff each quail with shallot,
one garlic clove,
one orange wedge,
one sprig of thyme,
one sprig of rosemary.\ step 4: Rub quail with butter,
season with salt
and pepper.step 5: Roast quail for 10 minutes at 400 degrees,
then at 375 degrees for 30 minutes.step 6: QUINOA step 7: In a small saucepan,
add raisins
from Diet Delight,
    balsamic vinegar,
    sugar,
    garlic,
    and rosemary;
slowly simmer until it is thickened.step 8: Boil chicken stock;
add quinoa
    and butternut squash.step 9: Simmer gently for about 25 minutes.step 10: SPINACH step 11: Toast nuts
    and seeds
from Diet Delight in butter with garlic
    and shallots.Saut spinach with mixture,
    then deglaze pan with white wine
    and season with salt
    and pepper.step 12: SERVING step 13: Remove quail
from oven
    and rest for 2 minutes.step 14: Sauce plate;
add bed of quinoa,
    top with spinach mixture,
    and quail.',
    ' https: / / spoonacular.com / recipeImages / 633096 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    633971,
    ' Banana & Cream Cheese Stuffed French Toast ',
    2,
    2.45,
    45,
    8,
    ' The recipe Banana & Cream Cheese Stuffed French Toast is ready < b > in around 45 minutes < / b >
    and is definitely an awesome < b > vegetarian < / b > option for lovers of American food.This morn meal has < b > 1978 calories < / b >,
    < b > 49g of protein < / b >,
    and < b > 57g of fat < / b > per serving.For < b > $2.45 per serving < / b >,
    this recipe < b > covers 51 % < / b > of your daily requirements of vitamins
    and minerals.Head to the store
    and pick up milk,
    honey,
    maple syrup,
    and a few other things to make it today.10 people have tried
    and liked this recipe.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 90 % < / b >.This score is spectacular.Try < a href = "https://spoonacular.com/recipes/cream-cheese-stuffed-french-toast-739876" > Cream Cheese - Stuffed French Toast < / a >,
    < a href = "https://spoonacular.com/recipes/banana-and-cream-cheese-stuff-french-toast-49537" > Bananan
    And Cream Cheese Stuff French Toast < / a >,
    and < a href = "https://spoonacular.com/recipes/pumpkin-cream-cheese-stuffed-french-toast-615250" > Pumpkin Cream Cheese Stuffed French Toast < / a > for similar recipes.',
    ' step 1: In a small bowl combine the softened cream cheese,
    honey,
    cinnamon,
    nutmeg
    and lemon juice,
    set aside while preparing the batter.step 2: Whisk together all of the batter ingredients until thoroughly mixed.(This is a breeze if you use a blender.) step 3: Pour the batter into a wide,
    shallow dish (like a pie plate).step 4: Spread the filling mixture equally over 1 side of each slice of bread,
    divide the sliced bananas between 4 slices of the bread,
    top with the remaining 4 slices,
    press lightly.Melt 2 t.butter
    and 2 t.oil in a 12 inch nonstick skillet over medium heat until the butter foams
    and then subsides.Working with one sandwich at a time dip both sides in the batter
    and let the excess drip away,
    add to the hot pan,
    repeat with a second sandwich.Cook until golden brown on the first side,
    around 3 -5 minutes,
    flip
    and repeat on the second side.Repeat this process with the remaining,
    oil,
    butter
    and sandwiches.To serve,
    cut into triangles
    and serve with maple syrup.',
    ' https: / / spoonacular.com / recipeImages / 633971 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    716416,
    ' Tomato,
    Cucumber & Onion Salad with Feta Cheese: Real Convenience Food ',
    1,
    5.26,
    45,
    10,
    ' You can never have too many side dish recipes,
    so give Tomato,
    Cucumber & Onion Salad with Feta Cheese: Real Convenience Food a try.This recipe serves 1
    and costs $5.34 per serving.One serving contains < b > 262 calories < / b >,
    < b > 8g of protein < / b >,
    and < b > 16g of fat < / b >.If you have onion,
    extra virgin olive oil,
    feta cheese,
    and a few other ingredients on hand,
    you can make it.265 people were impressed by this recipe.It is a good option if you '' re following a < b > gluten free,
    primal,
    and vegetarian < / b > diet.
From preparation to the plate,
    this recipe takes roughly < b > 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 92 % < / b >.This score is spectacular.Try < a href = "https://spoonacular.com/recipes/asparagus-and-pea-soup-real-convenience-food-716406" > Asparagus
    and Pea Soup: Real Convenience Food < / a >,
    < a href = "https://spoonacular.com/recipes/butternut-squash-pear-soup-real-convenience-food-716415" > Butternut Squash & Pear Soup: Real Convenience Food < / a >,
    and < a href = "https://spoonacular.com/recipes/tomato-cucumber-and-onion-salad-with-feta-vinaigrette-23013" > Tomato,
    Cucumber
    And Onion Salad With Feta Vinaigrette < / a > for similar recipes.',
    '',
    ' https: / / spoonacular.com / recipeImages / 716416 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    635552,
    ' Blueberry Vanilla Pie ',
    2,
    13.22,
    45,
    7,
    ' Need a < b > vegetarian dessert < / b > ? Blueberry Vanilla Pie could be a great recipe to try.For < b > $13.22 per serving < / b >,
    this recipe < b > covers 56 % < / b > of your daily requirements of vitamins
    and minerals.This recipe makes 1 servings with < b > 4164 calories < / b >,
    < b > 42g of protein < / b >,
    and < b > 259g of fat < / b > each.Head to the store
    and pick up sugar,
    whipped cream,
    juice of lemon,
    and a few other things to make it today.A few people made this recipe,
    and 14 would say it hit the spot.
From preparation to the plate,
    this recipe takes approximately < b > 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 85 % < / b >.This score is great.Try < a href = "https://spoonacular.com/recipes/blueberry-crumble-pie-920226" > Blueberry Crumble Pie < / a >,
    < a href = "https://spoonacular.com/recipes/blueberry-ginger-vanilla-jam-42241" > Blueberry Ginger Vanilla Jam < / a >,
    and < a href = "https://spoonacular.com/recipes/canning-101-and-blueberry-vanilla-jam-795010" > Canning 101
    and Blueberry Vanilla Jam < / a > for similar recipes.',
    ' step 1: Combine flour,
    sugar,
    salt,
    lemon zest
    and finely ground almonds.step 1: Mix the egg with the vanilla sugar,
    add density
    and flavor of vanilla.Half of vanilla pod put in cream
    and
add to boil.When boil remove the pod.Scrape the seeds
    and
add to the cream.step 2: Remove cream
from heat,
    stirring constantly
    and pour the egg mixture.Quite a short return to the fire that starts to thicken.Leave aside to cool slightly.Blueberries filling :Half of blueberries mix with sugar,
    lemon juice
    and density.Cook over medium heat stirring constantly,
    until it starts to thicken.Set aside to cool.step 3: Removethe mold
from the freezer.step 4: Pour the egg mixture.step 5: Bake,
    pre - reducing the temperature to 200 C / 392F for 20 minutes.step 6: Remove,
    pour in the filling of blueberries,
    and bake the next 5 -7 minutes.Leave to cool.On cooled pie arrange the remaining half of fresh blueberries.Lightly sprinkle with granulated sugar
    and sliced almonds ',
    ' https: / / spoonacular.com / recipeImages / 635552 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    716405,
    ' Grilled Baked Brie with Shallots,
    Cranberries & Balsamic ',
    2,
    1.70,
    45,
    1,
    ' Grilled Baked Brie with Shallots,
    Cranberries & Balsamic might be just the hor d '' oeuvre you are searching for.Watching your figure ? This gluten free,
    primal,
    and vegetarian recipe has < b > 376 calories < / b >,
    < b > 8g of protein < / b >,
    and < b > 23g of fat < / b > per serving.This recipe serves 1
    and costs $1.7 per serving.A mixture of garlic,
    round of président brie,
    shallots,
    and a handful of other ingredients are all it takes to make this recipe so scrumptious.It can be enjoyed any time,
    but it is especially good for < b > The Fourth Of July < / b >.107 people were impressed by this recipe.
From preparation to the plate,
    this recipe takes approximately < b > 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 54 % < / b >.This score is pretty good.Try < a href = "https://spoonacular.com/recipes/baked-brie-with-cranberries-and-cinnamon-624739" > Baked Brie with Cranberries
    and Cinnamon < / a >,
    < a href = "https://spoonacular.com/recipes/baked-brie-bites-with-sugared-cranberries-403937" > Baked Brie Bites With Sugared Cranberries < / a >,
    and < a href = "https://spoonacular.com/recipes/crescent-wrapped-baked-brie-with-apricots-cranberries-alm-124293" > Crescent Wrapped Baked Brie With Apricots,
    Cranberries & Alm < / a > for similar recipes.',
    '',
    ' https: / / spoonacular.com / recipeImages / 716405 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    652284,
    ' Molten Chocolate Liquor Cakes ',
    3,
    0.95,
    45,
    2,
    ' Molten Chocolate Liquor Cakes might be just the dessert you are searching for.This recipe serves 6
    and costs 95 cents per serving.One serving contains < b > 398 calories < / b >,
    < b > 4g of protein < / b >,
    and < b > 25g of fat < / b >.This recipe is typical of Southern cuisine.A few people made this recipe,
    and 84 would say it hit the spot.A mixture of chocolate,
    liquor,
    eggs,
    and a handful of other ingredients are all it takes to make this recipe so flavorful.It is a good option if you '' re following a < b > gluten free,
    fodmap friendly,
    and vegetarian < / b > diet.
From preparation to the plate,
    this recipe takes roughly < b > 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 25 % < / b >.This score is rather bad.Try < a href = "https://spoonacular.com/recipes/molten-chocolate-liquor-cake-60932" > Molten Chocolate Liquor Cake < / a >,
    < a href = "https://spoonacular.com/recipes/american-cakes-molten-chocolate-cakes-629406" > American Cakes – Molten Chocolate Cakes < / a >,
    and < a href = "https://spoonacular.com/recipes/molten-chocolate-cakes-130842" > Molten Chocolate Cakes < / a > for similar recipes.',
    ' step 1: Melt the chocolate
    and butter together in bain - marie
    and then let cool for a few minutes.Whip eggs,
    egg yolks,
    sugar
    and a pinch of salt until a light yellow color.step 2:
Add the melted chocolate
    and the flour.Grease
    and flour 5
    or 6 ramekins (
        or oven - proof glass cups
    ) tapping out the excess flour.Divide the chocolate cream among the ramekins step 3: Stir in 1 tablespoon of liquor into each ramekin
    and stir.Cover with plastic wrap
    and place in the refrigerator for about one hour
    or until you are ready to bake.Pre - heat the oven to 450 F (230 C)
    and bake for about 13 minutes.step 4: Remove
from the oven,
    edges should be firm but the center will be runny.Run a sharp knife around each cake
    and unmold onto serving plates.step 5: Sprinkle with powdered sugar
    and serve immediately.',
    ' https: / / spoonacular.com / recipeImages / 652284 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    652513,
    ' Mozzarella Sticks ',
    2,
    10.35,
    45,
    3,
    ' Mozzarella Sticks might be just the hor d '' oeuvre you are searching for.For < b > $10.35 per serving < / b >,
    this recipe < b > covers 45 % < / b > of your daily requirements of vitamins
    and minerals.One serving contains < b > 1773 calories < / b >,
    < b > 104g of protein < / b >,
    and < b > 98g of fat < / b >.Head to the store
    and pick up flour,
    water,
    eggs,
    and a few other things to make it today.A couple people made this recipe,
    and 11 would say it hit the spot.
From preparation to the plate,
    this recipe takes approximately < b > 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 83 % < / b >.This score is great.Try < a href = "https://spoonacular.com/recipes/mozzarella-sticks-296374" > Mozzarella Sticks < / a >,
    < a href = "https://spoonacular.com/recipes/mozzarella-sticks-675804" > Mozzarella Sticks < / a >,
    and < a href = "https://spoonacular.com/recipes/mozzarella-sticks-79012" > Mozzarella Sticks < / a > for similar recipes.',
    ' step 1: Taste of Home.It won a prize in their cheese contest.Mary Merchant ofIn a small bowl,
    beat eggs
    and water.In a plastic bag,
    combine bread crumbs,
    Italian seasoning,
    garlic powder
    and pepper.Coat cheese sticks in flour,
    then dip in egg mixture
    and bread crumb mixture.Repeat egg
    and bread crumb coatings.Cover
    and chill for at least 4 hours
    or overnight.step 2: Place on an ungreased baking sheet;
drizzle with butter.step 3: Bake,
uncovered,
at 400 for 6 to 8 minutes
or until heated through.Allow to stand for 3 to 5 minutes before serving.Use marinara
or spaghetti sauce for dipping.',
    ' https: / / spoonacular.com / recipeImages / 652513 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    641227,
    ' Dandelion pesto ',
    1,
    1.33,
    45,
    8,
    ' Dandelion pesto is a < b > gluten free,
dairy free,
paleolithic,
and lacto ovo vegetarian < / b > condiment.This recipe serves 4
and costs $1.33 per serving.One portion of this dish contains approximately < b > 2g of protein < / b >,
< b > 20g of fat < / b >,
and a total of < b > 192 calories < / b >.If you have dandelion greens,
pine nuts,
macadamia nuts,
and a few other ingredients on hand,
you can make it.103 people have made this recipe
and would make it again.It is brought to you by Foodista.
From preparation to the plate,
    this recipe takes approximately < b > approximately 45 minutes < / b >.Taking all factors into account,
    this recipe < b > earns a spoonacular score of 60 % < / b >,
    which is solid.If you like this recipe,
    you might also like recipes such as < a href = "https://spoonacular.com/recipes/dandelion-pesto-14296" > Dandelion Pesto < / a >,
    < a href = "https://spoonacular.com/recipes/dandelion-pumpkin-seed-pesto-14309" > Dandelion Pumpkin Seed Pesto < / a >,
    and < a href = "https://spoonacular.com/recipes/almond-herb-tarts-with-dandelion-pesto-truffled-fontina-figs-9087" > Almond Herb Tarts With Dandelion Pesto,
    Truffled Fontina & Figs < / a >.',
    ' step 1: Wash the dandelion well in a solution of water
    and raw cider vinegar,
    using a couple of tablespoons of vinegar to about a litre of water.Wash
    and spin dry all the greens.Pop all the ingredients into a pestle
    and mortar
    or food processor
    and pound / blitz till nearly smooth - I like to leave a little texture to my pesto but play around with it.
    And that '' s it ! Pretty simple
    and very scrummy.',
    ' https: / / spoonacular.com / recipeImages / 641227 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    662515,
    ' Sweet Florida Orange Breakfast Bread ',
    1,
    0.46,
    45,
    1,
    ' Sweet Floridan Orange Breakfast Bread requires roughly < b > roughly 45 minutes < / b >
from start to finish.This recipe makes 16 servings with < b > 345 calories < / b >,
    < b > 4g of protein < / b >,
    and < b > 13g of fat < / b > each.For < b > 46 cents per serving < / b >,
    this recipe < b > covers 6 % < / b > of your daily requirements of vitamins
    and minerals.6 people found this recipe to be yummy
    and satisfying.A mixture of butter,
    orange juice,
    vanillan extract,
    and a handful of other ingredients are all it takes to make this recipe so scrumptious.It is a good option if you '' re following a < b > lacto ovo vegetarian < / b > diet.It is brought to you by Foodista.Only a few people really liked this breakfast.Overall,
    this recipe earns a < b > not so super spoonacular score of 16 % < / b >.If you like this recipe,
    take a look at these similar recipes: < a href = "https://spoonacular.com/recipes/crispy-pan-seared-florida-snapper-with-passion-fruit-cream-and-florida-citrus-and-shaved-fennel-salad-garnished-with-sauteed-florida-gulf-shrimp-and-spicy-green-mango-jam-740791" > Crispy Pan Seared Florida Snapper with Passion Fruit Cream
    and Florida Citrus
    and Shaved Fennel Salad,
    Garnished with Sauteed Florida Gulf Shrimp
    and Spicy Green Mango Jam < / a >,
    < a href = "https://spoonacular.com/recipes/florida-orange-cake-401320" > Floridan Orange Cake < / a >,
    and < a href = "https://spoonacular.com/recipes/orange-rhubarb-breakfast-bread-430770" > Orange - Rhubarb Breakfast Bread < / a >.',
    ' step 1: Preheat oven to 350F.step 2: Grease
    and lightly flour loaf pans.step 3: In a medium bowl,
    whisk together flour,
    baking powder,
    baking soda,
    and salt.
Set aside.step 4: Measure buttermilk,
    orange juice,
    and vanilla into a measuring cup.
Set aside.step 5: In a large bowl,
    use a mixer to beat the butter until creamy.step 6: Blend in sugar
    and beat for a few minutes until light
    and fluffy.step 7: Mix in eggs,
    one at a time,
    and orange zest,
    and beat until well incorporated.step 8: With mixer on low,
    slowly pour in 1 / 3 of the flour mixture.step 9: Mix in half of the buttermilk mixture.step 10: Blend in another 1 / 3 of the flour mixture
    and remaining buttermilk mixture.step 11:
Add remaining flour mixture
    and mix until just blended.step 12: Divide batter between prepared pans,
    filling about 3 / 4 full,
    and bake for 30 to 35 minutes (45 minutes if using a large loaf pan)
    or until a toothpick inserted in center comes out clean.step 13: While loaves bake,
    prepare orange simple syrup.step 14: Stir together 1 / 2 cup orange juice
    and 1 / 2 cup brown sugar in a small pot.Bring to a boil over medium heat while occasionally stirring,
    then reduce heat
    and simmer for a few minutes.step 15: Remove pot
from heat
    and
set aside to cool.step 16:
    When cakes are done,
    cool for 10 minutes before turning out onto wire rack.
Set rack over a sheet pan
    or piece of foil,
    and using a brush
    or a spoon,
    soak each cake with simple syrup.Allow to cool completely.step 17: Store in an airtight container
    or wrap tightly.',
    ' https: / / spoonacular.com / recipeImages / 662515 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    633970,
    ' Banana & Oreo Muffin ',
    1,
    0.60,
    45,
    9,
    ' Banana & Oreo Muffin is a < b > lacto ovo vegetarian < / b > breakfast.This recipe makes 4 servings with < b > 535 calories < / b >,
    < b > 8g of protein < / b >,
    and < b > 26g of fat < / b > each.For < b > 60 cents per serving < / b >,
    this recipe < b > covers 11 % < / b > of your daily requirements of vitamins
    and minerals.A mixture of condensed milk,
    sugar,
    egg,
    and a handful of other ingredients are all it takes to make this recipe so yummy.15 people have tried
    and liked this recipe.A couple people really liked this Southern dish.It is brought to you by Foodista.
From preparation to the plate,
    this recipe takes approximately < b > approximately 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 29 % < / b >.This score is not so outstanding.< a href = "https://spoonacular.com/recipes/the-best-ever-banana-muffin-65697" > The Best Ever Banana Muffin < / a >,
    < a href = "https://spoonacular.com/recipes/banana-muffin-763481" > Banana Muffin < / a >,
    and < a href = "https://spoonacular.com/recipes/banana-muffin-pudding-407377" > Banana Muffin Pudding < / a > are very similar to this recipe.',
    ' step 1: Sift the flour,
    baking power
    and baking soda together
    and
set aside.step 2: Remove the cream
from the cookies,
    place the cookies in a ziplock bag,
    use a rolling pin,
    crush the cookie into fine crumbs.step 3: Cream butter
    and sugar with electric beater till light
    and fluffy(about 3 minutes on medium speed).step 4:
Add in egg one at a time
    and beat till the mixture is well combine without any egg trace.step 5:
Add mashed banana,
    vanilla essence
    and condensed milk into the butter mixture
    and give it a quick whisk.step 6: Lower the mixer speed,
    add flour mixture
    and blend the mixture till smooth.step 7: Stir in the oreo cookies crumbs till combined,
    scoop the mixture into prepared muffin cups to 3 / 4 full.step 8: Top the muffin batter with some extra banana slices
    and oreo cookies,
    bake them in preheated 180 degree oven for about 20 - 25 minutes
    or till a toothpick inserted in the center
    and comes out clean.',
    ' https: / / spoonacular.com / recipeImages / 633970 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    642648,
    ' Favorite Moist Chocolate Cake ',
    3,
    1.02,
    45,
    4,
    ' For < b > $1.02 per serving < / b >,
    this recipe < b > covers 11 % < / b > of your daily requirements of vitamins
    and minerals.One serving contains < b > 387 calories < / b >,
    < b > 7g of protein < / b >,
    and < b > 23g of fat < / b >.Head to the store
    and pick up coffee,
    cream cheese,
    baking soda,
    and a few other things to make it today.This recipe is liked by 146 foodies
    and cooks.
From preparation to the plate,
    this recipe takes approximately < b > 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 46 % < / b >.This score is good.Try < a href = "https://spoonacular.com/recipes/moist-chocolate-cake-54792" > Moist Chocolate Cake < / a >,
    < a href = "https://spoonacular.com/recipes/moist-chocolate-cake-373094" > Moist Chocolate Cake < / a >,
    and < a href = "https://spoonacular.com/recipes/moist-chocolate-cake-373092" > Moist Chocolate Cake < / a > for similar recipes.',
    ' step 1: To Make Cake :Sift together dry ingredients.step 2:
Add oil,
    coffee
    and milk.step 3: Whisk until combined.step 4:
Add eggs
    and vanilla.step 5: Whisk until well incorperated (about 2 min.).It will be quite runny.Grease
    and flour 2 - 9 inch round pans.step 6: Pour the batter into the pans
    and bake at 325F for 25 -30 min until a toothpick inserted into the centre comes out clean.step 1: Mix together the cream cheese
    and sugar until completely smooth.step 2: Mix in the pureed strawberries.Whip the cream to stiff peaks
    and fold into the strawberry cream cheese mixture.Line a 9 inch round pan (the same size you used for the cakes) with plastic wrap
    and pour the mousse inside.Freeze until solid.To Make Ganache :Bring cream to a boil over medium heat.Poor over chocolate.step 3: Let sit for a moment then stir until smooth.step 1: Remove mousse
from freezer
    and unwrap.step 2: Place one cake layer on serving platter.Position frozen mousse in the centre
    and top with remaining cake layer.Allow to thaw for 30 min,
    or so.Meanwhile drizzle with ganache
    and garnish with fresh strawberries.',
    ' https: / / spoonacular.com / recipeImages / 642648 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    649056,
    ' Korean Honey Citron Tea Cheesecake ',
    1,
    1.22,
    45,
    7,
    ' Korean Honey Citron Tea Cheesecake might be just the < b > Korean < / b > recipe you are searching for.For < b > $1.22 per serving < / b >,
    this recipe < b > covers 7 % < / b > of your daily requirements of vitamins
    and minerals.One serving contains < b > 451 calories < / b >,
    < b > 6g of protein < / b >,
    and < b > 26g of fat < / b >.58 people have made this recipe
    and would make it again.Head to the store
    and pick up sugar,
    milk,
    marie biscuits,
    and a few other things to make it today.
From preparation to the plate,
    this recipe takes roughly < b > 45 minutes < / b >.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 26 % < / b >.This score is not so great.Try < a href = "https://spoonacular.com/recipes/tartelettes-au-citron-53422" > Tartelettes Au Citron < / a >,
    < a href = "https://spoonacular.com/recipes/confiture-dolives-et-citron-53423" > Confiture D '' olives Et Citron < / a >,
    and < a href = "https://spoonacular.com/recipes/carrs-au-citron-recette-546806" > Carrés au citron Recette < / a > for similar recipes.',
    ' step 1: Line a 23cm round pan (with removable base)
set aside.step 2: Combine crushed digestive biscuit crumbs
    and melted butter together in a mixing bowl.Press the biscuit crumbs onto the base of the prepared pan
    and put it in the refrigerator for later use.Measure water into a bowl
    and sprinkle in the gelatin (without stirring with a spoon).
Set aside to allow the gelatin to swell (few mins) before setting the bowl over a pot of simmering hot water.Stir with a spoon
    and once the gelatin melts,
    remove the bowl
from the pot
    and
set aside to cool to room temperature.step 3: Whisk non - dairy topping cream until peak form (not too stiff),
    set aside.In another mixing bowl,
    beat cream cheese
    and sugar until smooth,
    then gradually
add in milk until combined.step 4:
Add lemon juice,
    honey citron tea paste,
    mix to combine
    and
add gelatin solution,
    mix well.Fold in whipped non - dairy topping cream,
    with a hand whisk.step 5: Pour cream cheese mixture on the prepared cake tin
    and refrigerate for at least 4 hours until
set.To make the topping,
    heat the gelatin (method same as above)
    and stir in honey citron tea paste,
    mix well
    and leave to cool.step 6: Spread the honey citron tea paste thinly
    and evenly on top of the cheesecake.Refrigerate the cheese cake until it is ready to serve.',
    ' https: / / spoonacular.com / recipeImages / 649056 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    642605,
    ' Farro With Mushrooms
    and Asparagus ',
    1,
    3.94,
    75,
    2,
    ' Need a < b > dairy free
    and vegetarian side dish < / b > ? Farro With Mushrooms
    and Asparagus could be an excellent recipe to try.This recipe makes 4 servings with < b > 365 calories < / b >,
    < b > 12g of protein < / b >,
    and < b > 9g of fat < / b > each.For < b > $3.94 per serving < / b >,
    this recipe < b > covers 23 % < / b > of your daily requirements of vitamins
    and minerals.
From preparation to the plate,
    this recipe takes around < b > 1 hour
    and 15 minutes < / b >.This recipe is liked by 47 foodies
    and cooks.If you have onion,
    chicken stock,
    garlic,
    and a few other ingredients on hand,
    you can make it.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 98 % < / b >.This score is amazing.Similar recipes include < a href = "https://spoonacular.com/recipes/farro-risotto-with-wild-mushrooms-and-asparagus-495316" > Farro Risotto with Wild Mushrooms
    and Asparagus < / a >,
    < a href = "https://spoonacular.com/recipes/farro-with-asparagus-hazelnuts-and-kale-topped-with-roasted-mushrooms-298005" > Farro with Asparagus,
    Hazelnuts
    and Kale Topped with Roasted Mushrooms < / a >,
    and < a href = "https://spoonacular.com/recipes/farro-and-porcini-mushrooms-farro-con-funghi-40485" > Farro
    And Porcini Mushrooms (farro Con Funghi) < / a >.',
    ' step 1: In a small bowl,
    cover dried mushrooms with warm water.Soak for 25 minutes,
    or until softened.step 2: Drain the mushrooms,
    and discard the soaking water.Chop finely.Bring a large pot of water to a boil.step 3:
Add farro,
    and cook for 10 minutes,
    stirring occasionally.step 4: Drain
    and reserve.In a large skillet,
    over medium heat,
    heat the olive oil,
    and
add onion,
    garlic,
    thyme,
    and mushrooms.Cook,
    stirring occasionally,
    for 5 minutes
    or until onions are tender.Stir in 2 tablespoons of sherry vinegar,
    and continue cooking for 1 minute.step 5:
Add chicken stock,
    and bring it to a boil.Stir in farro,
    and return to a boil.Lower the heat to a simmer,
    and cover with a tight fitting lid.Cook for 10 minutes.step 6:
Add asparagus,
    and cook,
    covered,
    for an additional 10 minutes.Season with 1 tablespoon sherry vinegar,
    salt
    and pepper.',
    ' https: / / spoonacular.com / recipeImages / 642605 - 556x370.jpg ',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    644081,
    ' Fudgy chocolate cream cheese brownies with Baileys ',
    3,
    1.38,
    45,
    1,
    ' The recipe Fudgy chocolate cream cheese brownies with Baileys could satisfy your American craving in roughly < b > 45 minutes < / b >.This recipe makes 8 servings with < b > 581 calories < / b >,
    < b > 7g of protein < / b >,
    and < b > 34g of fat < / b > each.For < b > $1.35 per serving < / b >,
    this recipe < b > covers 9 % < / b > of your daily requirements of vitamins
    and minerals.If you have flour,
    bittersweet chocolate,
    sugar,
    and a few other ingredients on hand,
    you can make it.This recipe
from Foodista has 143 fans.All things considered,
    we decided this recipe < b > deserves a spoonacular score of 34 % < / b >.This score is rather bad.Try < a href = "https://spoonacular.com/recipes/fudgy-cream-cheese-brownies-221991" > Fudgy Cream Cheese Brownies < / a >,
    < a href = "https://spoonacular.com/recipes/ultimate-fudgy-cappuccino-cream-cheese-brownies-55124" > Ultimate Fudgy Cappuccino Cream Cheese Brownies < / a >,
    and < a href = "https://spoonacular.com/recipes/chocolate-stout-cake-with-baileys-irish-cream-cheese-frosting-507379" > Chocolate Stout Cake with Baileys Irish Cream Cheese Frosting < / a > for similar recipes.',
    ' step 1: To make the chocolate layer,
    place chocolate
    and butter in a large glass dish (
        you will be adding the eggs,
        sugar,
        and flour to it later
    )
    and microwave 1.5 minutes.The chocolate may hold its shape
    when you remove it
from the microwave,
    but it will be soft,
    so stir to melt it.If pieces remain
after you have stirred it for a while then return to microwave for another few seconds
    and then stir again until it is fully melted.Be careful not to overheat the chocolate.You are better off starting with less time
    and reheating than overheating
    and ruining it.When chocolate has melted
add the sugar
    and vanilla
    and stir with a whisk to combine.step 2: Let it cool a little
    and then
add the eggs,
    one at a time,
    whisking
after each addition.Don '' t
add the eggs
    when the chocolate is hot because it may cook the whites.Once the eggs are mixed in,
    place the flour in a strainer
    and sift over the chocolate mixture,
    a little at a time,
    mixing it in as you sift it over.
Set aside while you prepare the cream cheese layer.For the cream cheese layer,
    place the cream cheese in a bowl
    and mix with a hand mixer for a couple of minutes until soft.step 3:
Add the sugar
    and mix to blend it in.step 4:
Add egg
    and beat to incorporate.step 5:
Add Bailey '' s
    and stir it in.To assemble,
    spray an 8 " square baking pan with straight sides with non-stick spray, or butter and flour it. You can also line the baking pan with parchment, leaving the edges high so you can lift the entire cake out of the pan.
step 6 : Pour the chocolate mixture into the pan and tilt it to spread it out evenly.
step 7 : Pour the cream cheese mixture over it, and with a fork, swirl the layers so some of the chocolate shows on top and the cream cheese layer becomes part of the chocolate layer. Do not over mix - you just want some swirls.
step 8 : Place in a preheated 350 degree F oven and bake for 35 minutes or until a knife inserted into the center comes out clean. Do not over bake.
step 9 : Remove from oven and let cool before cutting into squares.
',
    'https://spoonacular.com/recipeImages/644081-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    641893,
    'Easy Cheesy Pizza Casserole',
    2,
    3.01,
    45,
    10,
    'Forget going out to eat or ordering takeout every time you crave Mediterranean food. Try making Easy Cheesy Pizza Casserole at home. For <b>$3.01 per serving</b>, this recipe <b>covers 32%</b> of your daily requirements of vitamins and minerals. One serving contains <b>724 calories</b>, <b>41g of protein</b>, and <b>43g of fat</b>. This recipe serves 6. It works well as a pretty expensive main course. This recipe from Foodista requires equivalent amount of a ground beef/bulk sausage mix, additional parmesan cheese, herbed parmesan drop biscuits, and milk. 181 person were impressed by this recipe. It can be enjoyed any time, but it is especially good for <b>Autumn</b>. From preparation to the plate, this recipe takes about <b>about 45 minutes</b>. Overall, this recipe earns a <b>tremendous spoonacular score of 82%</b>. Users who liked this recipe also liked <a href=" https: / / spoonacular.com / recipes / cheesy - pizza - casserole -166010 ">Cheesy Pizza Casserole</a>, <a href=" https: / / spoonacular.com / recipes / 20 - minute - cheesy - pizza - casserole -619758 ">20 Minute Cheesy Pizza Casserole</a>, and <a href=" https: / / spoonacular.com / recipes / cheesy - pizza - pasta - casserole -542709 ">Cheesy Pizza Pasta Casserole</a>.',
    'step 1 : Brown ground beef in skillet; drain fat.
step 2 : Mix in pasta or pizza sauce and pepper flakes; set aside.
step 3 : Mix ricotta cheese with the herbs and Parmesan in a separate bowl; set aside.
step 4 : Mix the dry ingredients for the biscuits.
step 5 : Add milk and stir until combined.
step 6 : Preheat oven to 375 degrees.  Spray a 13 x 9 pan with non-stick spray.  Drop biscuit dough by teaspoons in the bottom of pan, spacing evenly.  It''s OK if there is space between the dough--it will expand as it''s cooked.  Top with ground beef mixture and dot with the ricotta cheese mixture.
step 7 : Bake at 375 for about 20 min or until biscuits are puffed and beginning to get golden brown.
step 8 : Top with mozzarella and provolone cheeses and distribute pepperoni slices evenly over top, increase oven temperature to 425 degrees.  Return to oven and bake until cheeses are melted and beginning to bubble.  This should take about 10 minutes.
step 9 : Remove from oven and let stand 5 minutes before slicing and serving.  May be topped with the additional Parmesan cheese.
',
    'https://spoonacular.com/recipeImages/641893-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    631762,
    'Strawberry Tart',
    1,
    3.83,
    45,
    5,
    'Strawberry Tart takes about <b>approximately 45 minutes</b> from beginning to end. This dessert has <b>846 calories</b>, <b>7g of protein</b>, and <b>41g of fat</b> per serving. This lacto ovo vegetarian recipe serves 4 and costs <b>$3.83 per serving</b>. A mixture of orange zest, strawberries, butter, and a handful of other ingredients are all it takes to make this recipe so delicious. 8 people were impressed by this recipe. <b>Mother''s Day</b> will be even more special with this recipe. It is brought to you by Foodista. With a spoonacular <b>score of 43%</b>, this dish is solid. <a href=" https: / / spoonacular.com / recipes / strawberry - tart -72628 ">Strawberry Tart</a>, <a href=" https: / / spoonacular.com / recipes / strawberry - tart -576549 ">Strawberry Tart</a>, and <a href=" https: / / spoonacular.com / recipes / strawberry - tart -386401 ">Strawberry Tart</a> are very similar to this recipe.',
    'step 1 : Preheat oven to 350 degrees F.
step 2 : Sift flour onto a board or into a bowl. Make a well in the center.
step 3 : Add the butter, water, egg yolk, sugar, vanilla, and orange zest. Work the ingredients in the center, drawing in the flour until the dough is smooth.
step 4 : Pat out the dough onto the bottom and sides of a pie plate. Prick the bottom and sides of the dough with a fork.
step 5 : Bake got 15-20 minutes, or until the pastry is light golden. Cool.
step 6 : To make the glaze, put the cherry preserves in a small saucepan and melt it slowly over low heat. Cool slightly and brush over the bottom of the pastry.
step 7 : Wash, hull and slice the strawberries. Fill the pie plate with the strawberries and top with remaining cherry glaze.
step 8 : Whip cream with 1 tablespoon of confectioners sugar until light and fluffy and serve with a slice of strawberry tart! Enjoy!
',
    'https://spoonacular.com/recipeImages/631762-556x370.jpg',
    NOW()
  );
INSERT INTO RECIPE
VALUES(
    632590,
    'Apple Roasted Pork Loin',
    2,
    3.54,
    45,
    5,
    'If you want to add more <b>gluten free, dairy free, paleolithic, and primal</b> recipes to your recipe box, Apple Roasted Pork Loin might be a recipe you should try. For <b>$3.54 per serving</b>, this recipe <b>covers 27%</b> of your daily requirements of vitamins and minerals. This recipe serves 6. This main course has <b>512 calories</b>, <b>51g of protein</b>, and <b>17g of fat</b> per serving. 7 people have made this recipe and would make it again. From preparation to the plate, this recipe takes around <b>45 minutes</b>. It is brought to you by Foodista. If you have rib roast, granny smith apples, olive oil, and a few other ingredients on hand, you can make it. Overall, this recipe earns a <b>pretty good spoonacular score of 57%</b>. Try <a href=" https: / / spoonacular.com / recipes / roasted - pork - loin - with - apple - onion - dried - plum - stuffing -45905 ">Roasted Pork Loin With Apple, Onion & Dried Plum Stuffing</a>, <a href=" https: / / spoonacular.com / recipes / roasted - pork - loin - with - roasted - garlic - vinaigrette -293351 ">Roasted Pork Loin with Roasted Garlic Vinaigrette</a>, and <a href=" https: / / spoonacular.com / recipes / apple - glazed - pork - loin -81881 ">Apple-glazed Pork Loin</a> for similar recipes.',
    'step 1 : Apple Roasted Pork Loin
step 2 : Apples and pork is a pretty traditional combination and I couldn''t count the number of ways I''ve put the two together in the past but this one is a little different. The Granny Smith apples are diced quite small and then cooked in a reduction of honey, apple cider vinegar and spices. Granny Smiths are good to use because they won''t break down into apple sauce during the cooking. The cooked apples are then used as a top crust and glaze for the roast pork. Some garlic roast potatoes and steamed veggies completed a wonderful family meal. Here''s your Sunday supper!Lb pork loin or rib roast
step 3 : Season the pork with salt and pepper and open roast on a rack in a roasting pan at 375 degrees F for about a half hour.Meanwhile dice very small, (about a 1/4 inch dice)Large Granny Smith apples, peeled and cored
step 4 : In a large saute pan over medium heat add:Tbsp olive oil
step 5 : Cloves minced garlic
step 6 : Cook for a minute or two to soften but not brown the garlic.
step 7 : Add:Cup honey
step 8 : Cup apple cider vinegar
step 9 : Tsp pepper
step 10 : Tsp sea salt
step 11 : Teaspoon Chinese five spice powder
step 12 : Tsp freshly grated nutmeg
step 13 : Bring the mixture to a boil and simmer until the volume is reduced by about half. Increase the heat to mediun-high.
step 14 : Add the diced apple and cook, stirring occasionally until most of the liquid has reduced off.After half an hour in the oven, take the roast out and spoon the apples all over the top. Return the roast to the oven, reduce the heat to 350 degrees F and cook uncovered until the internal temperature reaches 170 degrees F on a meat thermomether inserted into the center of the roast. Allow the pork to rest for about 15 minutes before carving and serving.
',
    'https://spoonacular.com/recipeImages/632590-556x370.jpg',
    NOW()
  );
INSERT INTO CONSISTS_OF
VALUES(638343, 5006, 1.0, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(638343, 12118, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(638343, 93604, 1.0, 'sprig');
INSERT INTO CONSISTS_OF
VALUES(638343, 11165, 6.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(638343, 93663, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(638343, 10093754, 3.0, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(638343, 10093754, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(638343, 1052009, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(638343, 1002013, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(638343, 2043, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(638343, 11282, 1.0, 'large');
INSERT INTO CONSISTS_OF
VALUES(638343, 2047, 6.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(638409, 1062047, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(638409, 4053, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(638409, 1001009, 6.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(638409, 1001026, 6.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(638409, 6599, 19.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(638409, 1056, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(638409, 1009037, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(638409, 11529, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(638409, 11291, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(716407, 1001, 3.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(716407, 19911, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(716407, 1077, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(716407, 1012047, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(716407, 93824, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(633096, 10711111, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(633096, 5157, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(633096, 11677, 2.0, 'smalls');
INSERT INTO CONSISTS_OF
VALUES(633096, 11215, 4.0, 'smalls');
INSERT INTO CONSISTS_OF
VALUES(633096, 2049, 4.0, 'sprigs');
INSERT INTO CONSISTS_OF
VALUES(633096, 2036, 2.0, 'sprigs');
INSERT INTO CONSISTS_OF
VALUES(633096, 1001, 4.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(633096, 1102047, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(633096, 20035, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(633096, 2069, 0.75, 'cups');
INSERT INTO CONSISTS_OF
VALUES(633096, 19335, 3.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(633096, 11215, 2.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(633096, 2036, 1.0, 'sprig');
INSERT INTO CONSISTS_OF
VALUES(633096, 6172, 1.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(633096, 12020420, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(633096, 11485, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(633096, 10011457, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(633096, 1001, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(633096, 11215, 2.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(633096, 11457, 8.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(633096, 14106, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(633971, 18371, 5.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633971, 1001, 0.25, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(633971, 4582, 4.0, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633971, 2010, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633971, 1017, 8.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(633971, 20081, 10.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(633971, 2025, 1.0, 'dash');
INSERT INTO CONSISTS_OF
VALUES(633971, 19296, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(633971, 9152, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633971, 19911, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(633971, 1077, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(633971, 2047, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633971, 18069, 8.0, 'slices');
INSERT INTO CONSISTS_OF
VALUES(716416, 2069, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(716416, 1034053, 2.0, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(716416, 1019, 1.0, 'ounce');
INSERT INTO CONSISTS_OF
VALUES(716416, 10111529, 2.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(716416, 10011282, 0.3333333333333333, 'cups');
INSERT INTO CONSISTS_OF
VALUES(716416, 1102047, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(635552, 12061, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(635552, 9050, 500.0, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(635552, 1001, 240.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(635552, 93740, 50.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(635552, 20081, 120.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(635552, 19336, 50.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(635552, 2047, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(635552, 19335, 200.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(635552, 2050, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(635552, 10319335, 2.0, 'bags');
INSERT INTO CONSISTS_OF
VALUES(635552, 1054, 100.0, 'milliliters');
INSERT INTO CONSISTS_OF
VALUES(716405, 2069, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(716405, 1006, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(716405, 9079, 0.25, 'cups');
INSERT INTO CONSISTS_OF
VALUES(716405, 1034053, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(716405, 11215, 1.0, 'clove');
INSERT INTO CONSISTS_OF
VALUES(716405, 1002030, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(716405, 2047, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(716405, 11677, 2.0, 'larges');
INSERT INTO CONSISTS_OF
VALUES(652284, 19904, 100.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(652284, 14037, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(652284, 19336, 180.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(652284, 2047, 0.25, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(652284, 1145, 0.25, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(652513, 1001, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(652513, 18079, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(652513, 20081, 3.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(652513, 1022020, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(652513, 1022027, 2.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(652513, 1002030, 0.125, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(652513, 10011549, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(652513, 14412, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(641227, 11207, 2.0, 'handfuls');
INSERT INTO CONSISTS_OF
VALUES(641227, 2044, 2.0, 'handfuls');
INSERT INTO CONSISTS_OF
VALUES(641227, 10011457, 1.0, 'handful');
INSERT INTO CONSISTS_OF
VALUES(641227, 11215, 1.0, 'large clove');
INSERT INTO CONSISTS_OF
VALUES(641227, 1012047, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(641227, 12147, 1.0, 'handful');
INSERT INTO CONSISTS_OF
VALUES(641227, 12131, 1.0, 'handful');
INSERT INTO CONSISTS_OF
VALUES(641227, 1034053, 4.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(641227, 93690, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(662515, 20081, 3.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(662515, 18371, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(662515, 18372, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(662515, 2047, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(662515, 1230, 0.75, 'cups');
INSERT INTO CONSISTS_OF
VALUES(662515, 9206, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(662515, 2050, 2.0, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(662515, 1145, 0.5, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(662515, 19335, 2.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(662515, 9216, 0.25, 'cups');
INSERT INTO CONSISTS_OF
VALUES(662515, 19334, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(662515, 9200, 1.0, 'small');
INSERT INTO CONSISTS_OF
VALUES(633970, 1001, 110.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(633970, 19335, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(633970, 20081, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(633970, 18371, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633970, 18372, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633970, 1095, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(633970, 1012050, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(633970, 9040, 0.25, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(642648, 19165, 0.75, 'cups');
INSERT INTO CONSISTS_OF
VALUES(642648, 18371, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(642648, 18372, 2.0, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(642648, 19903, 9.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(642648, 14209, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(642648, 1017, 4.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(642648, 20081, 2.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(642648, 1053, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(642648, 1077, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(642648, 4582, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(642648, 2047, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(642648, 9316, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(642648, 19335, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(642648, 2050, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(649056, 1001, 100.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(649056, 1017, 250.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(649056, 19348, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(649056, 19177, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(649056, 1016973, 5.5, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(649056, 9152, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(649056, 19172, 1.5, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(649056, 10018173, 150.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(649056, 1077, 60.0, 'milliliters');
INSERT INTO CONSISTS_OF
VALUES(649056, 19335, 3.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(649056, 14412, 8.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(642605, 11011, 1.0, 'bunch');
INSERT INTO CONSISTS_OF
VALUES(642605, 6172, 2.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(642605, 10011268, 1.0, 'ounce');
INSERT INTO CONSISTS_OF
VALUES(642605, 10020005, 8.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(642605, 2049, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(642605, 11215, 2.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(642605, 4053, 2.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(642605, 11282, 1.0, 'medium');
INSERT INTO CONSISTS_OF
VALUES(642605, 1102047, 4.0, 'servings');
INSERT INTO CONSISTS_OF
VALUES(642605, 1012068, 3.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(644081, 19903, 8.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(644081, 1001, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(644081, 1017, 8.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(644081, 1123, 3.0, 'larges');
INSERT INTO CONSISTS_OF
VALUES(644081, 20081, 0.75, 'cups');
INSERT INTO CONSISTS_OF
VALUES(644081, 10014214, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(644081, 19335, 1.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(644081, 2050, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(641893, 10023572, 1.0, 'pound');
INSERT INTO CONSISTS_OF
VALUES(641893, 1036, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(641893, 2027, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(641893, 2044, 1.0, 'pinch');
INSERT INTO CONSISTS_OF
VALUES(641893, 1033, 1.0, 'Tb');
INSERT INTO CONSISTS_OF
VALUES(641893, 10011549, 26.0, 'ounces');
INSERT INTO CONSISTS_OF
VALUES(641893, 11549, 1.0, 'can');
INSERT INTO CONSISTS_OF
VALUES(641893, 1032009, 0.125, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(641893, 1001026, 2.0, 'cups');
INSERT INTO CONSISTS_OF
VALUES(641893, 1035, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(641893, 1033, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(641893, 1033, 1.0, 'serving');
INSERT INTO CONSISTS_OF
VALUES(641893, 18010, 2.25, 'cups');
INSERT INTO CONSISTS_OF
VALUES(641893, 1033, 0.25, 'cups');
INSERT INTO CONSISTS_OF
VALUES(641893, 1022027, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(641893, 1077, 0.6666666666666666, 'cups');
INSERT INTO CONSISTS_OF
VALUES(631762, 20081, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(631762, 1145, 6.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(631762, 14412, 1.0, 'Tbsp');
INSERT INTO CONSISTS_OF
VALUES(631762, 19335, 4.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(631762, 2050, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(631762, 9216, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(631762, 10619297, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(631762, 9316, 2.0, 'pints');
INSERT INTO CONSISTS_OF
VALUES(631762, 1001053, 1.0, 'cup');
INSERT INTO CONSISTS_OF
VALUES(632590, 10225, 3.0, 'pounds');
INSERT INTO CONSISTS_OF
VALUES(632590, 1089003, 3.0, 'larges');
INSERT INTO CONSISTS_OF
VALUES(632590, 4053, 3.0, 'Tbsps');
INSERT INTO CONSISTS_OF
VALUES(632590, 11215, 2.0, 'cloves');
INSERT INTO CONSISTS_OF
VALUES(632590, 19296, 0.5, 'cups');
INSERT INTO CONSISTS_OF
VALUES(632590, 2048, 0.25, 'cups');
INSERT INTO CONSISTS_OF
VALUES(632590, 1002030, 0.5, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(632590, 1012047, 0.25, 'teaspoons');
INSERT INTO CONSISTS_OF
VALUES(632590, 1002002, 1.0, 'teaspoon');
INSERT INTO CONSISTS_OF
VALUES(632590, 2025, 0.5, 'teaspoons');
INSERT INTO RATING
VALUES(638343, 3, 2);
INSERT INTO RATING
VALUES(638409, 3, 5);
INSERT INTO RATING
VALUES(716407, 8, 4);
INSERT INTO RATING
VALUES(633096, 8, 1);
INSERT INTO RATING
VALUES(633971, 4, 2);
INSERT INTO RATING
VALUES(716416, 6, 4);
INSERT INTO RATING
VALUES(635552, 4, 5);
INSERT INTO RATING
VALUES(716405, 10, 4);
INSERT INTO RATING
VALUES(652284, 9, 4);
INSERT INTO RATING
VALUES(652513, 9, 3);
INSERT INTO RATING
VALUES(641227, 7, 3);
INSERT INTO RATING
VALUES(662515, 4, 2);
INSERT INTO RATING
VALUES(633970, 8, 3);
INSERT INTO RATING
VALUES(642648, 7, 3);
INSERT INTO RATING
VALUES(649056, 2, 0);
INSERT INTO RATING
VALUES(642605, 10, 5);
INSERT INTO RATING
VALUES(644081, 10, 5);
INSERT INTO RATING
VALUES(641893, 1, 0);
INSERT INTO RATING
VALUES(631762, 2, 3);
INSERT INTO RATING
VALUES(632590, 3, 2);
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
FROM USERS U
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
SELECT USERS.firstname,
  USERS.lastname,
  C.Rating_Count
FROM USERS,
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
WHERE USERS.user_id = C.user_id;
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
FROM USERS,
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
SELECT USERS.firstname,
  USERS.lastname,
  R.recipe_title,
  ING.ing_name
FROM USERS,
  RECIPE R,
  CONSISTS_OF,
  INGREDIENT ING
WHERE R.recipe_id = CONSISTS_OF.recipe_id
  AND CONSISTS_OF.ingredient_id = ING.ingredient_id
  AND USERS.user_id = R.created_user_id;