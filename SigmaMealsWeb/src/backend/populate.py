import json
import os.path as path
from random import randint

meals = {1: 'breakfast',
         2: 'lunch',
         3: 'dinner',
         4: 'dessert',
         5: 'appetizer',
         6: 'main Course',
         7: 'main Dish',
         8: 'morning Meal',
         9: 'brunch',
         10: 'drink'}


ingredients = {}
ingredients_measure = {}
recipeids = []


def read_json_file():
    data = {}

    with open(path.abspath("recipesAccurateIng.json"), 'r') as f:
        data = json.load(f)
        return data
    return []


def get_ingredients():
    data = read_json_file()
    for dic in data:
        list = dic.get('extendedIngredients')
        for ing in list:
            measure = ing.get('measures').get('us').get('unitLong')
            if ing.get('id') not in ingredients:
                ingredients[ing.get('id')] = ing.get('nameClean')
            if measure is not None:
                if ingredients_measure.get(ing.get('id')) is None:
                    ingredients_measure[ing.get('id')] = str(ing.get(
                        'amount')) + ", " + measure
    # insert to sql
    # print(ingredients_measure)
    # print(ingredients)
    # print('here ', len(ingredients_measure), len(ingredients))


def recipe_ingre():
    recipe_info = []
    ingredient_info = {}
    data = read_json_file()
    for dic in data:
        list = dic.get('extendedIngredients')
        # recipe id
        id = dic.get('id')
        # list to hold each ingredient id and amount
        ing_list = []
        for ing in list:
            ing_amount = {ing.get('id'): ing.get('amount')}
            ing_info = "{}, {}, \'{}\'".format(ing.get('id'), ing.get(
                'amount'), ing.get('measures').get('us').get('unitLong'))
            # ing_list.append(ing_amount)
            ing_list.append(ing_info)
            if ing.get('id') not in ingredient_info:
                ingredient_info[ing.get('id')] = ing.get('nameClean')
            #print("id ",ing.get('id'), " name ",ing.get('nameClean'), " amount ", ing.get('amount')," units ",ing.get('unit'))
        # insert info into recipe table
        recipe_info.append({id: ing_list})

    # print(recipe_info)
    for rep in recipe_info:
        for repid in rep:
            # print(rep.get(x))
            for ing in rep.get(repid):
                print("INSERT INTO CONSISTS_OF VALUES({},{});".format(repid, ing))


users = [0,
         320,
         321,
         322,
         323,
         324,
         325,
         326,
         327,
         328,
         329,
         ]


def getRecipe():
    data = read_json_file()
    for dic in data:
        # recipe id
        id = dic.get('id')
        recipeids.append(id)
        title = dic.get('title')
        prep_time = dic.get('readyInMinutes')
        descrip = dic.get('summary')
        price = float(dic.get('pricePerServing')) / 100
        imageUrl = dic.get('image')
        steps = dic.get('analyzedInstructions')
        instruction = ""
        # get recipe steps
        for st in steps:
            for s in st.get('steps'):
                instruction = instruction + "step " + str(s.get('number'))
                instruction = instruction + ' : '
                instruction = instruction + s.get('step')
                instruction = instruction + '\n'
        meal_type = dic.get('dishTypes')
        meal_id = 0
        for meal in meal_type:
            flag = True
            for key in meals:
                if meals.get(key) == meal:
                    meal_id = key
                    flag = False
                    break
            if flag == False:
                break
        # insert recipe into sql table
        print("INSERT INTO RECIPE VALUES({},\'{}\',{},{:.2f},{},{},\'{}\',\'{}\',\'{}\',{});\n".format(
            id, title, meal_id, price, prep_time,
            users[randint(0, len(users)-1)], descrip, instruction, imageUrl, "GetDate()"))


def getIngredientInserts():
    for x in ingredients:
        print("INSERT INTO INGREDIENT VALUES({}, \'{}\');".format(
            x, ingredients.get(x)))


def getConsistsOfInserts():
    for x in recipeids:
        print("INSERT INTO CONSISTS_OF VALUES({},{},{},\'{}\');".format(
            x,
        ))


if __name__ == '__main__':
    get_ingredients()
    getIngredientInserts()
    print()
    getRecipe()
    print()
    # print(ingredients_measure)
    recipe_ingre()
