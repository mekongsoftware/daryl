/* 
	Create sample order for testing
*/

USE [Restaurant]
GO
declare @restaurantId int = 102
			, @tableId int

	-- create order header
	insert into dbo.[Order]
		(RestaurantId, TableId, PartySize, OrderTime, OrderStaff, Note) values
		(@restaurantId, 1, 4, getdate(), NULL, 'First Order Example')

	-- add line items
	insert into dbo.OrderProduct
		(OrderId, ProductId, OrderTime) values
		 (1, 1, getdate())
		,(1, 2, getdate())
		,(1, 3, getdate())
		,(1, 4, getdate())

	-- add add on items
	insert into dbo.OrderProductAddon
		(OrderProductId, AddonId, OrderTime) values
		 (1, 1, getdate())
		,(2, 2, getdate())