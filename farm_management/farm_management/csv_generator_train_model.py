import csv
import random

# Expanded farm-related items (100+)
items = [
    "mango saplings", "coconut trees", "rice seeds", "wheat seeds", "goat", "cow", 
    "poultry feed", "duck feed", "fertilizer", "tractor repair", "irrigation pipe",
    "pesticide", "organic compost", "jamun saplings", "banana plants", "onion seeds",
    "tomato plants", "greenhouse setup", "solar water pump", "harvesting machine",
    "plough repair", "corn seeds", "maize", "sugarcane", "cotton bales", "milking machine",
    "hay bales", "fish fingerlings", "sheep", "buffalo", "turmeric", "ginger", "garlic bulbs",
    "carrot seeds", "cabbage plants", "chili plants", "eggplant saplings", "beehives",
    "honey extractor", "olive saplings", "almond trees", "apples", "milk", "ghee",
    "butter", "cheese", "yogurt", "palm oil", "tea leaves", "coffee beans", "pepper",
    "cocoa pods", "soybean seeds", "sunflower seeds", "pumpkin seeds", "watermelon plants",
    "grapes", "oranges", "lemons", "guava", "papaya", "jackfruit", "custard apple",
    "mulberry", "dates", "figs", "avocados", "lychee", "dragon fruit", "strawberry plants",
    "blueberry plants", "raspberry plants", "blackberry plants", "nursery plants", "rose plants",
    "lily bulbs", "marigold flowers", "jasmine plants", "lavender plants", "tulip bulbs",
    "bonsai trees", "seedling trays", "drip irrigation kit", "sprinkler system", "weed killer",
    "herbicide", "fungicide", "soil test kit", "farm fencing", "cattle shed", "goat pen",
    "poultry cage", "water trough", "grain storage bags", "silo repair", "harrow",
    "rotavator", "seed drill", "sheep", "buffalo", "pigs", "chickens", "turkeys", "ducks", 
    "goats", "horses","donkeys", "bees", "fish feed", "aquaculture supplies", "fishing nets",
    "mango tree", "coconut tree", "banana tree", "papaya tree", "guava tree", "jackfruit tree",
    "drip irrigation system", "solar panels", "wind turbines", "solar", "biogas plant", "Apple",
    "Banana",
    "Mango",
    "Orange",
    "Papaya",
    "Watermelon",
    "Pineapple",
    "Guava",
    "Grapes",
    "Pomegranate",
    "Jackfruit",
    "Lychee",
    "Strawberry",
    "Kiwi",
    "Sapota (Chikoo)",
    "Custard Apple",
    "Pear",
    "Blueberry",
    "Plum",
    "Peach", "Apricot", "Coconut", "Tamarind", "Fig", "Mulberry", "Date Palm",
     "Potato", "Beet root", "Sweet Potato", "Turnip", "Radish",
    "Tomato",
    "Onion",
    "Carrot",
    "Cabbage",
    "Cauliflower",
    "Brinjal",
    "Spinach",
    "Capsicum",
    "Pumpkin",
    "Cucumber",
    "Radish",
    "Beetroot",
    "Drumstick",
    "Lady Finger",
    "Ridge Gourd",
    "Bitter Gourd",
    "Bottle Gourd",
    "Snake Gourd",
    "Green Beans",
    "Peas",
    "Sweet Corn", 
]

# Random amounts
amounts = [str(random.randint(100, 50000)) for _ in range(2000)]

# Currency variations
currencies = ["rupees", "Rs.", "₹", "INR"]

# Expanded sentence templates
templates = [
    # Purchases
    "I invested {amount} {currency} for buying {item}.",
    "Spent {amount} {currency} on purchasing {item} for my farm.",
    "Bought {item} today and paid {amount} {currency}.",
    "Paid {amount} {currency} to buy {item}.",
    "Purchased {item} at {amount} {currency}.",
    "I gave {amount} {currency} as investment for {item}.",
    "Used {amount} {currency} to buy {item}.",
    "Amount paid for {item} was {amount} {currency}.",
    "Acquired {item} by paying {amount} {currency}.",
    "Cost of {item} amounted to {amount} {currency}.",
    "I spent {amount} {currency} on {item} last month.",
    "Around noon, I spent {amount} {currency} on {item}.",
    "This season, I paid {amount} {currency} for {item}.",
    "Farmer purchased {item} for {amount} {currency}.",
    "The market price of {item} was {amount} {currency}.",
    "The expense for {item} was {amount} {currency}.",
    "Rs. {amount} was spent on {item}.",
    "₹{amount} was given to buy {item}.",
    "{item} purchase came to {amount} {currency}.",
    "I had to pay {amount} {currency} for {item}.",
    "We bought {item} for {amount} {currency} at the weekly market.",
    "Advance of {amount} {currency} paid for {item}.",
    "Paid full amount {amount} {currency} for {item} delivery.",
    "Settled {amount} {currency} for {item} purchase.",

    # Sales
    "Harvested {item} and sold for {amount} {currency}.",
    "Sold {item} in the market and earned {amount} {currency}.",
    "Harvest of {item} brought in {amount} {currency}.",
    "Received {amount} {currency} from selling {item}.",
    "Farmer earned {amount} {currency} from {item} sales.",
    "{item} was sold for {amount} {currency} yesterday.",
    "{item} fetched {amount} {currency} at the auction.",
    "We sold {item} for {amount} {currency} today.",
    "{item} is sold for {amount} {currency} today.",
    "Market sale of {item} gave {amount} {currency}.",
    "Got {amount} {currency} for {item} this morning.",
    "Sale price of {item} was {amount} {currency}.",
    "{item} was given for {amount} {currency} per kilo.",
    "Total earnings from {item} were {amount} {currency}.",
    
    # Passive phrasing
    "Today, {item} is sold for {amount} {currency}.",
    "In the local market, {item} is priced at {amount} {currency}.",
    "The cost of {item} is {amount} {currency}.",
    "{item} price today is {amount} {currency}.",
    "{item} is fetching {amount} {currency} this season.",
    "{item} is worth {amount} {currency} now.",
    "{item} goes for {amount} {currency} these days.",
    "Current rate of {item} is {amount} {currency}.",
    "Today’s market rate for {item} is {amount} {currency}.",
    
    # Indirect phrasing
    "Payment of {amount} {currency} was made for {item}.",
    "The bill for {item} came to {amount} {currency}.",
    "The invoice for {item} shows {amount} {currency}.",
    "We spent {amount} {currency} on {item} repair.",
    "{item} purchase cost us {amount} {currency}.",
    "They charged {amount} {currency} for {item}.",
    "For {item}, the price was {amount} {currency}.",
    "Amount due for {item} is {amount} {currency}.",
    "{item} is billed at {amount} {currency}.",
    "Quoted price for {item} is {amount} {currency}."
]


# Optional prefixes
optional_phrases = [
    "", "Today, ", "Yesterday, ", "Last month, ", "On Monday, ", "Early morning, ",
    "In the evening, ", "During the season, ", "Recently, ", "Just now, ",
    "Earlier today, ", "In March, ", "A week ago, "
]

def create_row():
    item = random.choice(items)
    amount = random.choice(amounts)
    currency = random.choice(currencies)
    template = random.choice(templates)
    optional_phrase = random.choice(optional_phrases)

    sentence = optional_phrase + template.format(item=item, amount=amount, currency=currency)

    # Entity offsets
    item_start = sentence.index(item)
    item_end = item_start + len(item)
    amount_start = sentence.index(amount)
    amount_end = amount_start + len(amount)

    return [sentence, item_start, item_end, amount_start, amount_end]

with open("training_data.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    writer.writerow(["sentence", "item_start", "item_end", "amount_start", "amount_end"])
    for _ in range(20000):  # More examples for better generalization
        writer.writerow(create_row())

print("Generated training_data.csv with 20,000 varied entries.")
