/*

Refresh all existing data for Brian's Food Truck (RestaurantId = 101)

*/
USE Restaurant
GO

DECLARE @restaurantId INT = 101	
DECLARE @restaurantCode VARCHAR(50) = 'FoodTruck'

EXEC DeleteRestaurantData @restaurantId
	
IF NOT EXISTS (SELECT 1 FROM [dbo].[Restaurant] WHERE RestaurantId=@restaurantId)
BEGIN
	INSERT INTO [dbo].[Restaurant] (RestaurantId) VALUES (@restaurantId)
END

UPDATE [dbo].[Restaurant] SET
	 NameEn						= 'Brian''s Food Truck'						
	,[Location]					= 'Winnetka'					
	,[Code]						=  @restaurantCode
    ,[Address1]					= '19725 Stagg St'				
    ,[Address2]					= ''					
    ,[City]						= 'Winnetka'						
    ,[State]					= 'CA'							
    ,[Zip]						= '91335'							
    ,[Phone]					= '818-701-1234'
	-- [Hours]					= '9:00am - 9:45pm, Monday - Sunday'
    ,[TaxPercent]				= 8.35						
    ,[GroupPeople]				= 100						
    ,[GroupChargePercent]		= 15					
    ,[RecommendedTipPercent]	= 15				
    ,[CreditCardSurcharge]		= 10				
    ,[SlowOrderWarningMinutes]  = 10		
	,[RefreshIntervalSeconds]	= 20
	,[Language] = 'en'		
WHERE RestaurantId = @restaurantId				

-- User
INSERT INTO [User]
	(UserId, RestaurantId, DefaultLanguage, [Login], NameEn) 
	VALUES
	 (NEWID(), @restaurantId, 'en',	'Demo'				,  'Demo Account, all roles')
	,(NEWID(), @restaurantId, 'en',	'Waiter'			,  'Can take order')
	,(NEWID(), @restaurantId, 'en',	'Preparer'			,  'Prepare Food and Beverage')
	,(NEWID(), @restaurantId, 'en',	'Deliverer'			,  'Servicer, carry food/beverage to customer')
	,(NEWID(), @restaurantId, 'en',	'Cashier'			,  'Cashier')
	,(NEWID(), @restaurantId, 'en',	'Manager'			,  'Restaurant Manager')
	,(NEWID(), @restaurantId, 'en',	'Owner'				,  'Restaurant Owner')
	,(NEWID(), @restaurantId, 'en',	'Admin'				,  'Restaurant Admin')	
update [User] set [Password]  = lower([Login]) + 'temp' where RestaurantId = @restaurantId
update [User] set [Login]  = [Login] + '@' + @restaurantCode where RestaurantId = @restaurantId
DELETE [AspNetUsers] where UserName in (select Login from dbo.[User] where RestaurantId=@restaurantId)
	
-- Table 
-- use as food truck location/hours
INSERT INTO [Table] 
	(TableId, RestaurantId, IsForCustomer, PriceId, NameEn, DescriptionEn) 
	VALUES
	 (NEWID(), @restaurantId, 1, ''				, 'Brickyard Pub', 'North Hollywood')	
	,(NEWID(), @restaurantId, 1, ''				, 'Angel City Brewery', '')	
	,(NEWID(), @restaurantId, 1, 'Delux'			, 'October Event', 'Sample Delux Event Hollowood')	
	,(NEWID(), @restaurantId, 1, 'Business-Class'	, 'November Event', 'Sample Bussiness-class Event City Walk')	
	,(NEWID(), @restaurantId, 1, 'First-Class'		, 'Other Event', 'Sample First-class Event Moholland Drive')	

	

-- Category  (as in menu)
INSERT INTO Category
	(CategoryId, RestaurantId, [Sequence], Code, NameEn, NameVi) 
	VALUES
	 (newid(), @restaurantId, 1,	'BEV',		'Beverages',		N'Beverages')			
	,(newid(), @restaurantId, 2,	'TACO',		'Taco',				N'Taco')				
	,(newid(), @restaurantId, 3,	'QUESA',	'Quesadilla',		N'Quesadilla')			
	,(newid(), @restaurantId, 4,	'BURRITO',	'Burritos',			N'Burritos')			
	,(newid(), @restaurantId, 5,	'RBOWL',	'Rice Bowl',		N'Rice Bowl')			
	,(newid(), @restaurantId, 6,	'BURGER',	'Burger',			N'Burger')				
	,(newid(), @restaurantId, 7,	'DUMPLING',	'Dumplings',		N'Dumplings')			
	,(newid(), @restaurantId, 8,	'GCHEESE',	'Grilled Cheese',	N'Grilled Cheese')		
	,(newid(), @restaurantId, 9,	'SALAD',	'Salad',			N'Salad')				
	,(newid(), @restaurantId, 10,	'SIDE',		'SideOrder',		N'SideOrder')			

INSERT INTO Product 
	(ProductId, RestaurantId, IsAddonRequired, CategoryCode, Code, PrepareMinutes, Price, NameEn, NameVi) 
	VALUES
	 (newid(), @restaurantId, 0, 'BEV',			'11',	5,  2.00, 'Coke',					'')
	,(newid(), @restaurantId, 0, 'BEV',			'12',	5,  2.00, 'Diet Coke',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'13',	5,  2.00, 'Ginger Ale',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'14',	5,  2.00, 'Cactus Cooler',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'15',	5,  2.00, 'Gatorade',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'16',	5,  2.95, 'Bottled Water',			'')
	,(newid(), @restaurantId, 1, 'TACO',		'31',	5,  2.00, 'Taco, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'TACO',		'32',	5,  2.00, 'Taco, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'TACO',		'33',	5,  2.00, 'Taco, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'TACO',		'34',	5,  2.00, 'Taco, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'QUESA',		'41',	5,  6.00, 'Quesadia, Plain',			'')
	,(newid(), @restaurantId, 1, 'QUESA',		'43',	5,  9.00, 'Quesadia, Kimchi',			'')
	,(newid(), @restaurantId, 1, 'QUESA',		'44',	5, 11.00, 'Quesadia, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'QUESA',		'45',	5, 11.00, 'Quesadia, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'QUESA',		'46',	5, 11.00, 'Quesadia, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'QUESA',		'47',	5, 11.00, 'Quesadia, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'BURRITO',		'51',	5,  9.00, 'Burrito, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'BURRITO',		'52',	5,  9.00, 'Burrito, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'BURRITO',		'53',	5,  9.00, 'Burrito, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'BURRITO',		'54',	5,  9.00, 'Burrito, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'RBOWL',		'51',	5, 11.00, 'Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'RBOWL',		'52',	5, 11.00, 'Rice Bowl, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'RBOWL',		'53',	5, 11.00, 'Rice Bowl, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'RBOWL',		'54',	5, 11.00, 'Rice Bowl, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'BURGER',		'61',	5,  8.95, 'Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'BURGER',		'62',	5,  8.95, 'Burger, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'BURGER',		'63',	5,  8.95, 'Burger, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'BURGER',		'64',	5,  8.95, 'Burger, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'BURGER',		'65',	5,  8.95, 'Burger, Kimchi"',	'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'71',	5, 12.00, 'Dumpling, No meat',			'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'72',	5, 12.00, 'Dumpling, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'73',	5, 12.00, 'Dumpling, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'74',	5, 12.00, 'Dumpling, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'75',	5, 12.00, 'Dumpling, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'81',	5,  8.95, 'Grilled Cheese, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'82',	5,  8.95, 'Grilled Cheese, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'83',	5,  8.95, 'Grilled Cheese, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'84',	5,  8.95, 'Grilled Cheese, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'SALAD',		'91',	5,  8.00, 'Salad, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'SALAD',		'92',	5,  8.00, 'Salad, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'SALAD',		'93',	5,  8.00, 'Salad, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'SALAD',		'94',	5,  8.00, 'Salad, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X1',	5,  3.00, 'Side Order, Rice',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X2',	5,  3.00, 'Side Order, Kimchi',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X3',	5,  3.00, 'Side Order, Beans',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X4',	5,  3.00, 'Side Order, Potato Salad',	'')
												 
update t set t.CategoryId = c.CategoryId		 
from Product t									 
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

-- Addon
INSERT INTO Addon 
	(AddonId, RestaurantId, CategoryCode, PrepareMinutes, IsModifer, Price, NameEn, NameVi) 
	VALUES
	 (newid(), @restaurantId, 'BEV'		, 5, 1, 0, 'Cup of ice',	'')
	,(newid(), @restaurantId, 'BEV'		, 5, 1, 0, 'Extra cup',	'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Mild',				'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Spicy',				'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'No avacado',		'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Extra onion',		'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Extra avacado',		'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Mild',				'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Spicy',				'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'No avacado',		'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Extra onion',		'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Extra avacado',		'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Mild',				'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Spicy',				'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'No avacado',		'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Extra onion',		'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Extra avacado',		'')

update t set t.CategoryId = c.CategoryId
from Addon t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

-- create 2 more new price lists
EXEC	[dbo].[CreateNewPrice]
		@priceId = N'Delux',
		@restaurantId = @restaurantId,
		@productIncrement = 1,
		@addonIncrement = 0.5
EXEC	[dbo].[CreateNewPrice]
		@priceId = N'Business-Class',
		@restaurantId = @restaurantId,
		@productIncrement = 2,
		@addonIncrement = 1
EXEC	[dbo].[CreateNewPrice]
		@priceId = N'First-Class',
		@restaurantId = @restaurantId,
		@productIncrement = 3,
		@addonIncrement = 1.5
		
UPDATE [User]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Table]		SET IsActive = 1 WHERE IsActive IS NULL		
UPDATE [Product]	SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Addon]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Category]	SET IsActive = 1 WHERE IsActive IS NULL