DECLARE @restaurantId INT = 103	
DECLARE @restaurantCode VARCHAR(50) = 'Streets'

EXEC DeleteRestaurantData @restaurantId
	
IF NOT EXISTS (SELECT 1 FROM [dbo].[Restaurant] WHERE RestaurantId=@restaurantId)
BEGIN
	INSERT INTO [dbo].[Restaurant] (RestaurantId) VALUES (@restaurantId)
END
UPDATE [dbo].[Restaurant] SET
	 NameEn						= 'The Streets by Bistro Orient'						
	,[Location]					= 'Thousand Oaks'					
	,[Code]						= @restaurantCode
    ,[Address1]					= '74 North Skyline Dr'				
    ,[Address2]					= ''					
    ,[City]						= 'Thousand Oaks'						
    ,[State]					= 'CA'							
    ,[Zip]						= '91362'							
    ,[Phone]					= '805 946-0800'
	-- [Hours]					= 'Lunch: 11:00-2:45 Monday-Friday, Dinner: 4:00-9:00 Monday-Thursday, 4:-00:930 Friday&Saturday, Closed Sundays'
    ,[TaxPercent]				= 8.35						
    ,[GroupPeople]				= 6						
    ,[GroupChargePercent]		= 18					
    ,[RecommendedTipPercent]	= 15				
    ,[CreditCardSurcharge]		= 0				
    ,[SlowOrderWarningMinutes]  = 15
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
DELETE AspNetUsers where UserName in (select Login from dbo.[User] where RestaurantId=@restaurantId)

-- Table 
-- location X (grid of 12)
INSERT INTO [Table] 
	 (TableId, RestaurantId, IsForCustomer, Seats, LocationY, LocationX, NameEn, NameVi) VALUES
	 (newid(), @restaurantId, 1, 4,  2, 1, 'Table 01',	N'Bàn Số 01')
	,(newid(), @restaurantId, 1, 4,  2, 2, 'Table 02',	N'Bàn Số 02')
	,(newid(), @restaurantId, 1, 8,  2, 3, 'Table 03',	N'Bàn Số 03')
	,(newid(), @restaurantId, 1, 8,  3, 1, 'Table 04',	N'Bàn Số 04')
	,(newid(), @restaurantId, 1, 4,  3, 2, 'Table 05',	N'Bàn Số 05')
	,(newid(), @restaurantId, 1, 4,  3, 3, 'Table 06',	N'Bàn Số 06')
	,(newid(), @restaurantId, 1, 6,  3, 1, 'Table 07',	N'Bàn Số 07')
	,(newid(), @restaurantId, 1, 6,  4, 2, 'Table 08',	N'Bàn Số 08')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'Table 09',	N'Bàn Số 09')
	,(newid(), @restaurantId, 0, 0,  1, 1, 'Entrance',	N'Cửa ra vào')
	,(newid(), @restaurantId, 0, 0,  4, 1, 'Cashier',	N'Quầy tính tiền')
	,(newid(), @restaurantId, 0, 0,  4, 3, 'Kitchen',	N'Nhà bếp')


-- Category  (as in menu)
INSERT INTO Category
	 (CategoryId, RestaurantId, [Sequence], Code, NameEn, NameVi) 
	 VALUES																		
	 (newid(), @restaurantId, 1,  'BEV'			, 'Beverages',						N'')
	,(newid(), @restaurantId, 2,  'STARTER'		, 'Starters',						N'')
	,(newid(), @restaurantId, 3,  'SOUP'		, 'Soups',							N'')
	,(newid(), @restaurantId, 4,  'SALAD'		, 'Salad',							N'')
	,(newid(), @restaurantId, 5,  'FDICE'		, 'Fried Rice',						N'')
	,(newid(), @restaurantId, 6,  'ENTREE'		, 'Entrees',						N'')
	,(newid(), @restaurantId, 7,  'LUNCHSP'		, 'Lunch Specials',					N'')
	,(newid(), @restaurantId, 8,  'SPPADTHAI'	, 'Streets Specials Pad Thai',		N'')
	,(newid(), @restaurantId, 9,  'SPTHAIYAKI'	, 'Streets Specials Thai Yakisoba',	N'')
	,(newid(), @restaurantId, 10, 'SPYCURRY'	, 'Streets Specials Yellow Curry',	N'')
	,(newid(), @restaurantId, 11, 'SPRCURRY'	, 'Streets Specials Red Curry',		N'')
	,(newid(), @restaurantId, 12, 'SIDE'		, 'Sides',							N'')
	
INSERT INTO Product 
	 (ProductId, RestaurantId, IsAddonRequired, CategoryCode, [Sequence], PrepareMinutes, Price, Code, NameEn) 
	 VALUES
	 (newid(), @restaurantId, 0, 'BEV'			, 10		, 5	,   0	, 'B01'	,'Ice Water')
	,(newid(), @restaurantId, 1, 'BEV'			, 11		, 5	, 	2	, 'B02'	,'Coke')
	,(newid(), @restaurantId, 1, 'BEV'			, 12		, 5	, 	2	, 'B03'	,'Diet Coke')
	,(newid(), @restaurantId, 1, 'BEV'			, 13		, 5	, 	2	, 'B04'	,'Sprite')
	,(newid(), @restaurantId, 1, 'BEV'			, 14		, 5	, 	2	, 'B05'	,'Hot Tea')
	,(newid(), @restaurantId, 1, 'BEV'			, 15		, 5	, 	2	, 'B06'	,'Ice Tea')
	,(newid(), @restaurantId, 1, 'BEV'			, 16		, 5	, 	2	, 'B07'	,'Hot Coffee')

	,(newid(), @restaurantId, 1, 'STARTER'		, 30, 10	, 	4.5 , 'A00'	,'Fresh Spring Rolls (cut 4pc) - Pork Belly')
	,(newid(), @restaurantId, 1, 'STARTER'		, 31, 10	, 	4.5 , 'A01'	,'Fresh Spring Rolls (cut 4pc) - Steamed Shrimp')
	,(newid(), @restaurantId, 1, 'STARTER'		, 32, 10	, 	4.5 , 'A02'	,'Fresh Spring Rolls (cut 4pc) - Sugarcane Shrimp')
	,(newid(), @restaurantId, 1, 'STARTER'		, 33, 10	, 	4.0 , 'A03'	,'Fresh Spring Rolls (cut 4pc) - Tofu')
	,(newid(), @restaurantId, 0, 'STARTER'		, 34, 10	,	8.0	, 'A04'	,'Vegetarian Fried Imperial Egg Rolls (4 rolls)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 35, 10	,	8.0	, 'A05'	,'Chichen & Schrimp Fried Imperial Egg Rolls (4 rolls)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 36, 10	,	7.0	, 'A06'	,'Sriracha Hoeny Hosin Pork Belly w/ Steam Buns (2)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 37, 10	,	6.5	, 'A07'	,'Pan Fried Shrimp & Spinach Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 38, 10	,	5.5	, 'A08'	,'Pan Fried Chicken & Shiitake Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 39, 10	,	5.5	, 'A09'	,'Pan Fried Vegetarian Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 40, 10	,	4.5	, 'A10'	,'Steam Siu Mai Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 41, 10	,	8.0	, 'A11'	,'Sriracha Honey Hoisin Sea Bass w/ Steam Buns (2)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 42, 10	,	8.0	, 'A12'	,'Baked Green Mussels (6 pc)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 43, 10	,	10	, 'A13'	,'Casian (Cajun + Asian) Crispy Calamari')
	,(newid(), @restaurantId, 0, 'STARTER'		, 44, 10	,	6.5 , 'A14'	,'Casian (Cajun + Asian) Hot Wings (5 pc)')
	,(newid(), @restaurantId, 0, 'STARTER'		, 45, 10	,	6.5	, 'A15'	,'Siracha Honey Hoisin Hot Wings (5 pc)')
	
	,(newid(), @restaurantId, 0, 'SOUP'			, 60, 10	,	8.5	, 'SOP-T'	,'Pho - Tofu')
	,(newid(), @restaurantId, 0, 'SOUP'			, 61, 10	,	8.5	, 'SOP-RS'	,'Pho - Rare Steak')
	,(newid(), @restaurantId, 0, 'SOUP'			, 62, 10	,	8.5	, 'SOP-BR'	,'Pho - Brisket')
	,(newid(), @restaurantId, 0, 'SOUP'			, 63, 10	,	8.5	, 'SOP-TD'	,'Pho - Tendon')
	,(newid(), @restaurantId, 0, 'SOUP'			, 64, 10	,	8.5	, 'SOP-TP'	,'Pho - Tripe')
	,(newid(), @restaurantId, 0, 'SOUP'			, 65, 10	,	8.5	, 'SOP-MB'	,'Pho - Meatball')
	,(newid(), @restaurantId, 0, 'SOUP'			, 66, 10	,	8.5	, 'SOP-CH'	,'Pho - Chicken')
	,(newid(), @restaurantId, 1, 'SOUP'			, 67, 10	,	11	, 'SON-P'	,'Soba Noodle Soup - Pork Belly & Pickled Veggies')
	,(newid(), @restaurantId, 1, 'SOUP'			, 68, 10	,	10	, 'SON-T'	,'Soba Noodle Soup - Tofu, Shiitake, Bok Choy & Asparagus')
	,(newid(), @restaurantId, 1, 'SOUP'			, 69, 10	,	11	, 'SON-F'	,'Soba Noodle Soup - Garlic Sea Bass')
	,(newid(), @restaurantId, 1, 'SOUP'			, 70, 10	,	11	, 'SON-S'	,'Soba Noodle Soup - Shrimp & Snowpeas')
	,(newid(), @restaurantId, 0, 'SOUP'			, 71, 10	,	5	, 'SOW-C'	,'Streets Wonton Soup - Cup')
	,(newid(), @restaurantId, 0, 'SOUP'			, 72, 10	,	9	, 'SOW-B'	,'Streets Wonton Soup - Bowl')
	,(newid(), @restaurantId, 0, 'SOUP'			, 73, 10	,	13	, 'SOB-F'	,'Streets Bouilabaisse - Sea Bass')
	,(newid(), @restaurantId, 0, 'SOUP'			, 74, 10	,	14	, 'SOB-S'	,'Streets Bouilabaisse - Jumbo Shrimp (6)')
	,(newid(), @restaurantId, 0, 'SOUP'			, 75, 10	,	20	, 'SOB-KS'	,'Streets Bouilabaisse - Kitchen Sink')
	
	,(newid(), @restaurantId, 0, 'SALAD'		, 80, 10	,	8.5	, 'SLB-GP'	,'Bun - Grilled Pork')
	,(newid(), @restaurantId, 0, 'SALAD'		, 81, 10	,	8.5	, 'SLB-CH'	,'Bun - Grilled Chicken')
	,(newid(), @restaurantId, 0, 'SALAD'		, 82, 10	,	8.5	, 'SLB-TF'	,'Bun - Grilled Tofu')
	,(newid(), @restaurantId, 0, 'SALAD'		, 83, 10	,	11	, 'SLB-FM'	,'Bun - Filet Mignon')
	,(newid(), @restaurantId, 0, 'SALAD'		, 84, 10	,	11	, 'SLB-SH'	,'Bun - Jumbo Shrimp (7)')
	,(newid(), @restaurantId, 0, 'SALAD'		, 85, 10	,	11	, 'SLB-SB'	,'Bun - Sea Bass')
	,(newid(), @restaurantId, 0, 'SALAD'		, 86, 10	,	5	, 'SLS-PS'	,'Papaya Salad, Plain, Small')
	,(newid(), @restaurantId, 0, 'SALAD'		, 87, 10	,	9	, 'SLS-PL'	,'Papaya Salad, Plain, Large')
	,(newid(), @restaurantId, 0, 'SALAD'		, 88, 10	,	6	, 'SLS-TS'	,'Papaya Salad, Sliced Tofu, Small')
	,(newid(), @restaurantId, 0, 'SALAD'		, 89, 10	,	11	, 'SLS-TL'	,'Papaya Salad, Sliced Tofu, Large')
	,(newid(), @restaurantId, 0, 'SALAD'		, 90, 10	,	6	, 'SLS-CS'	,'Papaya Salad, Shredded Chicken, Small')
	,(newid(), @restaurantId, 0, 'SALAD'		, 91, 10	,	11	, 'SLS-CL'	,'Papaya Salad, Shredded Chicken, Large')
	,(newid(), @restaurantId, 0, 'SALAD'		, 92, 10	,	7	, 'SLS-SS'	,'Papaya Salad, Steamed Shrimp, Small')
	,(newid(), @restaurantId, 0, 'SALAD'		, 93, 10	,	13	, 'SLS-SL'	,'Papaya Salad, Steamed Shrimp, Large')
	,(newid(), @restaurantId, 0, 'SALAD'		, 94, 10	,	15	, 'SLS-JS'	,'Papaya Salad, Grilled Jumbo Shrimp, Large')
	,(newid(), @restaurantId, 0, 'SALAD'		, 95, 10	,	12	, 'SLS-C'	,'Streets Salad - Chicken')
	,(newid(), @restaurantId, 0, 'SALAD'		, 96, 10	,	12	, 'SLS-T'	,'Streets Salad - Tofu')
	,(newid(), @restaurantId, 0, 'SALAD'		, 97, 10	,	14	, 'SLS-F'	,'Streets Salad - Sea Bass')
	,(newid(), @restaurantId, 0, 'SALAD'		, 98, 10	,	14	, 'SLS-B'	,'Streets Salad - Filet Mignon')
	,(newid(), @restaurantId, 0, 'SALAD'		, 99, 10	,	14	, 'SLS-S'	,'Streets Salad - Jumbo Shrimp (7)')
	
	,(newid(), @restaurantId, 0, 'FDICE'		, 100, 10	,	9	, 'FR-C'	,'Traditional Fried Rice - Chicken')
	,(newid(), @restaurantId, 0, 'FDICE'		, 101, 10	,	9	, 'FR-T'	,'Traditional Fried Rice - Tofu')
	,(newid(), @restaurantId, 0, 'FDICE'		, 102, 10	,	9	, 'FR-V'	,'Traditional Fried Rice - Vegies')
	,(newid(), @restaurantId, 0, 'FDICE'		, 103, 10	,	12	, 'FR-F'	,'Traditional Fried Rice - Sea Bass')
	,(newid(), @restaurantId, 0, 'FDICE'		, 104, 10	,	12	, 'FR-S'	,'Traditional Fried Rice - Shrimp')
	,(newid(), @restaurantId, 0, 'FDICE'		, 105, 10	,	12	, 'FR-CS'	,'Hawaiian Fried Rice - Chicken & Shrimp')
	,(newid(), @restaurantId, 0, 'FDICE'		, 106, 10	,	13	, 'FR-CM'	,'Crab Meat Fried Rice')
	,(newid(), @restaurantId, 0, 'FDICE'		, 107, 10	,	14	, 'FR-SF'	,'Seafood Fried Rice')

	,(newid(), @restaurantId, 0, 'ENTREE'		, 110	, 10	,	17	, 'E01-L'	, 'Grilled Lemongrass Lamb Chops - Large ( pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 111	, 10	,	10	, 'E01-S'	, 'Grilled Lemongrass Lamb Chops - Small (2 pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 112	, 10	,	9	, 'E02-S'	, 'Casian Baby Back Ribs - Small (4 pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 113	, 10	,	15	, 'E02-L'	, 'Casian Baby Back Ribs - Large (7 pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 114	, 10	,	9	, 'E03-S'	, 'Sriracha Honey Hoisin Baby Back Ribs - Small (4 pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 115	, 10	,   15	, 'E03-L'	, 'Sriracha Honey Hoisin Baby Back Ribs - Large (7 pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 116	, 10	,	9	, 'E04-S'	, 'Satay Peanut Baby Back Ribs - Small (4 pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 117	, 10	,	15	, 'E04-L'	, 'Satay Peanut Baby Back Ribs - Large (7 pc)')
	,(newid(), @restaurantId, 0, 'ENTREE'		, 118	, 10	,	11	, 'E05-L'	, 'Crispy Roasted Cornish Hen & Steamed Bok Choy')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 119	, 10	,	13	, 'E06-CH'	, 'Wok Shaken House Garlic - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 120	, 10	,	13	, 'E06-TF'	, 'Wok Shaken House Garlic - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 121	, 10	,	16	, 'E06-SB'	, 'Wok Shaken House Garlic - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 122	, 10	,	16	, 'E06-FM'	, 'Wok Shaken House Garlic - Filet Mignon')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 123	, 10	,	19	, 'E06-SS'	, 'Wok Shaken House Garlic - Sea Scallops (4)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 124	, 10	,	17	, 'E06-JS'	, 'Wok Shaken House Garlic - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 125	, 10	,	13	, 'E07-CH'	, 'Wok Seared Garlic Green Beans & Onion - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 126	, 10	,	13	, 'E07-TF'	, 'Wok Seared Garlic Green Beans & Onion - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 127	, 10	,	16	, 'E07-SB'	, 'Wok Seared Garlic Green Beans & Onion - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 128	, 10	,	16	, 'E07-FM'	, 'Wok Seared Garlic Green Beans & Onion - Filet Mignon')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 129	, 10	,	17	, 'E07-JS'	, 'Wok Seared Garlic Green Beans & Onion - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 130	, 10	,	14	, 'E07-PB'	, 'Wok Seared Garlic Green Beans & Onion - Pork Belly')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 131	, 10	,	13	, 'E08-CH'	, 'Tumeric Lemongrass Glazed - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 132	, 10	,	13	, 'E08-TF'	, 'Tumeric Lemongrass Glazed - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 133	, 10	,	16	, 'E08-SB'	, 'Tumeric Lemongrass Glazed - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 134	, 10	,	16	, 'E08-FM'	, 'Tumeric Lemongrass Glazed - Filet Mignon')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 135	, 10	,	17	, 'E08-JS'	, 'Tumeric Lemongrass Glazed - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 136	, 10	,	14	, 'E08-PB'	, 'Tumeric Lemongrass Glazed - Pork Belly')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 137	, 10	,	13	, 'E09-CH'	, 'Tamarind Basil - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 138	, 10	,	13	, 'E09-TF'	, 'Tamarind Basil - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 139	, 10	,	16	, 'E09-SB'	, 'Tamarind Basil - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 140	, 10	,	19	, 'E09-SS'	, 'Tamarind Basil - Sea Scallops (4)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 141	, 10	,	17	, 'E09-JS'	, 'Tamarind Basil - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 142	, 10	,	13	, 'E10-CH'	, 'Ginger Garlic Glazed - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 143	, 10	,	13	, 'E10-TF'	, 'Ginger Garlic Glazed - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 144	, 10	,	16	, 'E10-SB'	, 'Ginger Garlic Glazed - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 145	, 10	,	19	, 'E10-SS'	, 'Ginger Garlic Glazed - Sea Scallops (4)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 146	, 10	,	17	, 'E10-JS'	, 'Ginger Garlic Glazed - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 147	, 10	,	13	, 'E11-CH'	, 'Compound Butter - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 148	, 10	,	13	, 'E11-TF'	, 'Compound Butter - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 149	, 10	,	16	, 'E11-SB'	, 'Compound Butter - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 150	, 10	,	19	, 'E11-SS'	, 'Compound Butter - Sea Scallops (4)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 151	, 10	,	17	, 'E11-JS'	, 'Compound Butter - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 152	, 10	,	13	, 'E12-CH'	, 'Spicy Lemongrass - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 153	, 10	,	13	, 'E12-TF'	, 'Spicy Lemongrass - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 154	, 10	,	16	, 'E12-SB'	, 'Spicy Lemongrass - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 155	, 10	,	16	, 'E12-FM'	, 'Spicy Lemongrass - Filet Mignon')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 156	, 10	,	19	, 'E12-SS'	, 'Spicy Lemongrass - Sea Scallops (4)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 157	, 10	,	17	, 'E12-JS'	, 'Spicy Lemongrass - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 158	, 10	,	14	, 'E12-PB'	, 'Spicy Lemongrass - Pork Belly')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 159	, 10	,	13	, 'ES-CH'	, 'Garlic Soba - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 160	, 10	,	13	, 'ES-TF'	, 'Garlic Soba - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 161	, 10	,	16	, 'ES-SB'	, 'Garlic Soba - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 162	, 10	,	19	, 'ES-SS'	, 'Garlic Soba - Sea Scallops (4)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 163	, 10	,	17	, 'ES-JS'	, 'Garlic Soba - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 164	, 10	,	13	, 'ECS-CH'	, 'Cream Garlic Soba - Chicken')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 165	, 10	,	13	, 'ECS-TF'	, 'Cream Garlic Soba - Tofu')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 166	, 10	,	16	, 'ECS-SB'	, 'Cream Garlic Soba - Sea Bass')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 167	, 10	,	19	, 'ECS-SS'	, 'Cream Garlic Soba - Sea Scallops (4)')
	,(newid(), @restaurantId, 1, 'ENTREE'		, 168	, 10	,	17	, 'ECS-JS'	, 'Cream Garlic Soba - Jumbo Shrimp (8)')
												   
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 170, 10	,	9	, 'L01'	, 'Grilled Lemongrass Chicken Breast Slices')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 171, 10	,	9	, 'L02'	, 'Grilled Lemongrass Port Loin Slices')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 172, 10	,	9	, 'L03'	, 'Half Crispy 5-spice Cornish Hen')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 173, 10	,	9	, 'L04'	, 'Sriracha Honey Hoisin Wings (6 pc)')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 174, 10	,	9	, 'L05'	, 'Casian Wings (6 pc)')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 175, 10	,	10	, 'L06'	, 'Shaken Chicken Breast')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 176, 10	,	9	, 'L07'	, 'Garlic & Ginger Mixed Vegetables')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 177, 10	,	10	, 'L08'	, 'Sriracha Honey Hoisin Baby Back Ribs (4 pc)')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 178, 10	,	10	, 'L09'	, 'Casian Baby Back Ribs (4 pc)')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 179, 10	,	12	, 'L10'	, 'Shaken Sea Bass')
	,(newid(), @restaurantId, 0, 'LUNCHSP'		, 170, 10	,	12	, 'L11'	, 'Shaken Filet')
												 
	,(newid(), @restaurantId, 0, 'SPPADTHAI'	, 180, 10	,	10	, 'SPP-T'	, 'Pad Thai - Tofu')
	,(newid(), @restaurantId, 0, 'SPPADTHAI'	, 181, 10	,	10	, 'SPP-C'	, 'Pad Thai - Chicken')
	,(newid(), @restaurantId, 0, 'SPPADTHAI'	, 182, 10	,	11	, 'SPP-P'	, 'Pad Thai - Pork Belly')
	,(newid(), @restaurantId, 0, 'SPPADTHAI'	, 183, 10	,	13	, 'SPP-F'	, 'Pad Thai - Sea Bass')
	,(newid(), @restaurantId, 0, 'SPPADTHAI'	, 184, 10	,	14	, 'SPP-S'	, 'Pad Thai - Jumbo Shrimp')
	
	,(newid(), @restaurantId, 0, 'SPTHAIYAKI'	, 190, 10	,	10	, 'SPT-T'	, 'Thai Yakisoba - Tofu')
	,(newid(), @restaurantId, 0, 'SPTHAIYAKI'	, 191, 10	,	10	, 'SPT-C'	, 'Thai Yakisoba - Chicken')
	,(newid(), @restaurantId, 0, 'SPTHAIYAKI'	, 192, 10	,	11	, 'SPT-P'	, 'Thai Yakisoba - Pork Belly')
	,(newid(), @restaurantId, 0, 'SPTHAIYAKI'	, 193, 10	,	13	, 'SPT-F'	, 'Thai Yakisoba - Sea Bass')
	,(newid(), @restaurantId, 0, 'SPTHAIYAKI'	, 194, 10	,	14	, 'SPT-S'	, 'Thai Yakisoba - Jumbo Shrimp')
												
	,(newid(), @restaurantId, 0, 'SPYCURRY'		, 200, 10	,	10	, 'SPY-T'	, 'Yellow Curry - Tofu')
	,(newid(), @restaurantId, 0, 'SPYCURRY'		, 201, 10	,	10	, 'SPY-C'	, 'Yellow Curry - Chicken')
	,(newid(), @restaurantId, 0, 'SPYCURRY'		, 202, 10	,	11	, 'SPY-P'	, 'Yellow Curry - Pork Belly')
	,(newid(), @restaurantId, 0, 'SPYCURRY'		, 203, 10	,	13	, 'SPY-F'	, 'Yellow Curry - Sea Bass')
	,(newid(), @restaurantId, 0, 'SPYCURRY'		, 204, 10	,	14	, 'SPY-S'	, 'Yellow Curry - Jumbo Shrimp')
	,(newid(), @restaurantId, 0, 'SPYCURRY'		, 205, 10	,	18	, 'SPY-SC'	, 'Yellow Curry - Sea Scallop')
												
	,(newid(), @restaurantId, 0, 'SPRCURRY'		, 210, 10	,	10	, 'SBR-T'	, 'Red Curry - Tofu')
	,(newid(), @restaurantId, 0, 'SPRCURRY'		, 211, 10	,	10	, 'SBR-C'	, 'Red Curry - Chicken')
	,(newid(), @restaurantId, 0, 'SPRCURRY'		, 212, 10	,	11	, 'SBR-P'	, 'Red Curry - Pork Belly')
	,(newid(), @restaurantId, 0, 'SPRCURRY'		, 213, 10	,	13	, 'SBR-F'	, 'Red Curry - Sea Bass')
	,(newid(), @restaurantId, 0, 'SPRCURRY'		, 214, 10	,	14	, 'SBR-S'	, 'Red Curry - Jumbo Shrimp')
	,(newid(), @restaurantId, 0, 'SPRCURRY'		, 215, 10	,	18	, 'SBR-SC'	, 'Red Curry - Sea Scallop')
	
	,(newid(), @restaurantId, 0, 'SIDE'			, 220, 10	,	2	, 'S01'	, 'Jasmine Rice')
	,(newid(), @restaurantId, 0, 'SIDE'			, 221, 10	,	2	, 'S02'	, 'Brown Rice')
	,(newid(), @restaurantId, 0, 'SIDE'			, 222, 10	,	5	, 'S03'	, 'Garlic Green Beans')
	,(newid(), @restaurantId, 0, 'SIDE'			, 223, 10	,	3	, 'S04'	, 'Side Salad')
	,(newid(), @restaurantId, 0, 'SIDE'			, 224, 10	,	5	, 'S05'	, 'Steamed Assorted Vegetables')

	

update t set t.CategoryId = c.CategoryId
from Product t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId


-- Addon Table
INSERT INTO Addon
	 (AddonId, RestaurantId, CategoryCode, PrepareMinutes, IsModifer, Price, NameEn) 
	 VALUES
	 (newid(), @restaurantId, 'BEV', 5	, 1, 0		, 'No ice' 						)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0		, 'Little ice' 					)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0		, 'No sugar' 					)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0		, 'Less sugar' 					)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0		, 'Extra sugar' 				)

	 -- SOUP - PHO																			
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 1		,'Add Extra Meat (2 oz) for Pho'	)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 1		,'Add Extra Noodle for Pho'			)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 1.5	,'Add Assorted Veggies for Pho'		)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 3		,'Add Shrimp (3) for Pho'			)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 3		,'No green onion'					)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 3		,'No sliced onion'					)

update t set t.CategoryId = c.CategoryId
from Addon t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

UPDATE [User]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Table]		SET IsActive = 1 WHERE IsActive IS NULL		
UPDATE [Product]	SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Addon]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Category]	SET IsActive = 1 WHERE IsActive IS NULL
