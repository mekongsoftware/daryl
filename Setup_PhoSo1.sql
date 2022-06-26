DECLARE @restaurantId INT = 102	
DECLARE @restaurantCode VARCHAR(50) = 'PhoSo1'

EXEC DeleteRestaurantData @restaurantId
	
IF NOT EXISTS (SELECT 1 FROM [dbo].[Restaurant] WHERE RestaurantId=@restaurantId)
BEGIN
	INSERT INTO [dbo].[Restaurant] (RestaurantId) VALUES (@restaurantId)
END
UPDATE [dbo].[Restaurant] SET
	 NameEn						= 'Pho So 1'						
	,[Location]					= 'Gardena'					
	,[Code]						= @restaurantCode
    ,[Address1]					= '1749 W. Redondo Beach Blvd'				
    ,[Address2]					= ''					
    ,[City]						= 'Gardena'						
    ,[State]					= 'CA'							
    ,[Zip]						= '90247'							
    ,[Phone]					= '310-329-7365'
	-- [Hours]					= '9:00am - 9:45pm, Monday - Sunday'
    ,[TaxPercent]				= 8.35						
    ,[GroupPeople]				= 100						
    ,[GroupChargePercent]		= 15					
    ,[RecommendedTipPercent]	= 15				
    ,[CreditCardSurcharge]		= 10				
    ,[SlowOrderWarningMinutes]  = 10		
	,[RefreshIntervalSeconds]	= 20
	,[Language] = 'vi'
WHERE RestaurantId = @restaurantId				

-- User
INSERT INTO [User]
	 (UserId, RestaurantId, DefaultLanguage, [Login], NameEn) 
	 VALUES
	 (NEWID(), @restaurantId, 'en',	'Demo'				,  'Demo Account, all roles')
	,(NEWID(), @restaurantId, 'vi',	'DemoV'				,  'Demo Account (Vietnamese)')
	,(NEWID(), @restaurantId, 'vi',	'Waiter'			,  'Can take order')
	,(NEWID(), @restaurantId, 'vi',	'Preparer'			,  'Prepare Food and Beverage')
	,(NEWID(), @restaurantId, 'vi',	'Deliverer'			,  'Servicer, carry food/beverage to customer')
	,(NEWID(), @restaurantId, 'vi',	'Cashier'			,  'Cashier')
	,(NEWID(), @restaurantId, 'vi',	'Manager'			,  'Restaurant Manager')
	,(NEWID(), @restaurantId, 'vi',	'Owner'				,  'Restaurant Owner')
	,(NEWID(), @restaurantId, 'vi',	'Admin'				,  'Restaurant Admin')
	
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
	 (newid(), @restaurantId, 1,  'BEV'			, 'Beverages',									N'Thức Uống')			-- 1
	,(newid(), @restaurantId, 2,  'APPETIZER'	, 'Appetizer',									N'Khai Vị')				-- 2
	,(newid(), @restaurantId, 3,  'DESSERT'		, 'Desserts',									N'Tráng Miệng')			-- 3
	,(newid(), @restaurantId, 4,  'SPECIAL'		, 'Specialties',								N'Món Ăn Đặc Biệt')		-- 4
	,(newid(), @restaurantId, 5,  'SPBS'		, 'Specialty Beef & Shrimp',					N'Đặc Biệt Bò Tôm')		-- 5
	,(newid(), @restaurantId, 6,  'PHO'			, 'Noodle Soup of Beef',						N'Phở')					-- 6
	,(newid(), @restaurantId, 7,  'SPRN'		, 'Special Rice Soup & Pork Noodle Soup',		N'Cháo & Bánh Canh')	-- 7
	,(newid(), @restaurantId, 8,  'NOODLE'		, 'Egg Noodle',									N'Mì')					-- 8
	,(newid(), @restaurantId, 9,  'VERMICELLI'	, 'Vermicelli',									N'Bún')					-- 9
	,(newid(), @restaurantId, 10, 'RICE'		, 'Rice',										N'Cơm')					-- 10
	,(newid(), @restaurantId, 11, 'SIDE'		, 'Side Order',									N'Side Order')			-- 11
	
INSERT INTO Product 
	 (ProductId, RestaurantId, IsAddonRequired, CategoryCode, PrepareMinutes, Price, Code, NameEn, NameVi) 
	 VALUES
	 (newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'122',		'Hot filtered coffee, French style',						N'Cà phê phin')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'123',		'Hot filtered coffee with condensed milk, French style',	N'Cà phe sữa')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'124',		'Iced filtered coffee, French style',						N'Cà phê phin đá')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'125',		'Iced filtered coffee with condensed milk, French style',	N'Cà phe sữa đá')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'126',		'Fresh lemonade',											N'Nước đá chanh')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'127',		'Soybean milk',												N'Sữa đậu nành')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'128',		'Beated egg sweeten milk with soda',						N'Soda sữa hột gà')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'129',		'Squeezed orange juice',									N'Cam vắt')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'130',		'Young coconut juice',										N'Nước dừa tươi')
	,(newid(), @restaurantId, 0, 'BEV', 5, 1.95,	'131-C',	'Soft drink, Coca Cola (per glass)',						N'Soda, Coca Cola (per glass)')
	,(newid(), @restaurantId, 0, 'BEV', 5, 1.95,	'131-U',	'Soft drink, 7-up (per glass)',								N'Soda, 7-Up (per glass)')
	,(newid(), @restaurantId, 0, 'BEV', 5, 1.95,	'131-O',	'Soft drink, Orange (per glass)',							N'Soda, Orange (per glass)')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'132-C',	'Soda lemon',												N'Soda chanh')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'132-CX',	'Soda salted plum',											N'Soda chanh xí mụi')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'132-XM',	'Soda salted lemon',										N'Soda chanh muối')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'133',		'Iced tea lemonade',										N'Trà đá chanh đường')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'134',		'Thai Iced tea',											N'Trà Thái')
	,(newid(), @restaurantId, 0, 'BEV', 5, 0.50,	'135',		'Iced tea',													N'Trà đá')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'107',	'Cold rambaruttan fruit??',									N'Chôm chôm ướp lạnh')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'108',	'Cold longan fruit',										N'Nhãn ướp lạnh')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'109',	'Jelly and tropical coconut milk',							N'Sương sa hạt lựu')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'110',	'Green bean drink',											N'Chè đậu xanh')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'111',	'Red bean drink',											N'Chè đậu đỏ')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'112',	'Special three-color drink',								N'Chè ba màu')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'113',	'Jelly dry plum lotus seed & drink in glass',				N'Sâm bổ lượng')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'114',	'Dry sugar longan',											N'Nhãn nhục')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'115',	'Natural shake of custard apple',							N'Sinh tố mãng cầu')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'116',	'Natural shake of durian',									N'Sinh tố sầu riêng')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'117',	'Natural shake of jack fruit',								N'Sinh tố mít')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'118',	'Natural shake of pineapple',								N'Sinh tố thơm')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'119',	'Vitamin of natural tomato shake',							N'Sinh tố cà chua')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'120',	'Vitamin of natural vegetable drink',						N'Rau má')
	,(newid(), @restaurantId, 0, 'DESSERTS', 5, 2.85,	'121',	'Natural shake of avocado',									N'Sinh tố bơ')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'95-H',	'Grilled pork with rice vermicelli (?) with vegetable',								N'Bánh hỏi thịt heo')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'95-B',	'Grilled beef with rice vermicelli (?) with vegetable',								N'Bánh hỏi thịt bò')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'96',	'Rice vermicelli (?) with barbecue shrimp sugar cane',								N'Bánh hỏi chạo tôm')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'97',	'Grilled pork meat ball with  rice vermicelli (?) with vegetable (?)',				N'Bánh hỏi nem nướng')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'98',	'Egg roll with rice vermicelli (?) with vegetable',									N'Bánh hỏi chả giò')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'99',	'Grilled shrip with rice vermicelli (?) with vegetable',							N'Bánh hỏi tôm nướng')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 17.55, '100',	'Beef',									N'Bò nhúng dấm')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '101',	'Beef',									N'Tôm nhúng dấm')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '102',	'Beef',									N'Bò tôm nhúng dấm')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 17.55, '103',	'Beef',									N'Bò nướng vỉ')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '104',	'Beef',									N'Bò tôm nướng vỉ')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '105',	'Beef',									N'Tôm nướng vỉ')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 10.15, '106',	'Beef',									N'Bò tái chanh')
	,(newid(), @restaurantId, 1, 'SPRN', 10, 7.85,	'26',	'Special beef rice soup',									N'Cháo bò')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'27',	'Special combination of pig and organs(?) rice soup',		N'Cháo lòng heo')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'28',	'Rice soup poridge with pig blood (?)',						N'Cháo huyết heo')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'29',	'Rice (?) soup with pork legs',								N'Bánh canh giò heo')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'20',	'Chicken rice soup',										N'Cháo gà')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'31',	'Shrimp rice soup',											N'Cháo tôm')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'32',	'Duck rice soup',											N'Cháo vịt')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'33',	'Rice stick noodle soup with meat (?)',						N'Bánh canh thịt')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'34',	'Rice stick noodle (?) with shhrimp, crab meat, pork leg, port meatrice soup',	N'Bánh canh giò heo tôm cua')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'35',	'Rice stick (?) noodle with shrimp',						N'Bánh canh tôm')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì tôm cua thịt soup')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì đồ biển soup')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì bò kho soup')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì xào giòn đồ biển')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì xào mềm đò biển')		 		 
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'41',	'Duck soup with clear noodle',		N'Miến vịt')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'42',	'Chicken soup with clear noodle',	N'Miến gà')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'43',	'vermicelli',						N'Bún măng vịt')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'44',	'vermicelli',						N'Bún bò Huế')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'45',	'vermicelli',						N'Bún bì chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'46',	'vermicelli',						N'Bún chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'47-H',	'vermicelli',						N'Bún bì thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'47-B',	'vermicelli',						N'Bún bì thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'48-H',	'vermicelli',						N'Bún chạo tôm thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'48-B',	'vermicelli',						N'Bún chạo tôm thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'49',	'vermicelli',						N'Bún chạo tôm chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'50-H',	'vermicelli',						N'Bún nem nướng thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'50-B',	'vermicelli',						N'Bún nem nướng thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'51',	'vermicelli',						N'Bún nem nướng chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'52-H',	'vermicelli',						N'Bún chả giò thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'52-B',	'vermicelli',						N'Bún chả giò thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'53-H',	'vermicelli',						N'Bún chả giò thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'53-B',	'vermicelli',						N'Bún chả giò thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'54-H',	'vermicelli',						N'Bún thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'54-B',	'vermicelli',						N'Bún thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'55',	'vermicelli',						N'Bún tôm nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'56',	'vermicelli',						N'Bún tôm chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'57',	'vermicelli',						N'Bún bò xào')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'58',	'vermicelli',						N'Bún bò kho')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'59',	'vermicelli',						N'Bún bì tôm nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'60',	'rice',						N'Cơm gà xào củ hành')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'61',	'rice',						N'Cơm gà xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'62',	'rice',						N'Cơm tôm xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'63',	'rice',						N'Cơm tôm gà xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'64',	'rice',						N'Cơm tôm bò xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'65',	'rice',						N'Cơm bò xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'66',	'rice',						N'Cơm gà rôti')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'67',	'rice',						N'Cơm xào chay')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'68',	'rice',						N'Cơm bò kho')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'69',	'rice',						N'Cơm chiên Dương châu')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'70',	'rice',						N'Cơm bì chả nem nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'71',	'rice',						N'Cơm nem nướng thịt nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'72',	'rice',						N'Cơm bì chả chạo tôm')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'73',	'rice',						N'Cơm chạo tôm thịt nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'74',	'rice',						N'Cơm sườn tôm ram')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'75',	'rice',						N'Cơm sườn ram')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'76',	'rice',						N'Cơm sườn xào chua ngọt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'77',	'rice',						N'Cơm tôm xào chua ngọt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'78',	'rice',						N'Cơm tấm sườn nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'79',	'rice',						N'Cơm tấm chả sườn nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'80',	'rice',						N'Cơm tấm bì chả sườn nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'81',	'rice',						N'Cơm tấm bì chả thịt heo nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'82',	'rice',						N'Cơm tấm bì chả thịt bò nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'83',	'rice',						N'Cơm tấm thịt bò nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'84',	'rice',						N'Cơm tấm thịt heo nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'85',	'rice',						N'Cơm tấm bì chả')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'86',	'rice',						N'Cơm tôm xào bông cải')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'87',	'rice',						N'Cơm bò xào bông cải')		
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'88',	'rice',						N'Cơm tôm bò xào bông cải')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'89',	'rice',						N'Cơm bò xào củ hành')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'90',	'rice',						N'Cơm gà xào bông cải')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'91',	'rice',						N'Bánh mì bò kho')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'92',	'rice',						N'Cơm tôm bò nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.75,	'93',	'rice',						N'Chả giò')
	,(newid(), @restaurantId, 0, 'RICE', 10, 6.55,	'94',	'rice',						N'Gỏi cuốn')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.75,	'01',	'beef noodle',				N'Đặc biệt xe lửa (tô lớn)')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'02',	'beef noodle',				N'Tái nạm gầu gân sách (tô nhỏ)')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'03',	'beef noodle',				N'Chín nạm gầu gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'04',	'beef noodle',				N'Tái chín gầu gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'05',	'beef noodle',				N'Tái chín nạm gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'06',	'beef noodle',				N'Tái nạm gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'07',	'beef noodle',				N'Tái nạm gân')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'08',	'beef noodle',				N'Tái nạm sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'09',	'beef noodle',				N'Tái chín nạm')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'10',	'beef noodle',				N'Nạm vè dòn')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'11',	'beef noodle',				N'Chín nạm vè dòn')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'12',	'beef noodle',				N'Tái nạm gầu')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'13',	'beef noodle',				N'Tái gầu')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'14',	'beef noodle',				N'Tái chín')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'15',	'beef noodle',				N'Tái nạm')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'16',	'beef noodle',				N'Tái gân')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'17',	'beef noodle',				N'Tái sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'18',	'beef noodle',				N'Tái tái')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'19',	'beef noodle',				N'Phở bò viên')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.55,	'20',	'beef noodle',				N'Bò viên')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'21',	'beef noodle',				N'Phở gà')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.75,	'22',	'beef noodle',				N'Phở tôm')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.85,	'23',	'beef noodle',				N'Phở bò kho')
	,(newid(), @restaurantId, 0, 'PHO', 5, 9.55,	'24',	'beef noodle',				N'Phở áp chảo')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'25',	'beef noodle',				N'Phở bông cải xanh đậu hũ')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X-1',	'Shrimp Sauce',				N'Mắm nêm')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X-1',	'Fish Sauce',				N'Nước mắm')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X-2',	'Vermicelli only',			N'Bún không')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X-3',	'Noodle only',				N'Mì không')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 3.00,	'X-3',	'Pho broth',				N'Nước phở')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 3.00,	'X-3',	'Pho noodle only',			N'Bánh phở')

update t set t.CategoryId = c.CategoryId
from Product t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId


-- Addon Table
INSERT INTO Addon
	 (AddonId, RestaurantId, CategoryCode, PrepareMinutes, Price, IsModifer, NameEn, NameVi) 
	 VALUES
 	 (newid(), @restaurantId, 'PHO'		, 5, 1, 2.00, 'Extra beef ball soup',				N'Thêm chén bò viên')
	,(newid(), @restaurantId, 'PHO'		, 5, 1, 2.00, 'Extra rare steak',					N'Thêm dĩa tái')
	,(newid(), @restaurantId, 'PHO'		, 5, 0, 5.55, 'Large bowl of noodle and soup', 	N'Bánh nước (nhỏ)')
	,(newid(), @restaurantId, 'PHO'		, 5, 0, 4.76, 'Large bowl of noodle and soup', 	N'Bánh nước (lớn)')
	,(newid(), @restaurantId, 'PHO'		, 5, 0, 0.00, 'Onion in broth', 					N'Hành chần nước béo')
	,(newid(), @restaurantId, 'PHO'		, 5, 0, 0.00, 'Sliced Onion with vinegar', 		N'Hành dấm')
	,(newid(), @restaurantId, 'PHO'		, 5, 1, 0.00, 'Clear broth', 						N'Nước trong')			-- added
	,(newid(), @restaurantId, 'PHO'		, 5, 1, 0.00, 'Less noodle', 						N'Ít phở')
	,(newid(), @restaurantId, 'PHO'		, 5, 1, 0.00, 'No green onion', 					N'Không hành lá')
	,(newid(), @restaurantId, 'PHO'		, 5, 1, 0.00, 'No onion', 							N'Không hành củ')
	,(newid(), @restaurantId, 'BEV'		, 5, 1, 0.00, 'No ice', 							N'Không đá')
	,(newid(), @restaurantId, 'BEV'		, 5, 1, 0.00, 'Little ice', 						N'Ít đá')
	,(newid(), @restaurantId, 'BEV'		, 5, 1, 0.00, 'No sugar', 							N'Không đường')
	,(newid(), @restaurantId, 'BEV'		, 5, 1, 0.00, 'Less sugar', 						N'Ít đường')
	,(newid(), @restaurantId, 'BEV'		, 5, 1, 0.00, 'Extra sugar', 						N'Thêm đường')
	,(newid(), @restaurantId, 'RICE'	, 5, 1, 0.00, 'Extra rice', 					N'Thêm cơm trắng')
	,(newid(), @restaurantId, 'RICE'	, 5, 1, 0.00, 'No onion', 					N'Không mỡ hành')
	,(newid(), @restaurantId, 'RICE'	, 5, 0, 0.00, 'Extra fish sauce', 				N'Thêm nước mắm')
	,(newid(), @restaurantId, 'RICE'	, 5, 0, 0.00, 'Extra egg', 					N'Thêm trứng')
	,(newid(), @restaurantId, 'RICE'	, 5, 0, 0.00, 'Extra bbq beef', 				N'Thêm bò nướng')
	,(newid(), @restaurantId, 'RICE'	, 5, 0, 0.00, 'Extra bbq pork', 				N'Thêm heo nướng')
	,(newid(), @restaurantId, 'RICE'	, 5, 0, 0.00, 'Extra pork rib', 				N'Thêm sường nướng')
	,(newid(), @restaurantId, 'RICE'	, 5, 0, 0.00, 'Extra egg paste', 					N'Thêm chả')
	,(newid(), @restaurantId, 'SPECIAL'	, 5, 1, 0.00, 'Fish sauce', 				N'Nước mắm')
	,(newid(), @restaurantId, 'SPECIAL'	, 5, 1, 0.00, 'Shrimp sauce', 				N'Mắm nêm')
	,(newid(), @restaurantId, 'SPECIAL'	, 5, 0, 0.00, 'Extra vegetable', 			N'Thêm rau')
	,(newid(), @restaurantId, 'SPECIAL'	, 5, 0, 0.00, 'Extra vermicelli', 			N'Thêm bún')
	,(newid(), @restaurantId, 'SPRN'	, 5, 1, 0.00, 'No onion', 						N'Không hành lá')
	,(newid(), @restaurantId, 'SPRN'	, 5, 1, 0.00, 'Extra broth', 					N'Thêm nước soup')
	,(newid(), @restaurantId, 'SPRN'	, 5, 1, 0.00, 'More noodle', 					N'Thêm bánh')
	,(newid(), @restaurantId, 'SPRN'	, 5, 1, 0.00, 'Less noodle', 					N'Ít bánh')
	,(newid(), @restaurantId, 'SPRN'	, 5, 1, 0.00, 'Extra vegetable', 				N'Thêm rau')
update t set t.CategoryId = c.CategoryId
from Addon t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

UPDATE [User]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Table]		SET IsActive = 1 WHERE IsActive IS NULL		
UPDATE [Product]	SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Addon]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Category]	SET IsActive = 1 WHERE IsActive IS NULL